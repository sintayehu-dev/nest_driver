import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/constants/app_constants.dart';
import 'package:nest_driver/core/handlers/token_interceptor.dart';

@lazySingleton
class HttpService {
  Dio client({bool requireAuth = false, bool isMultipart = false}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: {
          'accept': 'application/json',
          'Content-Type': isMultipart ? 'multipart/form-data' : 'application/json',
        },
      ),
    );
    if (requireAuth) {
      dio.interceptors.add(TokenInterceptor(requireAuth: requireAuth, dio: dio));
    }
    dio.interceptors.add(LogInterceptor());
    return dio;
  }
}
