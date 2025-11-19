import 'package:dartz/dartz.dart';
import 'package:nest_driver/core/handlers/network_exceptions.dart';
import 'package:nest_driver/features/driver/registration/domain/entities/driver_registration_request.dart';
import 'package:nest_driver/features/driver/registration/domain/entities/driver_registration_response.dart';

abstract class DriverRegistrationRepository {
  Future<Either<NetworkExceptions, DriverRegistrationResponse>> registerDriver(
    DriverRegistrationRequest request,
  );
}

