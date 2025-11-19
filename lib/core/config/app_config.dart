import 'package:nest_driver/core/config/environment.dart';

/// Global app configuration
class AppConfig {
  static AppEnvironment? _environment;

  /// Initialize app configuration with environment
  static void initialize(AppEnvironment environment) {
    _environment = environment;
  }

  /// Get current environment
  static AppEnvironment get environment {
    if (_environment == null) {
      throw Exception(
        'AppConfig not initialized. Call AppConfig.initialize() in main.dart',
      );
    }
    return _environment!;
  }

  /// Get base URL for API calls
  static String get baseUrl => environment.baseUrl;

  /// Get app name
  static String get appName => environment.appName;

  /// Check if logging is enabled
  static bool get enableLogging => environment.enableLogging;

  /// Check if crash reporting is enabled
  static bool get enableCrashReporting => environment.enableCrashReporting;

  /// Check if current environment is development
  static bool get isDevelopment => environment.isDevelopment;

  /// Check if current environment is staging
  static bool get isStaging => environment.isStaging;

  /// Check if current environment is production
  static bool get isProduction => environment.isProduction;
}

