import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/constants/app_constants.dart';
import 'package:nest_driver/core/utils/local_storage/local_storage.dart';
import 'package:nest_driver/features/auth/domain/entities/verifyotp/otp_verify_response.dart';

@lazySingleton
class TokenRefreshService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  bool _isRefreshing = false;

  Future<String?> refreshAccessToken() async {
    if (_isRefreshing) {
      await Future.doWhile(() => _isRefreshing);
      return LocalStorage.instance.getAccessToken();
    }

    _isRefreshing = true;

    try {
      final refreshToken = LocalStorage.instance.getRefreshToken();
      if (refreshToken == null) {
        _isRefreshing = false;
        return null;
      }

      final response = await _dio.post(
        '/auth/refresh',
        data: {
          'refresh_token': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        final otpVerifyResponse = OtpVerifyResponse.fromJson(response.data);

        final accessToken = otpVerifyResponse.data.accessToken;
        final refreshToken = otpVerifyResponse.data.refreshToken;

        if (accessToken != null && refreshToken != null) {
          await LocalStorage.instance.setAccessToken(accessToken);
          await LocalStorage.instance.setRefreshToken(refreshToken);

          final user = otpVerifyResponse.data.user;
          if (user != null) {
            await LocalStorage.instance.setUserData(user.toJson());
          }

          _isRefreshing = false;
          return accessToken;
        } else {
          _isRefreshing = false;
          return null;
        }
      } else {
        _isRefreshing = false;
        return null;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        await LocalStorage.instance.clearUserSession();
      }

      _isRefreshing = false;
      return null;
    } catch (e) {
      _isRefreshing = false;
      return null;
    }
  }

  bool isAccessTokenExpired() {
    final token = LocalStorage.instance.getAccessToken();
    if (token == null) return true;

    return false;
  }

  Future<String?> getValidAccessToken() async {
    final currentToken = LocalStorage.instance.getAccessToken();

    if (currentToken == null) {
      return null;
    }

    if (isAccessTokenExpired()) {
      return await refreshAccessToken();
    }

    return currentToken;
  }

  Future<void> clearTokens() async {
    await LocalStorage.instance.clearUserSession();
  }
}
