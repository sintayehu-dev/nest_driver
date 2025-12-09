import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:nest_driver/core/constants/app_constants.dart';
import 'package:nest_driver/core/utils/local_storage.dart';

/// Lightweight reusable WebSocket/Socket.IO service.
@lazySingleton
class WebSocketService {
  io.Socket? _socket;

  bool get isConnected => _socket?.connected ?? false;

  /// Connects to the Socket.IO namespace `/ws`.
  ///
  /// [token] overrides the stored access token when provided.
  /// [baseUrl] overrides the default AppConstants.baseUrl.
  io.Socket connect({
    String? token,
    String? baseUrl,
    String namespace = '/ws',
    String socketPath = '/socket.io',
  }) {
    final authToken = token ?? LocalStorage.instance.getAccessToken();
    final url = _buildSocketUrl(baseUrl ?? AppConstants.baseUrl, namespace);

    _socket = io.io(
      url,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setPath(socketPath)
          .enableAutoConnect()
          .setAuth(authToken != null ? {'token': authToken} : {})
          .build(),
    );

    _registerBaseListeners(_socket!);
    return _socket!;
  }

  /// Cleanly closes the socket connection.
  void disconnect() {
    _socket?.disconnect();
    _socket = null;
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
    final sanitizedBase = base.endsWith('/')
        ? base.substring(0, base.length - 1)
        : base;
    final sanitizedNs = namespace.startsWith('/') ? namespace : '/$namespace';
    return '$sanitizedBase$sanitizedNs';
  }

  /// Attach base diagnostics listeners for connect/disconnect/errors.
  void _registerBaseListeners(io.Socket socket) {
    socket.onConnect((_) => log('🔌 WS connected: ${socket.id}'));
    socket.onDisconnect((_) => log('🔌 WS disconnected'));
    socket.onError((err) => log('🔌 WS error: $err'));
    socket.onConnectError((err) => log('🔌 WS connect error: $err'));
  }
}

