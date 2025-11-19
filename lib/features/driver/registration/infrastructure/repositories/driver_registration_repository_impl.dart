import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/handlers/network_exceptions.dart';
import 'package:nest_driver/features/driver/registration/domain/entities/driver_registration_request.dart';
import 'package:nest_driver/features/driver/registration/domain/entities/driver_registration_response.dart';
import 'package:nest_driver/features/driver/registration/domain/repositories/driver_registration_repository.dart';
import 'package:nest_driver/features/driver/registration/infrastructure/datasources/driver_registration_remote_data_source.dart';

@Injectable(as: DriverRegistrationRepository)
class DriverRegistrationRepositoryImpl implements DriverRegistrationRepository {

  DriverRegistrationRepositoryImpl(this._remoteDataSource);
  final DriverRegistrationRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, DriverRegistrationResponse>> registerDriver(
    DriverRegistrationRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.registerDriver(request);
      return right(response);
    } on DioException catch (e) {
      return left(NetworkExceptions.getDioException(e));
    }
  }
}

