import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/handlers/ws/websocket_service.dart';

part 'websocket_event.dart';
part 'websocket_state.dart';
part 'websocket_bloc.freezed.dart';

@injectable
class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  final WebSocketService _wsService;

  WebSocketBloc(this._wsService) : super(const WebSocketState.initial()) {
    on<ConnectWebSocket>(_onConnect);
    on<DisconnectWebSocket>(_onDisconnect);
    on<ReconnectWebSocket>(_onReconnect);
    on<WebSocketStatusChanged>(_onStatusChanged);
    // Subscribe to service status updates
    _wsService.statusStream.listen((status) {
      add(WebSocketStatusChanged(status));
    });
  }

  void _onConnect(ConnectWebSocket event, Emitter<WebSocketState> emit) {
    _wsService.connect();
  }

  void _onDisconnect(DisconnectWebSocket event, Emitter<WebSocketState> emit) {
    _wsService.disconnect();
  }

  void _onReconnect(ReconnectWebSocket event, Emitter<WebSocketState> emit) {
    _wsService.reconnect();
  }

  void _onStatusChanged(
      WebSocketStatusChanged event, Emitter<WebSocketState> emit) {
    emit(state.copyWith(status: event.status));
  }
}
