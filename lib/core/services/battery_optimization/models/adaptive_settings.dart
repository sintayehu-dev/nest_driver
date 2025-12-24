import 'package:freezed_annotation/freezed_annotation.dart';

part 'adaptive_settings.freezed.dart';
part 'adaptive_settings.g.dart';

/// Battery level categories for adaptive optimization
enum BatteryLevel {
  @JsonValue('high')
  high, // >50%
  @JsonValue('medium')
  medium, // 20-50%
  @JsonValue('low')
  low, // <20%
}

/// Network connection types
enum NetworkType {
  @JsonValue('wifi')
  wifi,
  @JsonValue('mobile')
  mobile,
  @JsonValue('poor')
  poor,
  @JsonValue('none')
  none,
}

/// Application state for lifecycle management
enum AppState {
  @JsonValue('foreground')
  foreground,
  @JsonValue('background')
  background,
  @JsonValue('screen_off')
  screenOff,
}

/// GPS priority levels for location accuracy
enum GpsPriority {
  @JsonValue('high_accuracy')
  highAccuracy,
  @JsonValue('balanced')
  balanced,
  @JsonValue('low_power')
  lowPower,
}

/// Adaptive settings calculated based on battery, network, and app state
@freezed
class AdaptiveSettings with _$AdaptiveSettings {
  const factory AdaptiveSettings({
    /// Location update interval in milliseconds
    required int locationIntervalMs,

    /// WebSocket heartbeat interval in milliseconds
    required int socketHeartbeatMs,

    /// GPS priority/accuracy level
    required GpsPriority gpsPriority,

    /// Whether to buffer location updates during poor network
    required bool shouldBufferUpdates,

    /// WebSocket reconnect delay in milliseconds
    required int reconnectDelayMs,

    /// Current battery level category
    required BatteryLevel batteryLevel,

    /// Current network type
    required NetworkType networkType,

    /// Current app state
    required AppState appState,

    /// Actual battery percentage (0-100)
    required int batteryPercentage,
  }) = _AdaptiveSettings;

  factory AdaptiveSettings.fromJson(Map<String, dynamic> json) =>
      _$AdaptiveSettingsFromJson(json);

  /// Default settings for high battery, WiFi, foreground
  factory AdaptiveSettings.defaultSettings() => const AdaptiveSettings(
        locationIntervalMs: 1000,
        socketHeartbeatMs: 20000,
        gpsPriority: GpsPriority.highAccuracy,
        shouldBufferUpdates: false,
        reconnectDelayMs: 3000,
        batteryLevel: BatteryLevel.high,
        networkType: NetworkType.wifi,
        appState: AppState.foreground,
        batteryPercentage: 100,
      );
}

/// Extension to get battery level from percentage
extension BatteryLevelExtension on int {
  BatteryLevel toBatteryLevel() {
    if (this > 50) return BatteryLevel.high;
    if (this >= 20) return BatteryLevel.medium;
    return BatteryLevel.low;
  }
}
