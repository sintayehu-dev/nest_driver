import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/handlers/network_exceptions.dart';
import 'package:nest_driver/features/driver/location/domain/entities/driver_location_update.dart';
import 'package:nest_driver/features/driver/location/domain/entities/location_update_ack.dart';
import 'package:nest_driver/features/driver/location/domain/repositories/driver_location_repository.dart';
import 'package:nest_driver/features/driver/location/infrastructure/datasources/driver_location_remote_data_source.dart';

@Injectable(as: DriverLocationRepository)
class DriverLocationRepositoryImpl implements DriverLocationRepository {
  DriverLocationRepositoryImpl(this._remote);

  final DriverLocationRemoteDataSource _remote;

  @override
  Stream<Either<NetworkExceptions, LocationUpdateAck>> streamLiveLocation(
    Stream<DriverLocationUpdate> updates,
  ) {
    final controller =
        StreamController<Either<NetworkExceptions, LocationUpdateAck>>();

    late final StreamSubscription<LocationUpdateAck> sub;
    sub = _remote.streamLiveLocation(updates).listen(
      (ack) => controller.add(right(ack)),
      onError: (error, _) => controller.add(left(_mapError(error))),
      onDone: controller.close,
    );

    controller.onCancel = () async {
      await sub.cancel();
    };

    return controller.stream;
  }

  NetworkExceptions _mapError(dynamic error) {
    if (error is NetworkExceptions) return error;
    if (error is SocketException) {
      return const NetworkExceptions.noInternetConnection();
    }
    return NetworkExceptions.defaultError(error.toString());
  }
}

