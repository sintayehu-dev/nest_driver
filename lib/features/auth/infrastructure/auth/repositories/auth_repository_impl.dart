import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/handlers/network_exceptions.dart';
import 'package:nest_driver/features/auth/domain/repositories/auth_repository.dart';
import 'package:nest_driver/features/auth/domain/entities/otplogin/otp_login_request.dart';
import 'package:nest_driver/features/auth/domain/entities/otplogin/otp_login_response.dart';
import 'package:nest_driver/features/auth/domain/entities/verifyotp/otp_verify_request.dart';
import 'package:nest_driver/features/auth/domain/entities/verifyotp/otp_verify_response.dart';
import 'package:nest_driver/features/auth/infrastructure/auth/datasources/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {

  AuthRepositoryImpl(this._remoteDataSource);
  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, OtpLoginResponse>> requestOtpLogin(
    OtpLoginRequest request,
  ) async {
    try {
      final phone = request.phoneNumber.value.getOrElse(() => '');
      final response = await _remoteDataSource.requestOtpLogin(phone);
      return right(response);
    } on DioException catch (e) {
      return left(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<Either<NetworkExceptions, OtpVerifyResponse>> verifyLoginOtp(
    OtpVerifyRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.verifyLoginOtp(request.otp);
      return right(response);
    } on DioException catch (e) {
      return left(NetworkExceptions.getDioException(e));
    }
  }
} 