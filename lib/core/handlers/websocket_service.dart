import 'dart:async';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:nest_driver/core/constants/app_constants.dart';
import 'package:nest_driver/core/utils/local_storage/local_storage.dart';

/// Lightweight reusable WebSocket/Socket.IO service with auto-reconnect.
@lazySingleton
class WebSocketService {
  io.Socket? _socket;
  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;
  bool _shouldReconnect = true;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 10;
  static const Duration _reconnectDelay = Duration(seconds: 2);
  static const Duration _heartbeatInterval = Duration(seconds: 20);

  bool get isConnected => _socket?.connected ?? false;
  String? get socketId => _socket?.id;

  // Connect to the Socket.IO namespace `/ws`.
  io.Socket connect({
    String? token,
    String? baseUrl,
    String namespace = '/ws',
    String socketPath = '/socket.io',
    bool autoConnect = true,
  }) {
    final authToken = token ?? LocalStorage.instance.getAccessToken();
    final url = _buildSocketUrl(baseUrl ?? AppConstants.baseUrl, namespace);

    log('🔌 WS connecting -> url=$url, token=${authToken != null ? 'present' : 'missing'}');

    final builder = io.OptionBuilder()
        .setTransports(['websocket'])
        .setPath(socketPath)
        .enableAutoConnect()
        .enableForceNew()
        .setTimeout(10000)
        .setAuth(authToken != null ? {'token': authToken} : {})
        // Extras for servers that read from headers/query
        .setExtraHeaders(
          authToken != null ? {'Authorization': 'Bearer $authToken'} : {},
        )
        .setQuery(authToken != null ? {'token': authToken} : {});

    if (!autoConnect) {
      builder.disableAutoConnect();
    }

    _socket = io.io(url, builder.build());

    _registerBaseListeners(_socket!);
    _registerAuthListeners(_socket!);
    _setupAutoReconnect();
    _startHeartbeat();
    
    if (!autoConnect) {
      _socket!.connect();
    }
    return _socket!;
  }

  /// Enable auto-reconnect (default: true)
  void enableAutoReconnect() {
    _shouldReconnect = true;
  }

  /// Disable auto-reconnect
  void disableAutoReconnect() {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
  }

  /// Cleanly closes the socket connection.
  void disconnect() {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _heartbeatTimer?.cancel();
    if (_socket != null) {
      log('🔌 WS disconnect requested (id=${_socket?.id})');
    }
    _socket?.disconnect();
    _socket = null;
    _reconnectAttempts = 0;
  }

  /// Register a listener for a specific event.
  void on(String event, Function(dynamic data) handler) {
    _socket?.on(event, handler);
  }

  /// Remove a specific listener (or all) for an event.
  void off(String event, [void Function(dynamic data)? handler]) {
    _socket?.off(event, handler);
  }

  /// Emit an event with optional ack callback support.
  void emit(String event, dynamic data, [void Function(dynamic resp)? ack]) {
    if (ack != null) {
      _socket?.emitWithAck(
        event,
        data,
        ack: (resp) => ack(resp),
      );
      return;
    }
    _socket?.emit(event, data);
  }

  String _buildSocketUrl(String base, String namespace) {
    // Parse the base URL to handle ports correctly
    final uri = Uri.parse(base);

    // Remove default ports to avoid :0 or incorrect parsing
    String hostWithPort;
    if (uri.scheme == 'https') {
      hostWithPort = uri.hasPort && uri.port != 443
          ? '${uri.host}:${uri.port}'
          : uri.host;
    } else if (uri.scheme == 'http') {
      hostWithPort = uri.hasPort && uri.port != 80
          ? '${uri.host}:${uri.port}'
          : uri.host;
    } else {
      hostWithPort = uri.hasPort ? '${uri.host}:${uri.port}' : uri.host;
    }

    // Clean up path
    var cleanPath = uri.path;
    if (cleanPath.endsWith('/')) {
      cleanPath = cleanPath.substring(0, cleanPath.length - 1);
    }

    final sanitizedNs = namespace.startsWith('/') ? namespace : '/$namespace';
    final finalUrl = '${uri.scheme}://$hostWithPort$cleanPath$sanitizedNs';

    log('🔌 Building WebSocket URL: $finalUrl (from base: $base)');
    return finalUrl;
  }

  /// Setup auto-reconnect logic
  void _setupAutoReconnect() {
    if (_socket == null) return;
    
    _socket!.onDisconnect((_) {
      log('🔌 WS disconnected');
      _reconnectAttempts = 0;
      if (_shouldReconnect && _socket != null) {
        _scheduleReconnect();
      }
    });

    _socket!.onConnect((_) {
      log('🔌 WS connected: ${_socket?.id}');
      _reconnectAttempts = 0;
      _reconnectTimer?.cancel();
    });

    _socket!.onReconnect((_) {
      log('🔌 WS reconnected: ${_socket?.id}');
      _reconnectAttempts = 0;
    });

    _socket!.onReconnectAttempt((attempt) {
      log('🔌 WS reconnect attempt: $attempt');
      _reconnectAttempts = attempt;
    });

    _socket!.onReconnectError((err) {
      log('🔌 WS reconnect error: $err');
      if (_reconnectAttempts >= _maxReconnectAttempts) {
        log('❌ WS max reconnect attempts reached');
        _shouldReconnect = false;
      }
    });

    _socket!.onError((err) {
      log('🔌 WS error: $err');
    });

    _socket!.onConnectError((err) {
      log('🔌 WS connect error: $err');
      if (_shouldReconnect && !isConnected) {
        _scheduleReconnect();
      }
    });
  }

  /// Schedule reconnection attempt
  void _scheduleReconnect() {
    if (!_shouldReconnect || _reconnectAttempts >= _maxReconnectAttempts) {
      return;
    }

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(_reconnectDelay, () {
      if (_shouldReconnect && _socket != null && !isConnected) {
        _reconnectAttempts++;
        log('🔄 WS attempting reconnect ($_reconnectAttempts/$_maxReconnectAttempts)...');
        try {
          _socket!.connect();
        } catch (e) {
          log('❌ WS reconnect exception: $e');
          _scheduleReconnect();
        }
      }
    });
  }

  /// Start heartbeat to maintain connection
  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (timer) {
      if (isConnected && _socket != null) {
        try {
          _socket!.emit('ping', {'timestamp': DateTime.now().toIso8601String()});
        } catch (e) {
          log('❌ WS heartbeat error: $e');
        }
      }
    });
  }

  /// Attach base diagnostics listeners for connect/disconnect/errors.
  void _registerBaseListeners(io.Socket socket) {
    // Base listeners are now handled in _setupAutoReconnect
  }

  void _registerAuthListeners(io.Socket socket) {
    socket.on('auth:success', (data) {
      log('🔌 WS auth:success $data');
    });
    socket.on('auth:error', (data) {
      log('🔌 WS auth:error $data');
    });
  }
}

