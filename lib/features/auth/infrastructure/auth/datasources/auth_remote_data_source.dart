import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/core/handlers/http_service.dart';
import 'package:nest_driver/features/auth/domain/entities/otplogin/otp_login_response.dart';
import 'package:nest_driver/features/auth/domain/entities/verifyotp/otp_verify_response.dart';

abstract class AuthRemoteDataSource {
  Future<OtpLoginResponse> requestOtpLogin(String phoneNumber);
  Future<OtpVerifyResponse> verifyLoginOtp(String otp);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {


  @override
  Future<OtpLoginResponse> requestOtpLogin(String phoneNumber) async {
    try {
      final data = <String, dynamic>{
        'phone_number': phoneNumber,
      };

      final response = await getIt<HttpService>().client().post(
        '/auth/login/otp',
        data: data,
      );

      return OtpLoginResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<OtpVerifyResponse> verifyLoginOtp(String otp) async {
    try {
      final data = <String, dynamic>{
        'otp': otp,
      };

      final response = await getIt<HttpService>().client().post(
        '/auth/verify/otp',
        data: data,
      );

      return OtpVerifyResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }
} 