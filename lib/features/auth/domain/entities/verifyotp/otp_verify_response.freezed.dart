// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_verify_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OtpVerifyResponse _$OtpVerifyResponseFromJson(Map<String, dynamic> json) {
  return _OtpVerifyResponse.fromJson(json);
}

/// @nodoc
mixin _$OtpVerifyResponse {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  OtpVerifyData get data => throw _privateConstructorUsedError;

  /// Serializes this OtpVerifyResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpVerifyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpVerifyResponseCopyWith<OtpVerifyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpVerifyResponseCopyWith<$Res> {
  factory $OtpVerifyResponseCopyWith(
          OtpVerifyResponse value, $Res Function(OtpVerifyResponse) then) =
      _$OtpVerifyResponseCopyWithImpl<$Res, OtpVerifyResponse>;
  @useResult
  $Res call({int code, String message, OtpVerifyData data});

  $OtpVerifyDataCopyWith<$Res> get data;
}

/// @nodoc
class _$OtpVerifyResponseCopyWithImpl<$Res, $Val extends OtpVerifyResponse>
    implements $OtpVerifyResponseCopyWith<$Res> {
  _$OtpVerifyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpVerifyResponse
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
              as OtpVerifyData,
    ) as $Val);
  }

  /// Create a copy of OtpVerifyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtpVerifyDataCopyWith<$Res> get data {
    return $OtpVerifyDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OtpVerifyResponseImplCopyWith<$Res>
    implements $OtpVerifyResponseCopyWith<$Res> {
  factory _$$OtpVerifyResponseImplCopyWith(_$OtpVerifyResponseImpl value,
          $Res Function(_$OtpVerifyResponseImpl) then) =
      __$$OtpVerifyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, OtpVerifyData data});

  @override
  $OtpVerifyDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$OtpVerifyResponseImplCopyWithImpl<$Res>
    extends _$OtpVerifyResponseCopyWithImpl<$Res, _$OtpVerifyResponseImpl>
    implements _$$OtpVerifyResponseImplCopyWith<$Res> {
  __$$OtpVerifyResponseImplCopyWithImpl(_$OtpVerifyResponseImpl _value,
      $Res Function(_$OtpVerifyResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpVerifyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$OtpVerifyResponseImpl(
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
              as OtpVerifyData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpVerifyResponseImpl extends _OtpVerifyResponse {
  const _$OtpVerifyResponseImpl(
      {required this.code, required this.message, required this.data})
      : super._();

  factory _$OtpVerifyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpVerifyResponseImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final OtpVerifyData data;

  @override
  String toString() {
    return 'OtpVerifyResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpVerifyResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, data);

  /// Create a copy of OtpVerifyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpVerifyResponseImplCopyWith<_$OtpVerifyResponseImpl> get copyWith =>
      __$$OtpVerifyResponseImplCopyWithImpl<_$OtpVerifyResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpVerifyResponseImplToJson(
      this,
    );
  }
}

abstract class _OtpVerifyResponse extends OtpVerifyResponse {
  const factory _OtpVerifyResponse(
      {required final int code,
      required final String message,
      required final OtpVerifyData data}) = _$OtpVerifyResponseImpl;
  const _OtpVerifyResponse._() : super._();

  factory _OtpVerifyResponse.fromJson(Map<String, dynamic> json) =
      _$OtpVerifyResponseImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  OtpVerifyData get data;

  /// Create a copy of OtpVerifyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpVerifyResponseImplCopyWith<_$OtpVerifyResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpVerifyData _$OtpVerifyDataFromJson(Map<String, dynamic> json) {
  return _OtpVerifyData.fromJson(json);
}

/// @nodoc
mixin _$OtpVerifyData {
  String? get message =>
      throw _privateConstructorUsedError; // actual API returns `user` when registered
  OtpUser? get user =>
      throw _privateConstructorUsedError; // and tokens at the same level
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this OtpVerifyData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpVerifyData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpVerifyDataCopyWith<OtpVerifyData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpVerifyDataCopyWith<$Res> {
  factory $OtpVerifyDataCopyWith(
          OtpVerifyData value, $Res Function(OtpVerifyData) then) =
      _$OtpVerifyDataCopyWithImpl<$Res, OtpVerifyData>;
  @useResult
  $Res call(
      {String? message,
      OtpUser? user,
      String? accessToken,
      String? refreshToken});

  $OtpUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$OtpVerifyDataCopyWithImpl<$Res, $Val extends OtpVerifyData>
    implements $OtpVerifyDataCopyWith<$Res> {
  _$OtpVerifyDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpVerifyData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? user = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as OtpUser?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of OtpVerifyData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OtpUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $OtpUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OtpVerifyDataImplCopyWith<$Res>
    implements $OtpVerifyDataCopyWith<$Res> {
  factory _$$OtpVerifyDataImplCopyWith(
          _$OtpVerifyDataImpl value, $Res Function(_$OtpVerifyDataImpl) then) =
      __$$OtpVerifyDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message,
      OtpUser? user,
      String? accessToken,
      String? refreshToken});

  @override
  $OtpUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$OtpVerifyDataImplCopyWithImpl<$Res>
    extends _$OtpVerifyDataCopyWithImpl<$Res, _$OtpVerifyDataImpl>
    implements _$$OtpVerifyDataImplCopyWith<$Res> {
  __$$OtpVerifyDataImplCopyWithImpl(
      _$OtpVerifyDataImpl _value, $Res Function(_$OtpVerifyDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpVerifyData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? user = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_$OtpVerifyDataImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as OtpUser?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpVerifyDataImpl extends _OtpVerifyData {
  const _$OtpVerifyDataImpl(
      {this.message, this.user, this.accessToken, this.refreshToken})
      : super._();

  factory _$OtpVerifyDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpVerifyDataImplFromJson(json);

  @override
  final String? message;
// actual API returns `user` when registered
  @override
  final OtpUser? user;
// and tokens at the same level
  @override
  final String? accessToken;
  @override
  final String? refreshToken;

  @override
  String toString() {
    return 'OtpVerifyData(message: $message, user: $user, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpVerifyDataImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, message, user, accessToken, refreshToken);

  /// Create a copy of OtpVerifyData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpVerifyDataImplCopyWith<_$OtpVerifyDataImpl> get copyWith =>
      __$$OtpVerifyDataImplCopyWithImpl<_$OtpVerifyDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpVerifyDataImplToJson(
      this,
    );
  }
}

abstract class _OtpVerifyData extends OtpVerifyData {
  const factory _OtpVerifyData(
      {final String? message,
      final OtpUser? user,
      final String? accessToken,
      final String? refreshToken}) = _$OtpVerifyDataImpl;
  const _OtpVerifyData._() : super._();

  factory _OtpVerifyData.fromJson(Map<String, dynamic> json) =
      _$OtpVerifyDataImpl.fromJson;

  @override
  String? get message; // actual API returns `user` when registered
  @override
  OtpUser? get user; // and tokens at the same level
  @override
  String? get accessToken;
  @override
  String? get refreshToken;

  /// Create a copy of OtpVerifyData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpVerifyDataImplCopyWith<_$OtpVerifyDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpUser _$OtpUserFromJson(Map<String, dynamic> json) {
  return _OtpUser.fromJson(json);
}

/// @nodoc
mixin _$OtpUser {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  List<OtpUserRole> get roles => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  bool? get isVerified => throw _privateConstructorUsedError;

  /// Serializes this OtpUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpUserCopyWith<OtpUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpUserCopyWith<$Res> {
  factory $OtpUserCopyWith(OtpUser value, $Res Function(OtpUser) then) =
      _$OtpUserCopyWithImpl<$Res, OtpUser>;
  @useResult
  $Res call(
      {String id,
      String username,
      List<OtpUserRole> roles,
      String? status,
      @JsonKey(name: 'is_verified') bool? isVerified});
}

/// @nodoc
class _$OtpUserCopyWithImpl<$Res, $Val extends OtpUser>
    implements $OtpUserCopyWith<$Res> {
  _$OtpUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? roles = null,
    Object? status = freezed,
    Object? isVerified = freezed,
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
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<OtpUserRole>,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpUserImplCopyWith<$Res> implements $OtpUserCopyWith<$Res> {
  factory _$$OtpUserImplCopyWith(
          _$OtpUserImpl value, $Res Function(_$OtpUserImpl) then) =
      __$$OtpUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      List<OtpUserRole> roles,
      String? status,
      @JsonKey(name: 'is_verified') bool? isVerified});
}

/// @nodoc
class __$$OtpUserImplCopyWithImpl<$Res>
    extends _$OtpUserCopyWithImpl<$Res, _$OtpUserImpl>
    implements _$$OtpUserImplCopyWith<$Res> {
  __$$OtpUserImplCopyWithImpl(
      _$OtpUserImpl _value, $Res Function(_$OtpUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? roles = null,
    Object? status = freezed,
    Object? isVerified = freezed,
  }) {
    return _then(_$OtpUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<OtpUserRole>,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpUserImpl extends _OtpUser {
  const _$OtpUserImpl(
      {required this.id,
      required this.username,
      final List<OtpUserRole> roles = const <OtpUserRole>[],
      this.status,
      @JsonKey(name: 'is_verified') this.isVerified})
      : _roles = roles,
        super._();

  factory _$OtpUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpUserImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  final List<OtpUserRole> _roles;
  @override
  @JsonKey()
  List<OtpUserRole> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final String? status;
  @override
  @JsonKey(name: 'is_verified')
  final bool? isVerified;

  @override
  String toString() {
    return 'OtpUser(id: $id, username: $username, roles: $roles, status: $status, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, username,
      const DeepCollectionEquality().hash(_roles), status, isVerified);

  /// Create a copy of OtpUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpUserImplCopyWith<_$OtpUserImpl> get copyWith =>
      __$$OtpUserImplCopyWithImpl<_$OtpUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpUserImplToJson(
      this,
    );
  }
}

abstract class _OtpUser extends OtpUser {
  const factory _OtpUser(
      {required final String id,
      required final String username,
      final List<OtpUserRole> roles,
      final String? status,
      @JsonKey(name: 'is_verified') final bool? isVerified}) = _$OtpUserImpl;
  const _OtpUser._() : super._();

  factory _OtpUser.fromJson(Map<String, dynamic> json) = _$OtpUserImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  List<OtpUserRole> get roles;
  @override
  String? get status;
  @override
  @JsonKey(name: 'is_verified')
  bool? get isVerified;

  /// Create a copy of OtpUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpUserImplCopyWith<_$OtpUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpUserRole _$OtpUserRoleFromJson(Map<String, dynamic> json) {
  return _OtpUserRole.fromJson(json);
}

/// @nodoc
mixin _$OtpUserRole {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this OtpUserRole to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpUserRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpUserRoleCopyWith<OtpUserRole> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpUserRoleCopyWith<$Res> {
  factory $OtpUserRoleCopyWith(
          OtpUserRole value, $Res Function(OtpUserRole) then) =
      _$OtpUserRoleCopyWithImpl<$Res, OtpUserRole>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$OtpUserRoleCopyWithImpl<$Res, $Val extends OtpUserRole>
    implements $OtpUserRoleCopyWith<$Res> {
  _$OtpUserRoleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpUserRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpUserRoleImplCopyWith<$Res>
    implements $OtpUserRoleCopyWith<$Res> {
  factory _$$OtpUserRoleImplCopyWith(
          _$OtpUserRoleImpl value, $Res Function(_$OtpUserRoleImpl) then) =
      __$$OtpUserRoleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$OtpUserRoleImplCopyWithImpl<$Res>
    extends _$OtpUserRoleCopyWithImpl<$Res, _$OtpUserRoleImpl>
    implements _$$OtpUserRoleImplCopyWith<$Res> {
  __$$OtpUserRoleImplCopyWithImpl(
      _$OtpUserRoleImpl _value, $Res Function(_$OtpUserRoleImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpUserRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$OtpUserRoleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpUserRoleImpl extends _OtpUserRole {
  const _$OtpUserRoleImpl({required this.id, required this.name}) : super._();

  factory _$OtpUserRoleImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpUserRoleImplFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'OtpUserRole(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpUserRoleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of OtpUserRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpUserRoleImplCopyWith<_$OtpUserRoleImpl> get copyWith =>
      __$$OtpUserRoleImplCopyWithImpl<_$OtpUserRoleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpUserRoleImplToJson(
      this,
    );
  }
}

abstract class _OtpUserRole extends OtpUserRole {
  const factory _OtpUserRole(
      {required final String id,
      required final String name}) = _$OtpUserRoleImpl;
  const _OtpUserRole._() : super._();

  factory _OtpUserRole.fromJson(Map<String, dynamic> json) =
      _$OtpUserRoleImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Create a copy of OtpUserRole
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpUserRoleImplCopyWith<_$OtpUserRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
