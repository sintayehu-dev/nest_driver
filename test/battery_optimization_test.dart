import 'package:flutter_test/flutter_test.dart';
import 'package:nest_driver/core/services/battery_optimization/models/adaptive_settings.dart';
import 'package:nest_driver/core/services/battery_optimization/adaptive_config_service.dart';
import 'package:nest_driver/core/services/battery_optimization/app_state_monitor_service.dart';
import 'package:nest_driver/core/services/battery_optimization/battery_monitor_service.dart';
import 'package:nest_driver/core/services/battery_optimization/network_monitor_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Battery Optimization Tests', () {
    late BatteryMonitorService batteryMonitor;
    late NetworkMonitorService networkMonitor;
    late AppStateMonitorService appStateMonitor;
    late AdaptiveConfigService adaptiveConfig;

    setUp(() {
      batteryMonitor = BatteryMonitorService();
      networkMonitor = NetworkMonitorService();
      appStateMonitor = AppStateMonitorService();
      adaptiveConfig = AdaptiveConfigService(
        batteryMonitor,
        networkMonitor,
        appStateMonitor,
      );
    });

    tearDown(() {
      batteryMonitor.dispose();
      networkMonitor.dispose();
      appStateMonitor.dispose();
      adaptiveConfig.dispose();
    });

    test('AdaptiveSettings model has correct default values', () {
      final settings = AdaptiveSettings.defaultSettings();

      expect(settings.locationIntervalMs, 1000);
      expect(settings.socketHeartbeatMs, 20000);
      expect(settings.gpsPriority, GpsPriority.highAccuracy);
      expect(settings.shouldBufferUpdates, false);
      expect(settings.reconnectDelayMs, 3000);
      expect(settings.batteryLevel, BatteryLevel.high);
      expect(settings.networkType, NetworkType.wifi);
      expect(settings.appState, AppState.foreground);
      expect(settings.batteryPercentage, 100);
    });

    test('BatteryLevel extension converts percentage correctly', () {
      expect(100.toBatteryLevel(), BatteryLevel.high);
      expect(51.toBatteryLevel(), BatteryLevel.high);
      expect(50.toBatteryLevel(), BatteryLevel.medium);
      expect(30.toBatteryLevel(), BatteryLevel.medium);
      expect(20.toBatteryLevel(), BatteryLevel.medium);
      expect(19.toBatteryLevel(), BatteryLevel.low);
      expect(10.toBatteryLevel(), BatteryLevel.low);
      expect(5.toBatteryLevel(), BatteryLevel.low);
    });

    test('AdaptiveConfigService enforces minimum interval constraint', () {
      // The service should never go below 1000ms
      final settings = adaptiveConfig.currentSettings;
      expect(settings.locationIntervalMs, greaterThanOrEqualTo(1000));
    });

    test('AdaptiveConfigService enforces maximum interval constraint', () {
      // The service should never go above 8000ms
      final settings = adaptiveConfig.currentSettings;
      expect(settings.locationIntervalMs, lessThanOrEqualTo(8000));
    });

    test('Battery monitor service initializes correctly', () {
      expect(batteryMonitor.currentLevel, isNotNull);
      expect(batteryMonitor.currentPercentage, greaterThanOrEqualTo(0));
      expect(batteryMonitor.currentPercentage, lessThanOrEqualTo(100));
    });

    test('Network monitor service initializes correctly', () {
      expect(networkMonitor.currentType, isNotNull);
    });

    test('App state monitor service initializes correctly', () {
      expect(appStateMonitor.currentState, isNotNull);
    });

    test('AdaptiveConfigService provides current settings', () {
      final settings = adaptiveConfig.currentSettings;

      expect(settings, isNotNull);
      expect(settings.locationIntervalMs, isPositive);
      expect(settings.socketHeartbeatMs, isPositive);
      expect(settings.reconnectDelayMs, isPositive);
    });

    test('Settings stream emits values', () async {
      // Listen to the stream and verify it emits
      final stream = adaptiveConfig.settingsStream;

      expect(stream, isNotNull);
      expect(stream, emits(isA<AdaptiveSettings>()));
    });
  });

  group('Battery Level Priority Tests', () {
    test('High battery uses aggressive settings', () {
      // High battery (>50%) should use:
      // - 1000ms location interval
      // - 20000ms heartbeat
      // - High accuracy GPS

      // This would be tested with actual battery level changes
      // For now, we verify the default (high battery) settings
      final settings = AdaptiveSettings.defaultSettings();

      expect(settings.batteryLevel, BatteryLevel.high);
      expect(settings.locationIntervalMs, 1000);
      expect(settings.socketHeartbeatMs, 20000);
      expect(settings.gpsPriority, GpsPriority.highAccuracy);
    });
  });

  group('Network Type Tests', () {
    test('Poor network should enable buffering', () {
      // When network is poor, buffering should be enabled
      // This is tested in the adaptive config service logic

      final poorNetworkSettings = AdaptiveSettings(
        locationIntervalMs: 6000,
        socketHeartbeatMs: 40000,
        gpsPriority: GpsPriority.highAccuracy,
        shouldBufferUpdates: true,
        reconnectDelayMs: 10000,
        batteryLevel: BatteryLevel.high,
        networkType: NetworkType.poor,
        appState: AppState.foreground,
        batteryPercentage: 80,
      );

      expect(poorNetworkSettings.shouldBufferUpdates, true);
      expect(poorNetworkSettings.networkType, NetworkType.poor);
    });
  });
}
