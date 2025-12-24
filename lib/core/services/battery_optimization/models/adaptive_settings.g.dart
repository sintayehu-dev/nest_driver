// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adaptive_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdaptiveSettingsImpl _$$AdaptiveSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$AdaptiveSettingsImpl(
      locationIntervalMs: (json['locationIntervalMs'] as num).toInt(),
      socketHeartbeatMs: (json['socketHeartbeatMs'] as num).toInt(),
      gpsPriority: $enumDecode(_$GpsPriorityEnumMap, json['gpsPriority']),
      shouldBufferUpdates: json['shouldBufferUpdates'] as bool,
      reconnectDelayMs: (json['reconnectDelayMs'] as num).toInt(),
      batteryLevel: $enumDecode(_$BatteryLevelEnumMap, json['batteryLevel']),
      networkType: $enumDecode(_$NetworkTypeEnumMap, json['networkType']),
      appState: $enumDecode(_$AppStateEnumMap, json['appState']),
      batteryPercentage: (json['batteryPercentage'] as num).toInt(),
    );

Map<String, dynamic> _$$AdaptiveSettingsImplToJson(
        _$AdaptiveSettingsImpl instance) =>
    <String, dynamic>{
      'locationIntervalMs': instance.locationIntervalMs,
      'socketHeartbeatMs': instance.socketHeartbeatMs,
      'gpsPriority': _$GpsPriorityEnumMap[instance.gpsPriority]!,
      'shouldBufferUpdates': instance.shouldBufferUpdates,
      'reconnectDelayMs': instance.reconnectDelayMs,
      'batteryLevel': _$BatteryLevelEnumMap[instance.batteryLevel]!,
      'networkType': _$NetworkTypeEnumMap[instance.networkType]!,
      'appState': _$AppStateEnumMap[instance.appState]!,
      'batteryPercentage': instance.batteryPercentage,
    };

const _$GpsPriorityEnumMap = {
  GpsPriority.highAccuracy: 'high_accuracy',
  GpsPriority.balanced: 'balanced',
  GpsPriority.lowPower: 'low_power',
};

const _$BatteryLevelEnumMap = {
  BatteryLevel.high: 'high',
  BatteryLevel.medium: 'medium',
  BatteryLevel.low: 'low',
};

const _$NetworkTypeEnumMap = {
  NetworkType.wifi: 'wifi',
  NetworkType.mobile: 'mobile',
  NetworkType.poor: 'poor',
  NetworkType.none: 'none',
};

const _$AppStateEnumMap = {
  AppState.foreground: 'foreground',
  AppState.background: 'background',
  AppState.screenOff: 'screen_off',
};
