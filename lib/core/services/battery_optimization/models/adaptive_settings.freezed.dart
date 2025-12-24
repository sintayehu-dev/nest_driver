// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adaptive_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdaptiveSettings _$AdaptiveSettingsFromJson(Map<String, dynamic> json) {
  return _AdaptiveSettings.fromJson(json);
}

/// @nodoc
mixin _$AdaptiveSettings {
  /// Location update interval in milliseconds
  int get locationIntervalMs => throw _privateConstructorUsedError;

  /// WebSocket heartbeat interval in milliseconds
  int get socketHeartbeatMs => throw _privateConstructorUsedError;

  /// GPS priority/accuracy level
  GpsPriority get gpsPriority => throw _privateConstructorUsedError;

  /// Whether to buffer location updates during poor network
  bool get shouldBufferUpdates => throw _privateConstructorUsedError;

  /// WebSocket reconnect delay in milliseconds
  int get reconnectDelayMs => throw _privateConstructorUsedError;

  /// Current battery level category
  BatteryLevel get batteryLevel => throw _privateConstructorUsedError;

  /// Current network type
  NetworkType get networkType => throw _privateConstructorUsedError;

  /// Current app state
  AppState get appState => throw _privateConstructorUsedError;

  /// Actual battery percentage (0-100)
  int get batteryPercentage => throw _privateConstructorUsedError;

  /// Serializes this AdaptiveSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdaptiveSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdaptiveSettingsCopyWith<AdaptiveSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdaptiveSettingsCopyWith<$Res> {
  factory $AdaptiveSettingsCopyWith(
          AdaptiveSettings value, $Res Function(AdaptiveSettings) then) =
      _$AdaptiveSettingsCopyWithImpl<$Res, AdaptiveSettings>;
  @useResult
  $Res call(
      {int locationIntervalMs,
      int socketHeartbeatMs,
      GpsPriority gpsPriority,
      bool shouldBufferUpdates,
      int reconnectDelayMs,
      BatteryLevel batteryLevel,
      NetworkType networkType,
      AppState appState,
      int batteryPercentage});
}

/// @nodoc
class _$AdaptiveSettingsCopyWithImpl<$Res, $Val extends AdaptiveSettings>
    implements $AdaptiveSettingsCopyWith<$Res> {
  _$AdaptiveSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdaptiveSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationIntervalMs = null,
    Object? socketHeartbeatMs = null,
    Object? gpsPriority = null,
    Object? shouldBufferUpdates = null,
    Object? reconnectDelayMs = null,
    Object? batteryLevel = null,
    Object? networkType = null,
    Object? appState = null,
    Object? batteryPercentage = null,
  }) {
    return _then(_value.copyWith(
      locationIntervalMs: null == locationIntervalMs
          ? _value.locationIntervalMs
          : locationIntervalMs // ignore: cast_nullable_to_non_nullable
              as int,
      socketHeartbeatMs: null == socketHeartbeatMs
          ? _value.socketHeartbeatMs
          : socketHeartbeatMs // ignore: cast_nullable_to_non_nullable
              as int,
      gpsPriority: null == gpsPriority
          ? _value.gpsPriority
          : gpsPriority // ignore: cast_nullable_to_non_nullable
              as GpsPriority,
      shouldBufferUpdates: null == shouldBufferUpdates
          ? _value.shouldBufferUpdates
          : shouldBufferUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      reconnectDelayMs: null == reconnectDelayMs
          ? _value.reconnectDelayMs
          : reconnectDelayMs // ignore: cast_nullable_to_non_nullable
              as int,
      batteryLevel: null == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as BatteryLevel,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      appState: null == appState
          ? _value.appState
          : appState // ignore: cast_nullable_to_non_nullable
              as AppState,
      batteryPercentage: null == batteryPercentage
          ? _value.batteryPercentage
          : batteryPercentage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdaptiveSettingsImplCopyWith<$Res>
    implements $AdaptiveSettingsCopyWith<$Res> {
  factory _$$AdaptiveSettingsImplCopyWith(_$AdaptiveSettingsImpl value,
          $Res Function(_$AdaptiveSettingsImpl) then) =
      __$$AdaptiveSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int locationIntervalMs,
      int socketHeartbeatMs,
      GpsPriority gpsPriority,
      bool shouldBufferUpdates,
      int reconnectDelayMs,
      BatteryLevel batteryLevel,
      NetworkType networkType,
      AppState appState,
      int batteryPercentage});
}

/// @nodoc
class __$$AdaptiveSettingsImplCopyWithImpl<$Res>
    extends _$AdaptiveSettingsCopyWithImpl<$Res, _$AdaptiveSettingsImpl>
    implements _$$AdaptiveSettingsImplCopyWith<$Res> {
  __$$AdaptiveSettingsImplCopyWithImpl(_$AdaptiveSettingsImpl _value,
      $Res Function(_$AdaptiveSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdaptiveSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationIntervalMs = null,
    Object? socketHeartbeatMs = null,
    Object? gpsPriority = null,
    Object? shouldBufferUpdates = null,
    Object? reconnectDelayMs = null,
    Object? batteryLevel = null,
    Object? networkType = null,
    Object? appState = null,
    Object? batteryPercentage = null,
  }) {
    return _then(_$AdaptiveSettingsImpl(
      locationIntervalMs: null == locationIntervalMs
          ? _value.locationIntervalMs
          : locationIntervalMs // ignore: cast_nullable_to_non_nullable
              as int,
      socketHeartbeatMs: null == socketHeartbeatMs
          ? _value.socketHeartbeatMs
          : socketHeartbeatMs // ignore: cast_nullable_to_non_nullable
              as int,
      gpsPriority: null == gpsPriority
          ? _value.gpsPriority
          : gpsPriority // ignore: cast_nullable_to_non_nullable
              as GpsPriority,
      shouldBufferUpdates: null == shouldBufferUpdates
          ? _value.shouldBufferUpdates
          : shouldBufferUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      reconnectDelayMs: null == reconnectDelayMs
          ? _value.reconnectDelayMs
          : reconnectDelayMs // ignore: cast_nullable_to_non_nullable
              as int,
      batteryLevel: null == batteryLevel
          ? _value.batteryLevel
          : batteryLevel // ignore: cast_nullable_to_non_nullable
              as BatteryLevel,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
      appState: null == appState
          ? _value.appState
          : appState // ignore: cast_nullable_to_non_nullable
              as AppState,
      batteryPercentage: null == batteryPercentage
          ? _value.batteryPercentage
          : batteryPercentage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdaptiveSettingsImpl implements _AdaptiveSettings {
  const _$AdaptiveSettingsImpl(
      {required this.locationIntervalMs,
      required this.socketHeartbeatMs,
      required this.gpsPriority,
      required this.shouldBufferUpdates,
      required this.reconnectDelayMs,
      required this.batteryLevel,
      required this.networkType,
      required this.appState,
      required this.batteryPercentage});

  factory _$AdaptiveSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdaptiveSettingsImplFromJson(json);

  /// Location update interval in milliseconds
  @override
  final int locationIntervalMs;

  /// WebSocket heartbeat interval in milliseconds
  @override
  final int socketHeartbeatMs;

  /// GPS priority/accuracy level
  @override
  final GpsPriority gpsPriority;

  /// Whether to buffer location updates during poor network
  @override
  final bool shouldBufferUpdates;

  /// WebSocket reconnect delay in milliseconds
  @override
  final int reconnectDelayMs;

  /// Current battery level category
  @override
  final BatteryLevel batteryLevel;

  /// Current network type
  @override
  final NetworkType networkType;

  /// Current app state
  @override
  final AppState appState;

  /// Actual battery percentage (0-100)
  @override
  final int batteryPercentage;

  @override
  String toString() {
    return 'AdaptiveSettings(locationIntervalMs: $locationIntervalMs, socketHeartbeatMs: $socketHeartbeatMs, gpsPriority: $gpsPriority, shouldBufferUpdates: $shouldBufferUpdates, reconnectDelayMs: $reconnectDelayMs, batteryLevel: $batteryLevel, networkType: $networkType, appState: $appState, batteryPercentage: $batteryPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdaptiveSettingsImpl &&
            (identical(other.locationIntervalMs, locationIntervalMs) ||
                other.locationIntervalMs == locationIntervalMs) &&
            (identical(other.socketHeartbeatMs, socketHeartbeatMs) ||
                other.socketHeartbeatMs == socketHeartbeatMs) &&
            (identical(other.gpsPriority, gpsPriority) ||
                other.gpsPriority == gpsPriority) &&
            (identical(other.shouldBufferUpdates, shouldBufferUpdates) ||
                other.shouldBufferUpdates == shouldBufferUpdates) &&
            (identical(other.reconnectDelayMs, reconnectDelayMs) ||
                other.reconnectDelayMs == reconnectDelayMs) &&
            (identical(other.batteryLevel, batteryLevel) ||
                other.batteryLevel == batteryLevel) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.appState, appState) ||
                other.appState == appState) &&
            (identical(other.batteryPercentage, batteryPercentage) ||
                other.batteryPercentage == batteryPercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      locationIntervalMs,
      socketHeartbeatMs,
      gpsPriority,
      shouldBufferUpdates,
      reconnectDelayMs,
      batteryLevel,
      networkType,
      appState,
      batteryPercentage);

  /// Create a copy of AdaptiveSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdaptiveSettingsImplCopyWith<_$AdaptiveSettingsImpl> get copyWith =>
      __$$AdaptiveSettingsImplCopyWithImpl<_$AdaptiveSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdaptiveSettingsImplToJson(
      this,
    );
  }
}

abstract class _AdaptiveSettings implements AdaptiveSettings {
  const factory _AdaptiveSettings(
      {required final int locationIntervalMs,
      required final int socketHeartbeatMs,
      required final GpsPriority gpsPriority,
      required final bool shouldBufferUpdates,
      required final int reconnectDelayMs,
      required final BatteryLevel batteryLevel,
      required final NetworkType networkType,
      required final AppState appState,
      required final int batteryPercentage}) = _$AdaptiveSettingsImpl;

  factory _AdaptiveSettings.fromJson(Map<String, dynamic> json) =
      _$AdaptiveSettingsImpl.fromJson;

  /// Location update interval in milliseconds
  @override
  int get locationIntervalMs;

  /// WebSocket heartbeat interval in milliseconds
  @override
  int get socketHeartbeatMs;

  /// GPS priority/accuracy level
  @override
  GpsPriority get gpsPriority;

  /// Whether to buffer location updates during poor network
  @override
  bool get shouldBufferUpdates;

  /// WebSocket reconnect delay in milliseconds
  @override
  int get reconnectDelayMs;

  /// Current battery level category
  @override
  BatteryLevel get batteryLevel;

  /// Current network type
  @override
  NetworkType get networkType;

  /// Current app state
  @override
  AppState get appState;

  /// Actual battery percentage (0-100)
  @override
  int get batteryPercentage;

  /// Create a copy of AdaptiveSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdaptiveSettingsImplCopyWith<_$AdaptiveSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
