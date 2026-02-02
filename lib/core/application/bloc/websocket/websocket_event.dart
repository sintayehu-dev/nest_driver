part of 'websocket_bloc.dart';

@freezed
class WebSocketEvent with _$WebSocketEvent {
  const factory WebSocketEvent.connect() = ConnectWebSocket;
  const factory WebSocketEvent.disconnect() = DisconnectWebSocket;
  const factory WebSocketEvent.reconnect() = ReconnectWebSocket;
  const factory WebSocketEvent.statusChanged(SocketConnectionStatus status) =
      WebSocketStatusChanged;
}
