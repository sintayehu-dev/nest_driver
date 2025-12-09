// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_update_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileUpdateResponse _$ProfileUpdateResponseFromJson(
    Map<String, dynamic> json) {
  return _ProfileUpdateResponse.fromJson(json);
}

/// @nodoc
mixin _$ProfileUpdateResponse {
  bool get success => throw _privateConstructorUsedError;
  ProfileUpdateData get data => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ProfileUpdateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileUpdateResponseCopyWith<ProfileUpdateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUpdateResponseCopyWith<$Res> {
  factory $ProfileUpdateResponseCopyWith(ProfileUpdateResponse value,
          $Res Function(ProfileUpdateResponse) then) =
      _$ProfileUpdateResponseCopyWithImpl<$Res, ProfileUpdateResponse>;
  @useResult
  $Res call({bool success, ProfileUpdateData data, String? message});

  $ProfileUpdateDataCopyWith<$Res> get data;
}

/// @nodoc
class _$ProfileUpdateResponseCopyWithImpl<$Res,
        $Val extends ProfileUpdateResponse>
    implements $ProfileUpdateResponseCopyWith<$Res> {
  _$ProfileUpdateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ProfileUpdateData,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileUpdateDataCopyWith<$Res> get data {
    return $ProfileUpdateDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileUpdateResponseImplCopyWith<$Res>
    implements $ProfileUpdateResponseCopyWith<$Res> {
  factory _$$ProfileUpdateResponseImplCopyWith(
          _$ProfileUpdateResponseImpl value,
          $Res Function(_$ProfileUpdateResponseImpl) then) =
      __$$ProfileUpdateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, ProfileUpdateData data, String? message});

  @override
  $ProfileUpdateDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$ProfileUpdateResponseImplCopyWithImpl<$Res>
    extends _$ProfileUpdateResponseCopyWithImpl<$Res,
        _$ProfileUpdateResponseImpl>
    implements _$$ProfileUpdateResponseImplCopyWith<$Res> {
  __$$ProfileUpdateResponseImplCopyWithImpl(_$ProfileUpdateResponseImpl _value,
      $Res Function(_$ProfileUpdateResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = freezed,
  }) {
    return _then(_$ProfileUpdateResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ProfileUpdateData,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileUpdateResponseImpl extends _ProfileUpdateResponse {
  const _$ProfileUpdateResponseImpl(
      {required this.success, required this.data, this.message})
      : super._();

  factory _$ProfileUpdateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileUpdateResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final ProfileUpdateData data;
  @override
  final String? message;

  @override
  String toString() {
    return 'ProfileUpdateResponse(success: $success, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdateResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, data, message);

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdateResponseImplCopyWith<_$ProfileUpdateResponseImpl>
      get copyWith => __$$ProfileUpdateResponseImplCopyWithImpl<
          _$ProfileUpdateResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileUpdateResponseImplToJson(
      this,
    );
  }
}

abstract class _ProfileUpdateResponse extends ProfileUpdateResponse {
  const factory _ProfileUpdateResponse(
      {required final bool success,
      required final ProfileUpdateData data,
      final String? message}) = _$ProfileUpdateResponseImpl;
  const _ProfileUpdateResponse._() : super._();

  factory _ProfileUpdateResponse.fromJson(Map<String, dynamic> json) =
      _$ProfileUpdateResponseImpl.fromJson;

  @override
  bool get success;
  @override
  ProfileUpdateData get data;
  @override
  String? get message;

  /// Create a copy of ProfileUpdateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileUpdateResponseImplCopyWith<_$ProfileUpdateResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ProfileUpdateData _$ProfileUpdateDataFromJson(Map<String, dynamic> json) {
  return _ProfileUpdateData.fromJson(json);
}

/// @nodoc
mixin _$ProfileUpdateData {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String? get lastName => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  bool? get isVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_void')
  bool? get isVoid => throw _privateConstructorUsedError;
  @JsonKey(name: 'otp_code')
  String? get otpCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'otp_expires_at')
  String? get otpExpiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_token')
  String? get refreshToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_login_at')
  String? get lastLoginAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ProfileUpdateData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileUpdateDataCopyWith<ProfileUpdateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUpdateDataCopyWith<$Res> {
  factory $ProfileUpdateDataCopyWith(
          ProfileUpdateData value, $Res Function(ProfileUpdateData) then) =
      _$ProfileUpdateDataCopyWithImpl<$Res, ProfileUpdateData>;
  @useResult
  $Res call(
      {String id,
      String username,
      String? password,
      @JsonKey(name: 'phone_number') String? phoneNumber,
      String? email,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      String? status,
      @JsonKey(name: 'is_verified') bool? isVerified,
      @JsonKey(name: 'is_void') bool? isVoid,
      @JsonKey(name: 'otp_code') String? otpCode,
      @JsonKey(name: 'otp_expires_at') String? otpExpiresAt,
      @JsonKey(name: 'refresh_token') String? refreshToken,
      @JsonKey(name: 'last_login_at') String? lastLoginAt,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt});
}

/// @nodoc
class _$ProfileUpdateDataCopyWithImpl<$Res, $Val extends ProfileUpdateData>
    implements $ProfileUpdateDataCopyWith<$Res> {
  _$ProfileUpdateDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? password = freezed,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? status = freezed,
    Object? isVerified = freezed,
    Object? isVoid = freezed,
    Object? otpCode = freezed,
    Object? otpExpiresAt = freezed,
    Object? refreshToken = freezed,
    Object? lastLoginAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      isVoid: freezed == isVoid
          ? _value.isVoid
          : isVoid // ignore: cast_nullable_to_non_nullable
              as bool?,
      otpCode: freezed == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String?,
      otpExpiresAt: freezed == otpExpiresAt
          ? _value.otpExpiresAt
          : otpExpiresAt // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileUpdateDataImplCopyWith<$Res>
    implements $ProfileUpdateDataCopyWith<$Res> {
  factory _$$ProfileUpdateDataImplCopyWith(_$ProfileUpdateDataImpl value,
          $Res Function(_$ProfileUpdateDataImpl) then) =
      __$$ProfileUpdateDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String? password,
      @JsonKey(name: 'phone_number') String? phoneNumber,
      String? email,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      String? status,
      @JsonKey(name: 'is_verified') bool? isVerified,
      @JsonKey(name: 'is_void') bool? isVoid,
      @JsonKey(name: 'otp_code') String? otpCode,
      @JsonKey(name: 'otp_expires_at') String? otpExpiresAt,
      @JsonKey(name: 'refresh_token') String? refreshToken,
      @JsonKey(name: 'last_login_at') String? lastLoginAt,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt});
}

/// @nodoc
class __$$ProfileUpdateDataImplCopyWithImpl<$Res>
    extends _$ProfileUpdateDataCopyWithImpl<$Res, _$ProfileUpdateDataImpl>
    implements _$$ProfileUpdateDataImplCopyWith<$Res> {
  __$$ProfileUpdateDataImplCopyWithImpl(_$ProfileUpdateDataImpl _value,
      $Res Function(_$ProfileUpdateDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? password = freezed,
    Object? phoneNumber = freezed,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? status = freezed,
    Object? isVerified = freezed,
    Object? isVoid = freezed,
    Object? otpCode = freezed,
    Object? otpExpiresAt = freezed,
    Object? refreshToken = freezed,
    Object? lastLoginAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ProfileUpdateDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      isVoid: freezed == isVoid
          ? _value.isVoid
          : isVoid // ignore: cast_nullable_to_non_nullable
              as bool?,
      otpCode: freezed == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String?,
      otpExpiresAt: freezed == otpExpiresAt
          ? _value.otpExpiresAt
          : otpExpiresAt // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileUpdateDataImpl extends _ProfileUpdateData {
  const _$ProfileUpdateDataImpl(
      {required this.id,
      required this.username,
      this.password,
      @JsonKey(name: 'phone_number') this.phoneNumber,
      this.email,
      @JsonKey(name: 'first_name') this.firstName,
      @JsonKey(name: 'last_name') this.lastName,
      this.status,
      @JsonKey(name: 'is_verified') this.isVerified,
      @JsonKey(name: 'is_void') this.isVoid,
      @JsonKey(name: 'otp_code') this.otpCode,
      @JsonKey(name: 'otp_expires_at') this.otpExpiresAt,
      @JsonKey(name: 'refresh_token') this.refreshToken,
      @JsonKey(name: 'last_login_at') this.lastLoginAt,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : super._();

  factory _$ProfileUpdateDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileUpdateDataImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String? password;
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @override
  final String? email;
  @override
  @JsonKey(name: 'first_name')
  final String? firstName;
  @override
  @JsonKey(name: 'last_name')
  final String? lastName;
  @override
  final String? status;
  @override
  @JsonKey(name: 'is_verified')
  final bool? isVerified;
  @override
  @JsonKey(name: 'is_void')
  final bool? isVoid;
  @override
  @JsonKey(name: 'otp_code')
  final String? otpCode;
  @override
  @JsonKey(name: 'otp_expires_at')
  final String? otpExpiresAt;
  @override
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;
  @override
  @JsonKey(name: 'last_login_at')
  final String? lastLoginAt;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @override
  String toString() {
    return 'ProfileUpdateData(id: $id, username: $username, password: $password, phoneNumber: $phoneNumber, email: $email, firstName: $firstName, lastName: $lastName, status: $status, isVerified: $isVerified, isVoid: $isVoid, otpCode: $otpCode, otpExpiresAt: $otpExpiresAt, refreshToken: $refreshToken, lastLoginAt: $lastLoginAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdateDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isVoid, isVoid) || other.isVoid == isVoid) &&
            (identical(other.otpCode, otpCode) || other.otpCode == otpCode) &&
            (identical(other.otpExpiresAt, otpExpiresAt) ||
                other.otpExpiresAt == otpExpiresAt) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      username,
      password,
      phoneNumber,
      email,
      firstName,
      lastName,
      status,
      isVerified,
      isVoid,
      otpCode,
      otpExpiresAt,
      refreshToken,
      lastLoginAt,
      createdAt,
      updatedAt);

  /// Create a copy of ProfileUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdateDataImplCopyWith<_$ProfileUpdateDataImpl> get copyWith =>
      __$$ProfileUpdateDataImplCopyWithImpl<_$ProfileUpdateDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileUpdateDataImplToJson(
      this,
    );
  }
}

abstract class _ProfileUpdateData extends ProfileUpdateData {
  const factory _ProfileUpdateData(
          {required final String id,
          required final String username,
          final String? password,
          @JsonKey(name: 'phone_number') final String? phoneNumber,
          final String? email,
          @JsonKey(name: 'first_name') final String? firstName,
          @JsonKey(name: 'last_name') final String? lastName,
          final String? status,
          @JsonKey(name: 'is_verified') final bool? isVerified,
          @JsonKey(name: 'is_void') final bool? isVoid,
          @JsonKey(name: 'otp_code') final String? otpCode,
          @JsonKey(name: 'otp_expires_at') final String? otpExpiresAt,
          @JsonKey(name: 'refresh_token') final String? refreshToken,
          @JsonKey(name: 'last_login_at') final String? lastLoginAt,
          @JsonKey(name: 'created_at') required final String createdAt,
          @JsonKey(name: 'updated_at') required final String updatedAt}) =
      _$ProfileUpdateDataImpl;
  const _ProfileUpdateData._() : super._();

  factory _ProfileUpdateData.fromJson(Map<String, dynamic> json) =
      _$ProfileUpdateDataImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String? get password;
  @override
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;
  @override
  String? get email;
  @override
  @JsonKey(name: 'first_name')
  String? get firstName;
  @override
  @JsonKey(name: 'last_name')
  String? get lastName;
  @override
  String? get status;
  @override
  @JsonKey(name: 'is_verified')
  bool? get isVerified;
  @override
  @JsonKey(name: 'is_void')
  bool? get isVoid;
  @override
  @JsonKey(name: 'otp_code')
  String? get otpCode;
  @override
  @JsonKey(name: 'otp_expires_at')
  String? get otpExpiresAt;
  @override
  @JsonKey(name: 'refresh_token')
  String? get refreshToken;
  @override
  @JsonKey(name: 'last_login_at')
  String? get lastLoginAt;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;

  /// Create a copy of ProfileUpdateData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileUpdateDataImplCopyWith<_$ProfileUpdateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
