/// Environment enum for different app configurations
enum Environment {
  development,
  staging,
  production,
}

/// Environment configuration class
class AppEnvironment {
  final Environment environment;
  final String baseUrl;
  final String appName;
  final bool enableLogging;
  final bool enableCrashReporting;

  const AppEnvironment({
    required this.environment,
    required this.baseUrl,
    required this.appName,
    this.enableLogging = true,
    this.enableCrashReporting = false,
  });

  /// Development environment configuration
  static const AppEnvironment development = AppEnvironment(
    environment: Environment.development,
    baseUrl: 'https://8d9b6d3a2379.ngrok-free.app',
    appName: 'nest_driver dev',
    enableLogging: true,
    enableCrashReporting: false,
  );

  /// Staging environment configuration
  static const AppEnvironment staging = AppEnvironment(
    environment: Environment.staging,
    baseUrl: 'https://staging-api.nest.com',
    appName: 'nest_driver staging',
    enableLogging: true,
    enableCrashReporting: true,
  );

  /// Production environment configuration
  static const AppEnvironment production = AppEnvironment(
    environment: Environment.production,
    baseUrl: 'https://melo-backend-h304.onrender.com',
    appName: 'nest_driver',
    enableLogging: false,
    enableCrashReporting: true,
  );

  /// Get current environment from string
  static AppEnvironment fromString(String env) {
    switch (env.toLowerCase()) {
      case 'dev':
      case 'development':
        return development;
      case 'staging':
        return staging;
      case 'prod':
      case 'production':
        return production;
      default:
        return development; // Default to development
    }
  }

  /// Check if current environment is development
  bool get isDevelopment => environment == Environment.development;

  /// Check if current environment is staging
  bool get isStaging => environment == Environment.staging;

  /// Check if current environment is production
  bool get isProduction => environment == Environment.production;
}
