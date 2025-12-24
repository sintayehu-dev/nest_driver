import 'dart:async';
import 'dart:developer';

import 'package:battery_plus/battery_plus.dart' as battery_plus;
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/services/battery_optimization/models/adaptive_settings.dart';

/// Service for monitoring battery level changes
@lazySingleton
class BatteryMonitorService {
  BatteryMonitorService() {
    _init();
  }

  final battery_plus.Battery _battery = battery_plus.Battery();
  final _controller = StreamController<BatteryLevelState>.broadcast();
  StreamSubscription<battery_plus.BatteryState>? _batterySubscription;

  BatteryLevel _currentLevel = BatteryLevel.high;
  int _currentPercentage = 100;

  /// Stream of battery state changes
  Stream<BatteryLevelState> get batteryStream => _controller.stream;

  /// Current battery level category
  BatteryLevel get currentLevel => _currentLevel;

  /// Current battery percentage (0-100)
  int get currentPercentage => _currentPercentage;

  void _init() {
    _startMonitoring();
  }

  Future<void> _startMonitoring() async {
    try {
      // Get initial battery level
      _currentPercentage = await _battery.batteryLevel;
      _currentLevel = _currentPercentage.toBatteryLevel();

      log('🔋 Battery Monitor: Initial level: $_currentPercentage% ($_currentLevel)');

      // Listen to battery state changes
      _batterySubscription = _battery.onBatteryStateChanged.listen((state) {
        _handleBatteryStateChange(state);
      });

      // Emit initial state
      _controller.add(BatteryLevelState(
        level: _currentLevel,
        percentage: _currentPercentage,
      ));
    } catch (e) {
      log('❌ Battery Monitor: Failed to start monitoring: $e');
    }
  }

  Future<void> _handleBatteryStateChange(
    battery_plus.BatteryState state,
  ) async {
    try {
      final percentage = await _battery.batteryLevel;
      final level = percentage.toBatteryLevel();

      // Only emit if level category changed
      if (level != _currentLevel || percentage != _currentPercentage) {
        _currentPercentage = percentage;
        _currentLevel = level;

        log('🔋 Battery Monitor: Level changed to $percentage% ($level)');

        _controller.add(BatteryLevelState(
          level: level,
          percentage: percentage,
        ));
      }
    } catch (e) {
      log('❌ Battery Monitor: Error handling state change: $e');
    }
  }

  /// Manually refresh battery level
  Future<void> refresh() async {
    try {
      final percentage = await _battery.batteryLevel;
      final level = percentage.toBatteryLevel();

      if (level != _currentLevel || percentage != _currentPercentage) {
        _currentPercentage = percentage;
        _currentLevel = level;

        _controller.add(BatteryLevelState(
          level: level,
          percentage: percentage,
        ));
      }
    } catch (e) {
      log('❌ Battery Monitor: Failed to refresh: $e');
    }
  }

  void dispose() {
    _batterySubscription?.cancel();
    _controller.close();
  }
}

/// Battery level state data class
class BatteryLevelState {
  const BatteryLevelState({
    required this.level,
    required this.percentage,
  });

  final BatteryLevel level;
  final int percentage;

  @override
  String toString() =>
      'BatteryLevelState(level: $level, percentage: $percentage%)';
}
