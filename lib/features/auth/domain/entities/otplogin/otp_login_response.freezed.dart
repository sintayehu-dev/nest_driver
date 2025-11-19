// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_login_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OtpLoginResponse _$OtpLoginResponseFromJson(Map<String, dynamic> json) {
  return _OtpLoginResponse.fromJson(json);
}

/// @nodoc
mixin _$OtpLoginResponse {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  OtpLoginData get data => throw _privateConstructorUsedError;

  /// Serializes this OtpLoginResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpLoginResponseCopyWith<OtpLoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpLoginResponseCopyWith<$Res> {
  factory $OtpLoginResponseCopyWith(
          OtpLoginResponse value, $Res Function(OtpLoginResponse) then) =
      _$OtpLoginResponseCopyWithImpl<$Res, OtpLoginResponse>;
  @useResult
  $Res call({int code, String message, OtpLoginData data});

  $OtpLoginDataCopyWith<$Res> get data;
}

/// @nodoc
class _$OtpLoginResponseCopyWithImpl<$Res, $Val extends OtpLoginResponse>
    implements $OtpLoginResponseCopyWith<$Res> {
  _$OtpLoginResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as OtpLoginData,
    ) as $Val);
  }

  /// Create a copy of OtpLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtpLoginDataCopyWith<$Res> get data {
    return $OtpLoginDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OtpLoginResponseImplCopyWith<$Res>
    implements $OtpLoginResponseCopyWith<$Res> {
  factory _$$OtpLoginResponseImplCopyWith(_$OtpLoginResponseImpl value,
          $Res Function(_$OtpLoginResponseImpl) then) =
      __$$OtpLoginResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, OtpLoginData data});

  @override
  $OtpLoginDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$OtpLoginResponseImplCopyWithImpl<$Res>
    extends _$OtpLoginResponseCopyWithImpl<$Res, _$OtpLoginResponseImpl>
    implements _$$OtpLoginResponseImplCopyWith<$Res> {
  __$$OtpLoginResponseImplCopyWithImpl(_$OtpLoginResponseImpl _value,
      $Res Function(_$OtpLoginResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$OtpLoginResponseImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as OtpLoginData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpLoginResponseImpl extends _OtpLoginResponse {
  const _$OtpLoginResponseImpl(
      {required this.code, required this.message, required this.data})
      : super._();

  factory _$OtpLoginResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpLoginResponseImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final OtpLoginData data;

  @override
  String toString() {
    return 'OtpLoginResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpLoginResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, data);

  /// Create a copy of OtpLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpLoginResponseImplCopyWith<_$OtpLoginResponseImpl> get copyWith =>
      __$$OtpLoginResponseImplCopyWithImpl<_$OtpLoginResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpLoginResponseImplToJson(
      this,
    );
  }
}

abstract class _OtpLoginResponse extends OtpLoginResponse {
  const factory _OtpLoginResponse(
      {required final int code,
      required final String message,
      required final OtpLoginData data}) = _$OtpLoginResponseImpl;
  const _OtpLoginResponse._() : super._();

  factory _OtpLoginResponse.fromJson(Map<String, dynamic> json) =
      _$OtpLoginResponseImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  OtpLoginData get data;

  /// Create a copy of OtpLoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpLoginResponseImplCopyWith<_$OtpLoginResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpLoginData _$OtpLoginDataFromJson(Map<String, dynamic> json) {
  return _OtpLoginData.fromJson(json);
}

/// @nodoc
mixin _$OtpLoginData {
  String get message => throw _privateConstructorUsedError;
  int get expiresIn => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;

  /// Serializes this OtpLoginData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpLoginData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpLoginDataCopyWith<OtpLoginData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpLoginDataCopyWith<$Res> {
  factory $OtpLoginDataCopyWith(
          OtpLoginData value, $Res Function(OtpLoginData) then) =
      _$OtpLoginDataCopyWithImpl<$Res, OtpLoginData>;
  @useResult
  $Res call({String message, int expiresIn, String unit});
}

/// @nodoc
class _$OtpLoginDataCopyWithImpl<$Res, $Val extends OtpLoginData>
    implements $OtpLoginDataCopyWith<$Res> {
  _$OtpLoginDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpLoginData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? expiresIn = null,
    Object? unit = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpLoginDataImplCopyWith<$Res>
    implements $OtpLoginDataCopyWith<$Res> {
  factory _$$OtpLoginDataImplCopyWith(
          _$OtpLoginDataImpl value, $Res Function(_$OtpLoginDataImpl) then) =
      __$$OtpLoginDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, int expiresIn, String unit});
}

/// @nodoc
class __$$OtpLoginDataImplCopyWithImpl<$Res>
    extends _$OtpLoginDataCopyWithImpl<$Res, _$OtpLoginDataImpl>
    implements _$$OtpLoginDataImplCopyWith<$Res> {
  __$$OtpLoginDataImplCopyWithImpl(
      _$OtpLoginDataImpl _value, $Res Function(_$OtpLoginDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpLoginData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? expiresIn = null,
    Object? unit = null,
  }) {
    return _then(_$OtpLoginDataImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      expiresIn: null == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpLoginDataImpl extends _OtpLoginData {
  const _$OtpLoginDataImpl(
      {required this.message, required this.expiresIn, required this.unit})
      : super._();

  factory _$OtpLoginDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpLoginDataImplFromJson(json);

  @override
  final String message;
  @override
  final int expiresIn;
  @override
  final String unit;

  @override
  String toString() {
    return 'OtpLoginData(message: $message, expiresIn: $expiresIn, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpLoginDataImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, expiresIn, unit);

  /// Create a copy of OtpLoginData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpLoginDataImplCopyWith<_$OtpLoginDataImpl> get copyWith =>
      __$$OtpLoginDataImplCopyWithImpl<_$OtpLoginDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpLoginDataImplToJson(
      this,
    );
  }
}

abstract class _OtpLoginData extends OtpLoginData {
  const factory _OtpLoginData(
      {required final String message,
      required final int expiresIn,
      required final String unit}) = _$OtpLoginDataImpl;
  const _OtpLoginData._() : super._();

  factory _OtpLoginData.fromJson(Map<String, dynamic> json) =
      _$OtpLoginDataImpl.fromJson;

  @override
  String get message;
  @override
  int get expiresIn;
  @override
  String get unit;

  /// Create a copy of OtpLoginData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpLoginDataImplCopyWith<_$OtpLoginDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
