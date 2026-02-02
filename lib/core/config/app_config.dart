import 'package:nest_driver/core/config/environment.dart';

class AppConfig {
  static AppEnvironment? _environment;

  static void initialize(AppEnvironment environment) {
    _environment = environment;
  }

  static AppEnvironment get environment {
    if (_environment == null) {
      throw Exception(
        'AppConfig not initialized. Call AppConfig.initialize() in main.dart',
      );
    }
    return _environment!;
  }

  static String get baseUrl => environment.baseUrl;

  static String get appName => environment.appName;

  static bool get enableLogging => environment.enableLogging;

  static bool get enableCrashReporting => environment.enableCrashReporting;

  static bool get isDevelopment => environment.isDevelopment;

  static bool get isStaging => environment.isStaging;

  static bool get isProduction => environment.isProduction;
}

