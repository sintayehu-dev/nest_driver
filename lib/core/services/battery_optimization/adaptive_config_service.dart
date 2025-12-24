import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/services/battery_optimization/models/adaptive_settings.dart';
import 'package:nest_driver/core/services/battery_optimization/app_state_monitor_service.dart';
import 'package:nest_driver/core/services/battery_optimization/battery_monitor_service.dart';
import 'package:nest_driver/core/services/battery_optimization/network_monitor_service.dart';
import 'package:rxdart/rxdart.dart';

/// Service that combines battery, network, and app state to calculate optimal settings
@lazySingleton
class AdaptiveConfigService {
  AdaptiveConfigService(
    this._batteryMonitor,
    this._networkMonitor,
    this._appStateMonitor,
  ) {
    _init();
  }

  final BatteryMonitorService _batteryMonitor;
  final NetworkMonitorService _networkMonitor;
  final AppStateMonitorService _appStateMonitor;

  final _controller = StreamController<AdaptiveSettings>.broadcast();
  StreamSubscription<AdaptiveSettings>? _combinedSubscription;

  AdaptiveSettings _currentSettings = AdaptiveSettings.defaultSettings();

  /// Stream of adaptive settings changes
  Stream<AdaptiveSettings> get settingsStream => _controller.stream;

  /// Current adaptive settings
  AdaptiveSettings get currentSettings => _currentSettings;

  // Constraints
  static const int minLocationInterval = 1000; // 1 second
  static const int maxLocationInterval = 8000; // 8 seconds

  void _init() {
    // Combine all three streams using RxDart
    _combinedSubscription = Rx.combineLatest3<BatteryLevelState, NetworkState,
        AppStateData, AdaptiveSettings>(
      _batteryMonitor.batteryStream,
      _networkMonitor.networkStream,
      _appStateMonitor.appStateStream,
      (battery, network, appState) {
        return _calculateSettings(
          batteryLevel: battery.level,
          batteryPercentage: battery.percentage,
          networkType: network.type,
          appState: appState.state,
        );
      },
    ).listen((settings) {
      if (settings != _currentSettings) {
        _currentSettings = settings;
        log('⚙️ Adaptive Config: Settings updated - '
            'Location: ${settings.locationIntervalMs}ms, '
            'Heartbeat: ${settings.socketHeartbeatMs}ms, '
            'GPS: ${settings.gpsPriority}, '
            'Buffer: ${settings.shouldBufferUpdates}');
        _controller.add(settings);
      }
    });

    log('⚙️ Adaptive Config: Service initialized');
  }

  AdaptiveSettings _calculateSettings({
    required BatteryLevel batteryLevel,
    required int batteryPercentage,
    required NetworkType networkType,
    required AppState appState,
  }) {
    // Start with battery-based baseline
    final batteryConfig = _getBatteryConfig(batteryLevel);

    // Adjust for network conditions
    final networkConfig = _getNetworkConfig(networkType);

    // Adjust for app state
    final appStateConfig = _getAppStateConfig(appState);

    // Calculate final settings using priority-based algorithm
    // Priority: Battery > Network > App State

    // Location interval: take the maximum (most conservative)
    int locationInterval = math.max(
      batteryConfig.locationInterval,
      math.max(networkConfig.locationInterval, appStateConfig.locationInterval),
    );

    // Enforce constraints
    locationInterval = locationInterval.clamp(
      minLocationInterval,
      maxLocationInterval,
    );

    // Socket heartbeat: take the maximum (most conservative)
    final socketHeartbeat = math.max(
      batteryConfig.socketHeartbeat,
      math.max(
        networkConfig.socketHeartbeat,
        appStateConfig.socketHeartbeat,
      ),
    );

    // GPS priority: use battery level's priority (most important for power)
    final gpsPriority = batteryConfig.gpsPriority;

    // Buffering: enable if network is poor
    final shouldBuffer = networkType == NetworkType.poor;

    // Reconnect delay: use network-specific delay
    final reconnectDelay = networkConfig.reconnectDelay;

    return AdaptiveSettings(
      locationIntervalMs: locationInterval,
      socketHeartbeatMs: socketHeartbeat,
      gpsPriority: gpsPriority,
      shouldBufferUpdates: shouldBuffer,
      reconnectDelayMs: reconnectDelay,
      batteryLevel: batteryLevel,
      networkType: networkType,
      appState: appState,
      batteryPercentage: batteryPercentage,
    );
  }

  _BatteryConfig _getBatteryConfig(BatteryLevel level) {
    switch (level) {
      case BatteryLevel.high: // >50%
        return const _BatteryConfig(
          locationInterval: 1000,
          socketHeartbeat: 20000,
          gpsPriority: GpsPriority.highAccuracy,
        );
      case BatteryLevel.medium: // 20-50%
        return const _BatteryConfig(
          locationInterval: 3000,
          socketHeartbeat: 30000,
          gpsPriority: GpsPriority.balanced,
        );
      case BatteryLevel.low: // <20%
        return const _BatteryConfig(
          locationInterval: 5000,
          socketHeartbeat: 45000,
          gpsPriority: GpsPriority.lowPower,
        );
    }
  }

  _NetworkConfig _getNetworkConfig(NetworkType type) {
    switch (type) {
      case NetworkType.wifi:
        return const _NetworkConfig(
          locationInterval: 2000,
          socketHeartbeat: 20000,
          reconnectDelay: 3000,
        );
      case NetworkType.mobile:
        return const _NetworkConfig(
          locationInterval: 4000,
          socketHeartbeat: 25000,
          reconnectDelay: 6000,
        );
      case NetworkType.poor:
        return const _NetworkConfig(
          locationInterval: 6000,
          socketHeartbeat: 40000,
          reconnectDelay: 10000,
        );
      case NetworkType.none:
        return const _NetworkConfig(
          locationInterval: 8000,
          socketHeartbeat: 60000,
          reconnectDelay: 15000,
        );
    }
  }

  _AppStateConfig _getAppStateConfig(AppState state) {
    switch (state) {
      case AppState.foreground:
        return const _AppStateConfig(
          locationInterval: 1000,
          socketHeartbeat: 20000,
        );
      case AppState.background:
        return const _AppStateConfig(
          locationInterval: 3000,
          socketHeartbeat: 30000,
        );
      case AppState.screenOff:
        return const _AppStateConfig(
          locationInterval: 4000,
          socketHeartbeat: 40000,
        );
    }
  }

  void dispose() {
    _combinedSubscription?.cancel();
    _controller.close();
  }
}

// Internal config classes
class _BatteryConfig {
  const _BatteryConfig({
    required this.locationInterval,
    required this.socketHeartbeat,
    required this.gpsPriority,
  });

  final int locationInterval;
  final int socketHeartbeat;
  final GpsPriority gpsPriority;
}

class _NetworkConfig {
  const _NetworkConfig({
    required this.locationInterval,
    required this.socketHeartbeat,
    required this.reconnectDelay,
  });

  final int locationInterval;
  final int socketHeartbeat;
  final int reconnectDelay;
}

class _AppStateConfig {
  const _AppStateConfig({
    required this.locationInterval,
    required this.socketHeartbeat,
  });

  final int locationInterval;
  final int socketHeartbeat;
}
