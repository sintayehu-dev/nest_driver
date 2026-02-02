part of 'websocket_bloc.dart';

@freezed
class WebSocketState with _$WebSocketState {
  const factory WebSocketState.initial({
    @Default(SocketConnectionStatus.disconnected) SocketConnectionStatus status,
  }) = _Initial;
}
