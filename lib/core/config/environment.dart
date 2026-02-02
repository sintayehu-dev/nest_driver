enum Environment {
  development,
  staging,
  production,
}

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

  static const AppEnvironment development = AppEnvironment(
    environment: Environment.development,
    baseUrl: 'https://21ee1ef84882.ngrok-free.app',
    appName: 'nest_driver dev',
    enableLogging: true,
    enableCrashReporting: false,
  );

  static const AppEnvironment staging = AppEnvironment(
    environment: Environment.staging,
    baseUrl: 'https://staging-api.nest.com',
    appName: 'nest_driver staging',
    enableLogging: true,
    enableCrashReporting: true,
  );

  static const AppEnvironment production = AppEnvironment(
    environment: Environment.production,
    baseUrl: 'https://melo-backend-h304.onrender.com',
    appName: 'nest_driver',
    enableLogging: false,
    enableCrashReporting: true,
  );

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
        return development;
    }
  }

  bool get isDevelopment => environment == Environment.development;

  bool get isStaging => environment == Environment.staging;

  bool get isProduction => environment == Environment.production;
}
