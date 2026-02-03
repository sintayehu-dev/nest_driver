import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/core/handlers/http_service.dart';
import 'package:nest_driver/features/auth/domain/entities/otplogin/otp_login_response.dart';
import 'package:nest_driver/features/auth/domain/entities/verifyotp/otp_verify_response.dart';
import 'package:nest_driver/features/auth/domain/entities/profile_update/profile_update_request.dart';
import 'package:nest_driver/features/auth/domain/entities/profile_update/profile_update_response.dart';

abstract class AuthRemoteDataSource {
  Future<OtpLoginResponse> requestOtpLogin(String phoneNumber);
  Future<OtpVerifyResponse> verifyLoginOtp(String otp);
  Future<ProfileUpdateResponse> updateProfile(ProfileUpdateRequest request);
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

  @override
  Future<ProfileUpdateResponse> updateProfile(
      ProfileUpdateRequest request) async {
    try {
      final data = request.toJson();
      data.removeWhere((key, value) => value == null);

      final response =
          await getIt<HttpService>().client(requireAuth: true).patch(
                '/users/me',
                data: data,
              );

      return ProfileUpdateResponse.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException {
      rethrow;
    }
  }
}
