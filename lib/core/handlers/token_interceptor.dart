import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/navigation/navigation_service.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/presentation/widgets/app_helpers.dart';
import 'package:nest_driver/core/utils/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:nest_driver/core/services/token_refresh_service.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final bool requireAuth;

  TokenInterceptor({required this.requireAuth, required this.dio});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = LocalStorage.instance.getAccessToken();
    if (requireAuth && accessToken != null) {
      options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Only handle 401s for requests that were actually sent with an Authorization header
      // to avoid treating login/register credential errors as session expiry.
      final authHeader =
          (err.requestOptions.headers['Authorization'] as String?);
      final sentWithBearer =
          authHeader != null && authHeader.startsWith('Bearer ');
      if (!requireAuth || !sentWithBearer) {
        return handler.next(err);
      }
      // Treat any 401 on protected requests as an auth failure: try refresh once, then logout.
      // Prevent infinite retry loops
      final alreadyRetried = err.requestOptions.extra['retryAttempted'] == true;
      if (!alreadyRetried) {
        try {
          final tokenRefreshService = getIt<TokenRefreshService>();
          final newToken = await tokenRefreshService.refreshAccessToken();
          if (newToken != null && newToken.isNotEmpty) {
            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newToken';
            options.extra['retryAttempted'] = true;
            final response = await dio.fetch(options);
            return handler.resolve(response);
          }
        } catch (_) {
          // ignore and fall through to logout
        }
      }

      // Refresh failed or second 401: clear session and navigate to login
      await LocalStorage.instance.clearUserSession();

      final context = NavigationService.currentContext;
      if (context != null) {
        final isOnLoginScreen =
            ModalRoute.of(context)?.settings.name == RouteName.login;
        if (!isOnLoginScreen) {
          AppHelpers.showCheckFlash(
            context,
            'Session expired. Please login again.',
          );
          context.goNamed(RouteName.login);
        }
      } else {
        // Fallback: attempt navigation via global router if registered
        try {
          final router = getIt<GoRouter>();
          router.goNamed(RouteName.login);
        } catch (_) {}
      }
      return;
    }
    return handler.next(err);
  }
}
