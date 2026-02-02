import 'dart:async';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/handlers/ws/websocket_service.dart';
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

    // Listen to updates from the bloc and emit them if WS is connected
    final updateSub = updates.listen(
      (update) {
        if (!_ws.isConnected) {
          log('🔌 WS not connected, skipping update');
          return;
        }
        _emitUpdate(update, controller);
      },
      onError: (error) {
        log('🔌 Update stream error: $error');
        controller.addError(error);
      },
      onDone: () {
        log('🔌 Update stream done');
        controller.close();
      },
    );

    // Also listen for explicit backend errors
    final locErrorHandler = (dynamic data) {
      log('🔌 Received location:error: $data');
      if (!controller.isClosed) {
        controller.addError(
          Exception(
            data is Map && data['message'] != null
                ? data['message'].toString()
                : 'location:error',
          ),
        );
      }
    };
    _ws.on('location:error', locErrorHandler);

    // Clean up when the consumer cancels the stream
    controller.onCancel = () async {
      _ws.off('location:error', locErrorHandler);
      await updateSub.cancel();
    };

    // If already connected, notify immediately
    if (_ws.isConnected) {
      onConnected?.call();
    } else {
      // Or wait for connection
      // We don't force connect here anymore
    }

    return controller.stream;
  }

  void _emitUpdate(
    DriverLocationUpdate update,
    StreamController<LocationUpdateAck> controller,
  ) {
    _ws.emit(
      'location:update',
      update.toJson(),
      (resp) {
        if (controller.isClosed) return;
        try {
          if (resp is Map<String, dynamic>) {
            final ack = LocationUpdateAck.fromJson(resp);
            controller.add(ack);
          } else {
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
