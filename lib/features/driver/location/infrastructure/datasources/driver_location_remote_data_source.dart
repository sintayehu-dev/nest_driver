import 'dart:async';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/handlers/websocket_service.dart';
import 'package:nest_driver/features/driver/location/domain/entities/driver_location_update.dart';
import 'package:nest_driver/features/driver/location/domain/entities/location_update_ack.dart';

abstract class DriverLocationRemoteDataSource {
  Stream<LocationUpdateAck> streamLiveLocation(
    Stream<DriverLocationUpdate> updates, {
    void Function()? onConnected,
  });
}

@Injectable(as: DriverLocationRemoteDataSource)
class DriverLocationRemoteDataSourceImpl
    implements DriverLocationRemoteDataSource {
  DriverLocationRemoteDataSourceImpl(this._ws);

  final WebSocketService _ws;

  @override
  Stream<LocationUpdateAck> streamLiveLocation(
    Stream<DriverLocationUpdate> updates, {
    void Function()? onConnected,
  }) {
    final controller = StreamController<LocationUpdateAck>();
    final pendingUpdates = <DriverLocationUpdate>[];
    bool connectionEstablished = false;

    // Connect if not already connected
    if (!_ws.isConnected) {
      log('🔌 Connecting WebSocket...');
      _ws.connect();
      
      // Set up connection listener
      void onConnect(dynamic _) {
        log('🔌 WebSocket connected, processing ${pendingUpdates.length} pending updates');
        connectionEstablished = true;
        onConnected?.call();
        
        // Process pending updates
        for (final update in pendingUpdates) {
          _emitUpdate(update, controller);
        }
        pendingUpdates.clear();
      }
      
      _ws.on('connect', onConnect);
      
      // Clean up listener on cancel
      final originalOnCancel = controller.onCancel;
      controller.onCancel = () async {
        _ws.off('connect', onConnect);
        await originalOnCancel?.call();
      };
    } else {
      connectionEstablished = true;
      log('🔌 WebSocket already connected');
    }

    void emitUpdate(DriverLocationUpdate update) {
      if (!connectionEstablished || !_ws.isConnected) {
        log('🔌 Queueing update (not connected yet)');
        pendingUpdates.add(update);
        return;
      }
      _emitUpdate(update, controller);
    }

    final locErrorHandler = (dynamic data) {
      log('🔌 Received location:error: $data');
      controller.addError(
        Exception(
          data is Map && data['message'] != null
              ? data['message'].toString()
              : 'location:error',
        ),
      );
    };

    _ws.on('location:error', locErrorHandler);

    final sub = updates.listen(
      emitUpdate,
      onError: (error) {
        log('🔌 Update stream error: $error');
        controller.addError(error);
      },
      onDone: () {
        log('🔌 Update stream done');
        controller.close();
      },
    );

    final originalOnCancel = controller.onCancel;
    controller.onCancel = () async {
      log('🔌 Cancelling location stream');
      _ws.off('location:error', locErrorHandler);
      await sub.cancel();
      
      // Disconnect WebSocket when stream is cancelled
      if (_ws.isConnected) {
        log('🔌 Disconnecting WebSocket');
        _ws.disconnect();
      }
      
      await originalOnCancel?.call();
    };

    return controller.stream;
  }

  void _emitUpdate(
    DriverLocationUpdate update,
    StreamController<LocationUpdateAck> controller,
  ) {
    if (!_ws.isConnected) {
      log('🔌 Cannot emit: WebSocket not connected');
      return;
    }

    log('🔌 Emitting location update: ${update.lat}, ${update.lon}');
    _ws.emit(
      'location:update',
      update.toJson(),
      (resp) {
        try {
          if (resp is Map<String, dynamic>) {
            final ack = LocationUpdateAck.fromJson(resp);
            log('🔌 Location update ack: success=${ack.success}');
            controller.add(ack);
          } else {
            log('🔌 Unexpected ack format: $resp');
            controller.add(
              LocationUpdateAck.fromJson(
                {
                  'success': false,
                  'message': resp?.toString() ?? 'Unknown response',
                  'timestamp': DateTime.now().toIso8601String(),
                },
              ),
            );
          }
        } catch (e, st) {
          log('🔌 location:update ack parsing failed: $e', stackTrace: st);
          controller.addError(e, st);
        }
      },
    );
  }
}

