import 'package:dartz/dartz.dart';
import 'package:nest_driver/core/handlers/network_exceptions.dart';
import 'package:nest_driver/features/driver/location/domain/entities/driver_location_update.dart';
import 'package:nest_driver/features/driver/location/domain/entities/location_update_ack.dart';

abstract class DriverLocationRepository {
  Stream<Either<NetworkExceptions, LocationUpdateAck>> streamLiveLocation(
    Stream<DriverLocationUpdate> updates,
  );
}

