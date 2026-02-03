import 'dart:async';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/constants/app_constants.dart';
import 'package:nest_driver/core/utils/local_storage/local_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

enum SocketConnectionStatus {
  connecting,
  connected,
  reconnecting,
  disconnected,
  error,
}

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

  final _statusController =
      StreamController<SocketConnectionStatus>.broadcast();

  Stream<SocketConnectionStatus> get statusStream => _statusController.stream;

  bool get isConnected => _socket?.connected ?? false;
  String? get socketId => _socket?.id;

  io.Socket connect({
    String? token,
    String? baseUrl,
    String namespace = '/ws',
    String socketPath = '/socket.io',
    bool autoConnect = true,
  }) {
    if (isConnected) {
      log('🔌 WS already connected');
      return _socket!;
    }

    final authToken = token ?? LocalStorage.instance.getAccessToken();
    if (authToken == null) {
      log('❌ WS connection failed: No auth token found.');
      _statusController.add(SocketConnectionStatus.error);
      return _socket ?? io.io('http://localhost', <String, dynamic>{});
    }

    _statusController.add(SocketConnectionStatus.connecting);

    final url = _buildSocketUrl(baseUrl ?? AppConstants.baseUrl, namespace);
    log('🔌 WS connecting -> url=$url');

    final builder = io.OptionBuilder()
        .setTransports(['websocket'])
        .setPath(socketPath)
        .enableForceNew()
        .setTimeout(10000)
        .setAuth({'token': authToken})
        .setExtraHeaders({'Authorization': 'Bearer $authToken'})
        .setQuery({'token': authToken});

    if (!autoConnect) {
      builder.disableAutoConnect();
    } else {
      builder.enableAutoConnect();
    }

    _socket = io.io(url, builder.build());

    _setupListeners();
    _startHeartbeat();

    if (!autoConnect) {
      _socket!.connect();
    }

    return _socket!;
  }

  void reconnect() {
    log('🔄 WS manual reconnect triggered');
    disconnect();
    _shouldReconnect = true;
    _reconnectAttempts = 0;
    connect();
  }

  void enableAutoReconnect() {
    _shouldReconnect = true;
  }

  void disableAutoReconnect() {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
  }

  void disconnect() {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();
    _heartbeatTimer?.cancel();
    if (_socket != null) {
      log('🔌 WS disconnect requested (id=${_socket?.id})');
      _socket?.disconnect();
      _socket = null;
    }
    _reconnectAttempts = 0;
    _statusController.add(SocketConnectionStatus.disconnected);
  }

  void on(String event, Function(dynamic data) handler) {
    _socket?.on(event, handler);
  }

  void off(String event, [void Function(dynamic data)? handler]) {
    _socket?.off(event, handler);
  }

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
    final uri = Uri.parse(base);
    String hostWithPort;
    if (uri.scheme == 'https') {
      hostWithPort =
          uri.hasPort && uri.port != 443 ? '${uri.host}:${uri.port}' : uri.host;
    } else if (uri.scheme == 'http') {
      hostWithPort =
          uri.hasPort && uri.port != 80 ? '${uri.host}:${uri.port}' : uri.host;
    } else {
      hostWithPort = uri.hasPort ? '${uri.host}:${uri.port}' : uri.host;
    }

    var cleanPath = uri.path;
    if (cleanPath.endsWith('/')) {
      cleanPath = cleanPath.substring(0, cleanPath.length - 1);
    }

    final sanitizedNs = namespace.startsWith('/') ? namespace : '/$namespace';
    return '${uri.scheme}://$hostWithPort$cleanPath$sanitizedNs';
  }

  void _setupListeners() {
    if (_socket == null) return;

    _socket!.onConnect((_) {
      log('🔌 WS connected: ${_socket?.id}');
      _reconnectAttempts = 0;
      _reconnectTimer?.cancel();
      _statusController.add(SocketConnectionStatus.connected);
    });

    _socket!.onDisconnect((_) {
      log('🔌 WS disconnected');
      _statusController.add(SocketConnectionStatus.disconnected);
      if (_shouldReconnect) {
        _scheduleReconnect();
      }
    });

    _socket!.onReconnect((_) {
      log('🔌 WS reconnected');
      _reconnectAttempts = 0;
      _statusController.add(SocketConnectionStatus.connected);
    });

    _socket!.onReconnectAttempt((attempt) {
      log('🔌 WS reconnect attempt: $attempt');
      _reconnectAttempts = attempt;
      _statusController.add(SocketConnectionStatus.reconnecting);
    });

    _socket!.onReconnectError((err) {
      log('🔌 WS reconnect error: $err');
      if (_reconnectAttempts >= _maxReconnectAttempts) {
        log('❌ WS max reconnect attempts reached');
        _shouldReconnect = false;
        _statusController.add(SocketConnectionStatus.error);
      }
    });

    _socket!.onError((err) {
      log('🔌 WS error: $err');
      _statusController.add(SocketConnectionStatus.error);
    });

    _socket!.onConnectError((err) {
      log('🔌 WS connect error: $err');
      _statusController.add(SocketConnectionStatus.error);
      if (_shouldReconnect && !isConnected) {
        _scheduleReconnect();
      }
    });

    _socket!.on('auth:success', (data) {
      log('🔌 WS auth:success $data');
    });

    _socket!.on('auth:error', (data) {
      log('🔌 WS auth:error $data');
      _statusController.add(SocketConnectionStatus.error);
    });
  }

  void _scheduleReconnect() {
    if (!_shouldReconnect || _reconnectAttempts >= _maxReconnectAttempts) {
      return;
    }

    _statusController.add(SocketConnectionStatus.reconnecting);

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

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (timer) {
      if (isConnected && _socket != null) {
        try {
          _socket!
              .emit('ping', {'timestamp': DateTime.now().toIso8601String()});
        } catch (e) {
          log('❌ WS heartbeat error: $e');
        }
      }
    });
  }
}
