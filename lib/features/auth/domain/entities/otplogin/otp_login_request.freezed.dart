// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_login_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OtpLoginRequest _$OtpLoginRequestFromJson(Map<String, dynamic> json) {
  return _OtpLoginRequest.fromJson(json);
}

/// @nodoc
mixin _$OtpLoginRequest {
  @PhoneNumberConverter()
  @JsonKey(name: 'phone_number')
  PhoneNumber get phoneNumber => throw _privateConstructorUsedError;

  /// Serializes this OtpLoginRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpLoginRequestCopyWith<OtpLoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpLoginRequestCopyWith<$Res> {
  factory $OtpLoginRequestCopyWith(
          OtpLoginRequest value, $Res Function(OtpLoginRequest) then) =
      _$OtpLoginRequestCopyWithImpl<$Res, OtpLoginRequest>;
  @useResult
  $Res call(
      {@PhoneNumberConverter()
      @JsonKey(name: 'phone_number')
      PhoneNumber phoneNumber});
}

/// @nodoc
class _$OtpLoginRequestCopyWithImpl<$Res, $Val extends OtpLoginRequest>
    implements $OtpLoginRequestCopyWith<$Res> {
  _$OtpLoginRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
  }) {
    return _then(_value.copyWith(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpLoginRequestImplCopyWith<$Res>
    implements $OtpLoginRequestCopyWith<$Res> {
  factory _$$OtpLoginRequestImplCopyWith(_$OtpLoginRequestImpl value,
          $Res Function(_$OtpLoginRequestImpl) then) =
      __$$OtpLoginRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@PhoneNumberConverter()
      @JsonKey(name: 'phone_number')
      PhoneNumber phoneNumber});
}

/// @nodoc
class __$$OtpLoginRequestImplCopyWithImpl<$Res>
    extends _$OtpLoginRequestCopyWithImpl<$Res, _$OtpLoginRequestImpl>
    implements _$$OtpLoginRequestImplCopyWith<$Res> {
  __$$OtpLoginRequestImplCopyWithImpl(
      _$OtpLoginRequestImpl _value, $Res Function(_$OtpLoginRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
  }) {
    return _then(_$OtpLoginRequestImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpLoginRequestImpl extends _OtpLoginRequest {
  const _$OtpLoginRequestImpl(
      {@PhoneNumberConverter()
      @JsonKey(name: 'phone_number')
      required this.phoneNumber})
      : super._();

  factory _$OtpLoginRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpLoginRequestImplFromJson(json);

  @override
  @PhoneNumberConverter()
  @JsonKey(name: 'phone_number')
  final PhoneNumber phoneNumber;

  @override
  String toString() {
    return 'OtpLoginRequest(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpLoginRequestImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);

  /// Create a copy of OtpLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpLoginRequestImplCopyWith<_$OtpLoginRequestImpl> get copyWith =>
      __$$OtpLoginRequestImplCopyWithImpl<_$OtpLoginRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpLoginRequestImplToJson(
      this,
    );
  }
}

abstract class _OtpLoginRequest extends OtpLoginRequest {
  const factory _OtpLoginRequest(
      {@PhoneNumberConverter()
      @JsonKey(name: 'phone_number')
      required final PhoneNumber phoneNumber}) = _$OtpLoginRequestImpl;
  const _OtpLoginRequest._() : super._();

  factory _OtpLoginRequest.fromJson(Map<String, dynamic> json) =
      _$OtpLoginRequestImpl.fromJson;

  @override
  @PhoneNumberConverter()
  @JsonKey(name: 'phone_number')
  PhoneNumber get phoneNumber;

  /// Create a copy of OtpLoginRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpLoginRequestImplCopyWith<_$OtpLoginRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
