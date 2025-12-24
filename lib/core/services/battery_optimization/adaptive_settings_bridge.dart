import 'dart:async';
import 'dart:developer';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nest_driver/core/services/battery_optimization/models/adaptive_settings.dart';
import 'package:nest_driver/core/services/battery_optimization/adaptive_config_service.dart';

/// Service that bridges adaptive settings to background isolate via SharedPreferences
@lazySingleton
class AdaptiveSettingsBridge {
  AdaptiveSettingsBridge(this._adaptiveConfigService) {
    _init();
  }

  final AdaptiveConfigService _adaptiveConfigService;
  StreamSubscription<AdaptiveSettings>? _settingsSubscription;

  void _init() {
    // Listen to adaptive settings changes and update SharedPreferences
    _settingsSubscription =
        _adaptiveConfigService.settingsStream.listen((settings) {
      _updateSharedPreferences(settings);
    });

    log('🌉 Adaptive Settings Bridge: Initialized');
  }

  Future<void> _updateSharedPreferences(AdaptiveSettings settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Store all adaptive settings
      await prefs.setInt(
        'adaptive_location_interval',
        settings.locationIntervalMs,
      );
      await prefs.setInt(
        'adaptive_heartbeat_interval',
        settings.socketHeartbeatMs,
      );
      await prefs.setInt(
        'adaptive_reconnect_delay',
        settings.reconnectDelayMs,
      );
      await prefs.setString(
        'adaptive_gps_priority',
        _mapGpsPriorityToString(settings.gpsPriority),
      );
      await prefs.setBool(
        'adaptive_should_buffer',
        settings.shouldBufferUpdates,
      );
      await prefs.setString(
        'adaptive_battery_level',
        _mapBatteryLevelToString(settings.batteryLevel),
      );
      await prefs.setString(
        'adaptive_network_type',
        _mapNetworkTypeToString(settings.networkType),
      );
      await prefs.setString(
        'adaptive_app_state',
        _mapAppStateToString(settings.appState),
      );

      log('🌉 Adaptive Settings Bridge: Updated SharedPreferences - '
          'Location: ${settings.locationIntervalMs}ms, '
          'Heartbeat: ${settings.socketHeartbeatMs}ms, '
          'GPS: ${settings.gpsPriority}');

      // Notify background service to reload settings
      final service = FlutterBackgroundService();
      if (await service.isRunning()) {
        service.invoke('updateAdaptiveSettings');
        log('🌉 Adaptive Settings Bridge: Notified background service');
      }
    } catch (e) {
      log('❌ Adaptive Settings Bridge: Failed to update SharedPreferences: $e');
    }
  }

  String _mapGpsPriorityToString(GpsPriority priority) {
    switch (priority) {
      case GpsPriority.highAccuracy:
        return 'high_accuracy';
      case GpsPriority.balanced:
        return 'balanced';
      case GpsPriority.lowPower:
        return 'low_power';
    }
  }

  String _mapBatteryLevelToString(BatteryLevel level) {
    switch (level) {
      case BatteryLevel.high:
        return 'high';
      case BatteryLevel.medium:
        return 'medium';
      case BatteryLevel.low:
        return 'low';
    }
  }

  String _mapNetworkTypeToString(NetworkType type) {
    switch (type) {
      case NetworkType.wifi:
        return 'wifi';
      case NetworkType.mobile:
        return 'mobile';
      case NetworkType.poor:
        return 'poor';
      case NetworkType.none:
        return 'none';
    }
  }

  String _mapAppStateToString(AppState state) {
    switch (state) {
      case AppState.foreground:
        return 'foreground';
      case AppState.background:
        return 'background';
      case AppState.screenOff:
        return 'screen_off';
    }
  }

  void dispose() {
    _settingsSubscription?.cancel();
  }
}
