import 'dart:async';
import 'dart:developer';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:nest_driver/core/config/app_config.dart';
import 'package:nest_driver/features/driver/location/domain/entities/driver_status.dart';

/// Service for managing background location tracking and WebSocket connection
@lazySingleton
class BackgroundLocationService {
  BackgroundLocationService();

  StreamSubscription<Position>? _locationSubscription;
  Timer? _heartbeatTimer;
  bool _isRunning = false;

  /// Check if background service is running
  bool get isRunning => _isRunning;

  /// Initialize and start the background service
  Future<void> start() async {
    if (_isRunning) {
      log('📍 Background service already running');
      return;
    }

    try {
      // Store base URL in SharedPreferences for background isolate
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('base_url', AppConfig.baseUrl);

      final service = FlutterBackgroundService();

      // Check if service is already running
      final isRunning = await service.isRunning();
      if (isRunning) {
        service.invoke('stop');
        await Future.delayed(const Duration(milliseconds: 500));
      }

      await service.configure(
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          autoStart: false,
          isForegroundMode: true,
          notificationChannelId: 'driver_location_channel',
          initialNotificationTitle: 'Driver is available',
          initialNotificationContent:
              'Tracking location and receiving trip requests',
          foregroundServiceNotificationId: 1001,
        ),
        iosConfiguration: IosConfiguration(
          autoStart: false,
          onForeground: onStart,
          onBackground: onIosBackground,
        ),
      );

      await service.startService();
      _isRunning = true;
      log('📍 Background service started');
    } catch (e) {
      log('❌ Failed to start background service: $e');
      rethrow;
    }
  }

  /// Stop the background service
  Future<void> stop() async {
    if (!_isRunning) {
      return;
    }

    try {
      await _locationSubscription?.cancel();
      _locationSubscription = null;

      _heartbeatTimer?.cancel();
      _heartbeatTimer = null;

      final service = FlutterBackgroundService();
      service.invoke('stop');

      _isRunning = false;
      log('📍 Background service stopped');
    } catch (e) {
      log('❌ Failed to stop background service: $e');
    }
  }

  /// Background service entry point
  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    // Set as foreground service for Android
    service.on('setAsForeground').listen((event) {
      if (service is AndroidServiceInstance) {
        service.setAsForegroundService();
      }
    });

    service.on('setAsBackground').listen((event) {
      if (service is AndroidServiceInstance) {
        service.setAsBackgroundService();
      }
    });

    // Initialize dependencies in isolate
    io.Socket? socket;
    StreamSubscription<Position>? locationSubscription;
    Timer? heartbeatTimer;
    Timer? reconnectTimer;
    bool shouldReconnect = true;
    int reconnectAttempts = 0;
    const maxReconnectAttempts = 10;

    // Adaptive settings
    int currentLocationInterval = 1000; // Default 1 second
    int currentHeartbeatInterval = 20000; // Default 20 seconds
    int currentReconnectDelay = 3000; // Default 3 seconds
    LocationAccuracy currentAccuracy = LocationAccuracy.high;
    bool shouldBufferUpdates = false;
    List<Map<String, dynamic>> bufferedLocations = [];

    // Get auth token from SharedPreferences
    Future<String?> getAuthToken() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        // Use the same key as LocalStorage uses
        return prefs.getString('accessToken');
      } catch (e) {
        log('❌ [Background] Failed to get auth token: $e');
        return null;
      }
    }

    // Get base URL from SharedPreferences or use default
    Future<String> getBaseUrl() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString('base_url') ??
            'https://melo-backend-h304.onrender.com'; // Default production URL
      } catch (e) {
        log('❌ [Background] Failed to get base URL: $e');
        return 'https://melo-backend-h304.onrender.com';
      }
    }

    // Map GPS priority string to LocationAccuracy
    LocationAccuracy mapGpsPriorityToAccuracy(String priority) {
      switch (priority) {
        case 'high_accuracy':
          return LocationAccuracy.high;
        case 'balanced':
          return LocationAccuracy.medium;
        case 'low_power':
          return LocationAccuracy.low;
        default:
          return LocationAccuracy.high;
      }
    }

    // Get adaptive settings from SharedPreferences
    Future<void> updateAdaptiveSettings() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        currentLocationInterval =
            prefs.getInt('adaptive_location_interval') ?? 1000;
        currentHeartbeatInterval =
            prefs.getInt('adaptive_heartbeat_interval') ?? 20000;
        currentReconnectDelay =
            prefs.getInt('adaptive_reconnect_delay') ?? 3000;
        final accuracyString =
            prefs.getString('adaptive_gps_priority') ?? 'high_accuracy';
        currentAccuracy = mapGpsPriorityToAccuracy(accuracyString);
        shouldBufferUpdates = prefs.getBool('adaptive_should_buffer') ?? false;

        log('⚙️ [Background] Adaptive settings updated: '
            'Location: ${currentLocationInterval}ms, '
            'Heartbeat: ${currentHeartbeatInterval}ms, '
            'Accuracy: $currentAccuracy, '
            'Buffer: $shouldBufferUpdates');
      } catch (e) {
        log('❌ [Background] Failed to get adaptive settings: $e');
      }
    }

    // Build WebSocket URL
    String buildSocketUrl(String baseUrl, String namespace) {
      final uri = Uri.parse(baseUrl);
      String hostWithPort;
      if (uri.scheme == 'https') {
        hostWithPort = uri.hasPort && uri.port != 443
            ? '${uri.host}:${uri.port}'
            : uri.host;
      } else {
        hostWithPort = uri.hasPort && uri.port != 80
            ? '${uri.host}:${uri.port}'
            : uri.host;
      }
      var cleanPath = uri.path;
      if (cleanPath.endsWith('/')) {
        cleanPath = cleanPath.substring(0, cleanPath.length - 1);
      }
      final sanitizedNs = namespace.startsWith('/') ? namespace : '/$namespace';
      return '${uri.scheme}://$hostWithPort$cleanPath$sanitizedNs';
    }

    // Declare function variables first to allow mutual recursion
    late void Function() scheduleReconnect;
    late Future<void> Function() connectWebSocket;
    late void Function() startLocationTracking;
    late void Function() startHeartbeat;

    // Connect WebSocket
    connectWebSocket = () async {
      if (socket != null && socket!.connected) {
        return;
      }

      try {
        final token = await getAuthToken();
        if (token == null) {
          log('⚠️ [Background] No auth token available');
          return;
        }

        final baseUrl = await getBaseUrl();
        final url = buildSocketUrl(baseUrl, '/ws');

        log('🔌 [Background] Connecting WebSocket to $url');

        final builder = io.OptionBuilder()
            .setTransports(['websocket'])
            .setPath('/socket.io')
            .enableAutoConnect()
            .enableForceNew()
            .setTimeout(10000)
            .setAuth({'token': token})
            .setExtraHeaders({'Authorization': 'Bearer $token'})
            .setQuery({'token': token});

        socket = io.io(url, builder.build());

        socket!.onConnect((_) {
          log('🔌 [Background] WebSocket connected: ${socket!.id}');
          reconnectAttempts = 0;
          reconnectTimer?.cancel();

          // Flush buffered locations
          if (bufferedLocations.isNotEmpty) {
            log('📍 [Background] Flushing ${bufferedLocations.length} buffered locations');
            for (final location in bufferedLocations) {
              socket!.emit('location:update', location);
            }
            bufferedLocations.clear();
          }
        });

        socket!.onDisconnect((_) {
          log('🔌 [Background] WebSocket disconnected');
          if (shouldReconnect && reconnectAttempts < maxReconnectAttempts) {
            scheduleReconnect();
          }
        });

        socket!.onError((err) {
          log('❌ [Background] WebSocket error: $err');
        });

        socket!.onConnectError((err) {
          log('❌ [Background] WebSocket connect error: $err');
          if (shouldReconnect) {
            scheduleReconnect();
          }
        });
      } catch (e) {
        log('❌ [Background] WebSocket connection error: $e');
        scheduleReconnect();
      }
    };

    // Schedule reconnection helper
    scheduleReconnect = () {
      if (!shouldReconnect || reconnectAttempts >= maxReconnectAttempts) {
        return;
      }

      reconnectTimer?.cancel();
      reconnectAttempts++;
      reconnectTimer = Timer(Duration(milliseconds: currentReconnectDelay), () {
        if (shouldReconnect && (socket == null || !socket!.connected)) {
          log('🔄 [Background] Reconnecting... ($reconnectAttempts/$maxReconnectAttempts)');
          connectWebSocket();
        }
      });
    };

    // Start location tracking
    startLocationTracking = () {
      locationSubscription?.cancel();

      final settings = LocationSettings(
        accuracy: currentAccuracy,
        distanceFilter: 0,
        timeLimit: Duration(milliseconds: currentLocationInterval),
      );

      log('📍 [Background] Starting location tracking with interval: ${currentLocationInterval}ms, accuracy: $currentAccuracy');

      locationSubscription = Geolocator.getPositionStream(
        locationSettings: settings,
      ).listen(
        (position) {
          // Send location update via WebSocket
          final update = {
            'booking_id': null,
            'lat': position.latitude,
            'lon': position.longitude,
            'speed': position.speed,
            'heading': position.heading,
            'accuracy': position.accuracy,
            'status': DriverStatus.available.wireValue,
            'timestamp': DateTime.now().toIso8601String(),
          };

          if (socket != null && socket!.connected) {
            try {
              socket!.emit('location:update', update);
              log('📍 [Background] Location sent: ${position.latitude}, ${position.longitude}');
            } catch (e) {
              log('❌ [Background] Failed to send location: $e');
              if (shouldBufferUpdates) {
                bufferedLocations.add(update);
                log('📦 [Background] Location buffered (${bufferedLocations.length} total)');
              }
            }
          } else {
            log('⚠️ [Background] WebSocket not connected');
            if (shouldBufferUpdates) {
              bufferedLocations.add(update);
              log('📦 [Background] Location buffered (${bufferedLocations.length} total)');
            }
            connectWebSocket();
          }
        },
        onError: (error) {
          log('❌ [Background] Location error: $error');
        },
      );
    };

    // Heartbeat to maintain connection
    startHeartbeat = () {
      heartbeatTimer?.cancel();

      log('💓 [Background] Starting heartbeat with interval: ${currentHeartbeatInterval}ms');

      heartbeatTimer = Timer.periodic(
        Duration(milliseconds: currentHeartbeatInterval),
        (timer) {
          if (socket != null && socket!.connected) {
            // Send heartbeat/ping
            socket!
                .emit('ping', {'timestamp': DateTime.now().toIso8601String()});
            log('💓 [Background] Heartbeat sent');
          } else {
            log('⚠️ [Background] WebSocket disconnected, reconnecting...');
            connectWebSocket();
          }
        },
      );
    };

    // Listen for adaptive settings updates from main app
    service.on('updateAdaptiveSettings').listen((event) async {
      await updateAdaptiveSettings();

      // Restart location tracking with new settings
      startLocationTracking();

      // Restart heartbeat with new interval
      startHeartbeat();

      // Update notification
      if (service is AndroidServiceInstance) {
        final prefs = await SharedPreferences.getInstance();
        final batteryLevel =
            prefs.getString('adaptive_battery_level') ?? 'high';
        service.setForegroundNotificationInfo(
          title: 'Driver is available ($batteryLevel battery mode)',
          content: 'Tracking location and receiving trip requests',
        );
      }
    });

    // Initial setup
    await updateAdaptiveSettings();
    await connectWebSocket();
    startLocationTracking();
    startHeartbeat();

    // Cleanup on service stop
    service.on('stop').listen((_) {
      shouldReconnect = false;
      locationSubscription?.cancel();
      heartbeatTimer?.cancel();
      reconnectTimer?.cancel();
      socket?.disconnect();
      socket?.dispose();
      socket = null;
      bufferedLocations.clear();
    });
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    return true;
  }
}
