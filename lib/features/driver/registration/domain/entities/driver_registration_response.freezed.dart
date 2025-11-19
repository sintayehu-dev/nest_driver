// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_registration_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DriverRegistrationResponse _$DriverRegistrationResponseFromJson(
    Map<String, dynamic> json) {
  return _DriverRegistrationResponse.fromJson(json);
}

/// @nodoc
mixin _$DriverRegistrationResponse {
  bool get success => throw _privateConstructorUsedError;
  DriverRegistrationData get data => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this DriverRegistrationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DriverRegistrationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverRegistrationResponseCopyWith<DriverRegistrationResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverRegistrationResponseCopyWith<$Res> {
  factory $DriverRegistrationResponseCopyWith(DriverRegistrationResponse value,
          $Res Function(DriverRegistrationResponse) then) =
      _$DriverRegistrationResponseCopyWithImpl<$Res,
          DriverRegistrationResponse>;
  @useResult
  $Res call({bool success, DriverRegistrationData data, String message});

  $DriverRegistrationDataCopyWith<$Res> get data;
}

/// @nodoc
class _$DriverRegistrationResponseCopyWithImpl<$Res,
        $Val extends DriverRegistrationResponse>
    implements $DriverRegistrationResponseCopyWith<$Res> {
  _$DriverRegistrationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverRegistrationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DriverRegistrationData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of DriverRegistrationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverRegistrationDataCopyWith<$Res> get data {
    return $DriverRegistrationDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DriverRegistrationResponseImplCopyWith<$Res>
    implements $DriverRegistrationResponseCopyWith<$Res> {
  factory _$$DriverRegistrationResponseImplCopyWith(
          _$DriverRegistrationResponseImpl value,
          $Res Function(_$DriverRegistrationResponseImpl) then) =
      __$$DriverRegistrationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, DriverRegistrationData data, String message});

  @override
  $DriverRegistrationDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$DriverRegistrationResponseImplCopyWithImpl<$Res>
    extends _$DriverRegistrationResponseCopyWithImpl<$Res,
        _$DriverRegistrationResponseImpl>
    implements _$$DriverRegistrationResponseImplCopyWith<$Res> {
  __$$DriverRegistrationResponseImplCopyWithImpl(
      _$DriverRegistrationResponseImpl _value,
      $Res Function(_$DriverRegistrationResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DriverRegistrationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
    Object? message = null,
  }) {
    return _then(_$DriverRegistrationResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DriverRegistrationData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverRegistrationResponseImpl extends _DriverRegistrationResponse {
  const _$DriverRegistrationResponseImpl(
      {required this.success, required this.data, required this.message})
      : super._();

  factory _$DriverRegistrationResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DriverRegistrationResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final DriverRegistrationData data;
  @override
  final String message;

  @override
  String toString() {
    return 'DriverRegistrationResponse(success: $success, data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverRegistrationResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, data, message);

  /// Create a copy of DriverRegistrationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverRegistrationResponseImplCopyWith<_$DriverRegistrationResponseImpl>
      get copyWith => __$$DriverRegistrationResponseImplCopyWithImpl<
          _$DriverRegistrationResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverRegistrationResponseImplToJson(
      this,
    );
  }
}

abstract class _DriverRegistrationResponse extends DriverRegistrationResponse {
  const factory _DriverRegistrationResponse(
      {required final bool success,
      required final DriverRegistrationData data,
      required final String message}) = _$DriverRegistrationResponseImpl;
  const _DriverRegistrationResponse._() : super._();

  factory _DriverRegistrationResponse.fromJson(Map<String, dynamic> json) =
      _$DriverRegistrationResponseImpl.fromJson;

  @override
  bool get success;
  @override
  DriverRegistrationData get data;
  @override
  String get message;

  /// Create a copy of DriverRegistrationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverRegistrationResponseImplCopyWith<_$DriverRegistrationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DriverRegistrationData _$DriverRegistrationDataFromJson(
    Map<String, dynamic> json) {
  return _DriverRegistrationData.fromJson(json);
}

/// @nodoc
mixin _$DriverRegistrationData {
  Driver get driver => throw _privateConstructorUsedError;
  Vehicle get vehicle => throw _privateConstructorUsedError;
  List<DriverDocument> get driverDocuments =>
      throw _privateConstructorUsedError;
  List<VehicleDocument> get vehicleDocuments =>
      throw _privateConstructorUsedError;
  Token get token => throw _privateConstructorUsedError;

  /// Serializes this DriverRegistrationData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DriverRegistrationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverRegistrationDataCopyWith<DriverRegistrationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverRegistrationDataCopyWith<$Res> {
  factory $DriverRegistrationDataCopyWith(DriverRegistrationData value,
          $Res Function(DriverRegistrationData) then) =
      _$DriverRegistrationDataCopyWithImpl<$Res, DriverRegistrationData>;
  @useResult
  $Res call(
      {Driver driver,
      Vehicle vehicle,
      List<DriverDocument> driverDocuments,
      List<VehicleDocument> vehicleDocuments,
      Token token});

  $DriverCopyWith<$Res> get driver;
  $VehicleCopyWith<$Res> get vehicle;
  $TokenCopyWith<$Res> get token;
}

/// @nodoc
class _$DriverRegistrationDataCopyWithImpl<$Res,
        $Val extends DriverRegistrationData>
    implements $DriverRegistrationDataCopyWith<$Res> {
  _$DriverRegistrationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverRegistrationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driver = null,
    Object? vehicle = null,
    Object? driverDocuments = null,
    Object? vehicleDocuments = null,
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as Driver,
      vehicle: null == vehicle
          ? _value.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as Vehicle,
      driverDocuments: null == driverDocuments
          ? _value.driverDocuments
          : driverDocuments // ignore: cast_nullable_to_non_nullable
              as List<DriverDocument>,
      vehicleDocuments: null == vehicleDocuments
          ? _value.vehicleDocuments
          : vehicleDocuments // ignore: cast_nullable_to_non_nullable
              as List<VehicleDocument>,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as Token,
    ) as $Val);
  }

  /// Create a copy of DriverRegistrationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverCopyWith<$Res> get driver {
    return $DriverCopyWith<$Res>(_value.driver, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }

  /// Create a copy of DriverRegistrationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleCopyWith<$Res> get vehicle {
    return $VehicleCopyWith<$Res>(_value.vehicle, (value) {
      return _then(_value.copyWith(vehicle: value) as $Val);
    });
  }

  /// Create a copy of DriverRegistrationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenCopyWith<$Res> get token {
    return $TokenCopyWith<$Res>(_value.token, (value) {
      return _then(_value.copyWith(token: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DriverRegistrationDataImplCopyWith<$Res>
    implements $DriverRegistrationDataCopyWith<$Res> {
  factory _$$DriverRegistrationDataImplCopyWith(
          _$DriverRegistrationDataImpl value,
          $Res Function(_$DriverRegistrationDataImpl) then) =
      __$$DriverRegistrationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Driver driver,
      Vehicle vehicle,
      List<DriverDocument> driverDocuments,
      List<VehicleDocument> vehicleDocuments,
      Token token});

  @override
  $DriverCopyWith<$Res> get driver;
  @override
  $VehicleCopyWith<$Res> get vehicle;
  @override
  $TokenCopyWith<$Res> get token;
}

/// @nodoc
class __$$DriverRegistrationDataImplCopyWithImpl<$Res>
    extends _$DriverRegistrationDataCopyWithImpl<$Res,
        _$DriverRegistrationDataImpl>
    implements _$$DriverRegistrationDataImplCopyWith<$Res> {
  __$$DriverRegistrationDataImplCopyWithImpl(
      _$DriverRegistrationDataImpl _value,
      $Res Function(_$DriverRegistrationDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DriverRegistrationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driver = null,
    Object? vehicle = null,
    Object? driverDocuments = null,
    Object? vehicleDocuments = null,
    Object? token = null,
  }) {
    return _then(_$DriverRegistrationDataImpl(
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as Driver,
      vehicle: null == vehicle
          ? _value.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as Vehicle,
      driverDocuments: null == driverDocuments
          ? _value._driverDocuments
          : driverDocuments // ignore: cast_nullable_to_non_nullable
              as List<DriverDocument>,
      vehicleDocuments: null == vehicleDocuments
          ? _value._vehicleDocuments
          : vehicleDocuments // ignore: cast_nullable_to_non_nullable
              as List<VehicleDocument>,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as Token,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverRegistrationDataImpl extends _DriverRegistrationData {
  const _$DriverRegistrationDataImpl(
      {required this.driver,
      required this.vehicle,
      final List<DriverDocument> driverDocuments = const [],
      final List<VehicleDocument> vehicleDocuments = const [],
      required this.token})
      : _driverDocuments = driverDocuments,
        _vehicleDocuments = vehicleDocuments,
        super._();

  factory _$DriverRegistrationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverRegistrationDataImplFromJson(json);

  @override
  final Driver driver;
  @override
  final Vehicle vehicle;
  final List<DriverDocument> _driverDocuments;
  @override
  @JsonKey()
  List<DriverDocument> get driverDocuments {
    if (_driverDocuments is EqualUnmodifiableListView) return _driverDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_driverDocuments);
  }

  final List<VehicleDocument> _vehicleDocuments;
  @override
  @JsonKey()
  List<VehicleDocument> get vehicleDocuments {
    if (_vehicleDocuments is EqualUnmodifiableListView)
      return _vehicleDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vehicleDocuments);
  }

  @override
  final Token token;

  @override
  String toString() {
    return 'DriverRegistrationData(driver: $driver, vehicle: $vehicle, driverDocuments: $driverDocuments, vehicleDocuments: $vehicleDocuments, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverRegistrationDataImpl &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.vehicle, vehicle) || other.vehicle == vehicle) &&
            const DeepCollectionEquality()
                .equals(other._driverDocuments, _driverDocuments) &&
            const DeepCollectionEquality()
                .equals(other._vehicleDocuments, _vehicleDocuments) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      driver,
      vehicle,
      const DeepCollectionEquality().hash(_driverDocuments),
      const DeepCollectionEquality().hash(_vehicleDocuments),
      token);

  /// Create a copy of DriverRegistrationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverRegistrationDataImplCopyWith<_$DriverRegistrationDataImpl>
      get copyWith => __$$DriverRegistrationDataImplCopyWithImpl<
          _$DriverRegistrationDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverRegistrationDataImplToJson(
      this,
    );
  }
}

abstract class _DriverRegistrationData extends DriverRegistrationData {
  const factory _DriverRegistrationData(
      {required final Driver driver,
      required final Vehicle vehicle,
      final List<DriverDocument> driverDocuments,
      final List<VehicleDocument> vehicleDocuments,
      required final Token token}) = _$DriverRegistrationDataImpl;
  const _DriverRegistrationData._() : super._();

  factory _DriverRegistrationData.fromJson(Map<String, dynamic> json) =
      _$DriverRegistrationDataImpl.fromJson;

  @override
  Driver get driver;
  @override
  Vehicle get vehicle;
  @override
  List<DriverDocument> get driverDocuments;
  @override
  List<VehicleDocument> get vehicleDocuments;
  @override
  Token get token;

  /// Create a copy of DriverRegistrationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverRegistrationDataImplCopyWith<_$DriverRegistrationDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Driver _$DriverFromJson(Map<String, dynamic> json) {
  return _Driver.fromJson(json);
}

/// @nodoc
mixin _$Driver {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String get phoneNumber => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_approved')
  bool get isApproved => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_void')
  bool get isVoid => throw _privateConstructorUsedError;

  /// Serializes this Driver to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverCopyWith<Driver> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverCopyWith<$Res> {
  factory $DriverCopyWith(Driver value, $Res Function(Driver) then) =
      _$DriverCopyWithImpl<$Res, Driver>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'phone_number') String phoneNumber,
      String email,
      @JsonKey(name: 'full_name') String fullName,
      @JsonKey(name: 'is_approved') bool isApproved,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'is_void') bool isVoid});
}

/// @nodoc
class _$DriverCopyWithImpl<$Res, $Val extends Driver>
    implements $DriverCopyWith<$Res> {
  _$DriverCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? email = null,
    Object? fullName = null,
    Object? isApproved = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = null,
    Object? isVoid = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isVoid: null == isVoid
          ? _value.isVoid
          : isVoid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DriverImplCopyWith<$Res> implements $DriverCopyWith<$Res> {
  factory _$$DriverImplCopyWith(
          _$DriverImpl value, $Res Function(_$DriverImpl) then) =
      __$$DriverImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'phone_number') String phoneNumber,
      String email,
      @JsonKey(name: 'full_name') String fullName,
      @JsonKey(name: 'is_approved') bool isApproved,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'is_void') bool isVoid});
}

/// @nodoc
class __$$DriverImplCopyWithImpl<$Res>
    extends _$DriverCopyWithImpl<$Res, _$DriverImpl>
    implements _$$DriverImplCopyWith<$Res> {
  __$$DriverImplCopyWithImpl(
      _$DriverImpl _value, $Res Function(_$DriverImpl) _then)
      : super(_value, _then);

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phoneNumber = null,
    Object? email = null,
    Object? fullName = null,
    Object? isApproved = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? userId = null,
    Object? isVoid = null,
  }) {
    return _then(_$DriverImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      isApproved: null == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isVoid: null == isVoid
          ? _value.isVoid
          : isVoid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverImpl extends _Driver {
  const _$DriverImpl(
      {required this.id,
      @JsonKey(name: 'phone_number') required this.phoneNumber,
      required this.email,
      @JsonKey(name: 'full_name') required this.fullName,
      @JsonKey(name: 'is_approved') this.isApproved = false,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'is_void') this.isVoid = false})
      : super._();

  factory _$DriverImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @override
  final String email;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  @JsonKey(name: 'is_approved')
  final bool isApproved;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'is_void')
  final bool isVoid;

  @override
  String toString() {
    return 'Driver(id: $id, phoneNumber: $phoneNumber, email: $email, fullName: $fullName, isApproved: $isApproved, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId, isVoid: $isVoid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isVoid, isVoid) || other.isVoid == isVoid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, phoneNumber, email, fullName,
      isApproved, createdAt, updatedAt, userId, isVoid);

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverImplCopyWith<_$DriverImpl> get copyWith =>
      __$$DriverImplCopyWithImpl<_$DriverImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverImplToJson(
      this,
    );
  }
}

abstract class _Driver extends Driver {
  const factory _Driver(
      {required final String id,
      @JsonKey(name: 'phone_number') required final String phoneNumber,
      required final String email,
      @JsonKey(name: 'full_name') required final String fullName,
      @JsonKey(name: 'is_approved') final bool isApproved,
      @JsonKey(name: 'created_at') required final String createdAt,
      @JsonKey(name: 'updated_at') required final String updatedAt,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'is_void') final bool isVoid}) = _$DriverImpl;
  const _Driver._() : super._();

  factory _Driver.fromJson(Map<String, dynamic> json) = _$DriverImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'phone_number')
  String get phoneNumber;
  @override
  String get email;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  @JsonKey(name: 'is_approved')
  bool get isApproved;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'is_void')
  bool get isVoid;

  /// Create a copy of Driver
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverImplCopyWith<_$DriverImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return _Vehicle.fromJson(json);
}

/// @nodoc
mixin _$Vehicle {
  String get id => throw _privateConstructorUsedError;
  Driver get driver => throw _privateConstructorUsedError;
  @JsonKey(name: 'car_make')
  String get carMake => throw _privateConstructorUsedError;
  @JsonKey(name: 'car_model')
  String get carModel => throw _privateConstructorUsedError;
  @JsonKey(name: 'year_of_manufacture')
  int get yearOfManufacture => throw _privateConstructorUsedError;
  @JsonKey(name: 'plate_number')
  String get plateNumber => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_type')
  String get vehicleType => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_void')
  bool get isVoid => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Vehicle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleCopyWith<Vehicle> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleCopyWith<$Res> {
  factory $VehicleCopyWith(Vehicle value, $Res Function(Vehicle) then) =
      _$VehicleCopyWithImpl<$Res, Vehicle>;
  @useResult
  $Res call(
      {String id,
      Driver driver,
      @JsonKey(name: 'car_make') String carMake,
      @JsonKey(name: 'car_model') String carModel,
      @JsonKey(name: 'year_of_manufacture') int yearOfManufacture,
      @JsonKey(name: 'plate_number') String plateNumber,
      String color,
      int capacity,
      @JsonKey(name: 'vehicle_type') String vehicleType,
      @JsonKey(name: 'is_void') bool isVoid,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt});

  $DriverCopyWith<$Res> get driver;
}

/// @nodoc
class _$VehicleCopyWithImpl<$Res, $Val extends Vehicle>
    implements $VehicleCopyWith<$Res> {
  _$VehicleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? driver = null,
    Object? carMake = null,
    Object? carModel = null,
    Object? yearOfManufacture = null,
    Object? plateNumber = null,
    Object? color = null,
    Object? capacity = null,
    Object? vehicleType = null,
    Object? isVoid = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as Driver,
      carMake: null == carMake
          ? _value.carMake
          : carMake // ignore: cast_nullable_to_non_nullable
              as String,
      carModel: null == carModel
          ? _value.carModel
          : carModel // ignore: cast_nullable_to_non_nullable
              as String,
      yearOfManufacture: null == yearOfManufacture
          ? _value.yearOfManufacture
          : yearOfManufacture // ignore: cast_nullable_to_non_nullable
              as int,
      plateNumber: null == plateNumber
          ? _value.plateNumber
          : plateNumber // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      vehicleType: null == vehicleType
          ? _value.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      isVoid: null == isVoid
          ? _value.isVoid
          : isVoid // ignore: cast_nullable_to_non_nullable
              as bool,
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

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverCopyWith<$Res> get driver {
    return $DriverCopyWith<$Res>(_value.driver, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VehicleImplCopyWith<$Res> implements $VehicleCopyWith<$Res> {
  factory _$$VehicleImplCopyWith(
          _$VehicleImpl value, $Res Function(_$VehicleImpl) then) =
      __$$VehicleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Driver driver,
      @JsonKey(name: 'car_make') String carMake,
      @JsonKey(name: 'car_model') String carModel,
      @JsonKey(name: 'year_of_manufacture') int yearOfManufacture,
      @JsonKey(name: 'plate_number') String plateNumber,
      String color,
      int capacity,
      @JsonKey(name: 'vehicle_type') String vehicleType,
      @JsonKey(name: 'is_void') bool isVoid,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt});

  @override
  $DriverCopyWith<$Res> get driver;
}

/// @nodoc
class __$$VehicleImplCopyWithImpl<$Res>
    extends _$VehicleCopyWithImpl<$Res, _$VehicleImpl>
    implements _$$VehicleImplCopyWith<$Res> {
  __$$VehicleImplCopyWithImpl(
      _$VehicleImpl _value, $Res Function(_$VehicleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? driver = null,
    Object? carMake = null,
    Object? carModel = null,
    Object? yearOfManufacture = null,
    Object? plateNumber = null,
    Object? color = null,
    Object? capacity = null,
    Object? vehicleType = null,
    Object? isVoid = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$VehicleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as Driver,
      carMake: null == carMake
          ? _value.carMake
          : carMake // ignore: cast_nullable_to_non_nullable
              as String,
      carModel: null == carModel
          ? _value.carModel
          : carModel // ignore: cast_nullable_to_non_nullable
              as String,
      yearOfManufacture: null == yearOfManufacture
          ? _value.yearOfManufacture
          : yearOfManufacture // ignore: cast_nullable_to_non_nullable
              as int,
      plateNumber: null == plateNumber
          ? _value.plateNumber
          : plateNumber // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      capacity: null == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int,
      vehicleType: null == vehicleType
          ? _value.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      isVoid: null == isVoid
          ? _value.isVoid
          : isVoid // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$VehicleImpl extends _Vehicle {
  const _$VehicleImpl(
      {required this.id,
      required this.driver,
      @JsonKey(name: 'car_make') required this.carMake,
      @JsonKey(name: 'car_model') required this.carModel,
      @JsonKey(name: 'year_of_manufacture') required this.yearOfManufacture,
      @JsonKey(name: 'plate_number') required this.plateNumber,
      required this.color,
      required this.capacity,
      @JsonKey(name: 'vehicle_type') required this.vehicleType,
      @JsonKey(name: 'is_void') this.isVoid = false,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : super._();

  factory _$VehicleImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleImplFromJson(json);

  @override
  final String id;
  @override
  final Driver driver;
  @override
  @JsonKey(name: 'car_make')
  final String carMake;
  @override
  @JsonKey(name: 'car_model')
  final String carModel;
  @override
  @JsonKey(name: 'year_of_manufacture')
  final int yearOfManufacture;
  @override
  @JsonKey(name: 'plate_number')
  final String plateNumber;
  @override
  final String color;
  @override
  final int capacity;
  @override
  @JsonKey(name: 'vehicle_type')
  final String vehicleType;
  @override
  @JsonKey(name: 'is_void')
  final bool isVoid;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @override
  String toString() {
    return 'Vehicle(id: $id, driver: $driver, carMake: $carMake, carModel: $carModel, yearOfManufacture: $yearOfManufacture, plateNumber: $plateNumber, color: $color, capacity: $capacity, vehicleType: $vehicleType, isVoid: $isVoid, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.carMake, carMake) || other.carMake == carMake) &&
            (identical(other.carModel, carModel) ||
                other.carModel == carModel) &&
            (identical(other.yearOfManufacture, yearOfManufacture) ||
                other.yearOfManufacture == yearOfManufacture) &&
            (identical(other.plateNumber, plateNumber) ||
                other.plateNumber == plateNumber) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.vehicleType, vehicleType) ||
                other.vehicleType == vehicleType) &&
            (identical(other.isVoid, isVoid) || other.isVoid == isVoid) &&
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
      driver,
      carMake,
      carModel,
      yearOfManufacture,
      plateNumber,
      color,
      capacity,
      vehicleType,
      isVoid,
      createdAt,
      updatedAt);

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleImplCopyWith<_$VehicleImpl> get copyWith =>
      __$$VehicleImplCopyWithImpl<_$VehicleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleImplToJson(
      this,
    );
  }
}

abstract class _Vehicle extends Vehicle {
  const factory _Vehicle(
          {required final String id,
          required final Driver driver,
          @JsonKey(name: 'car_make') required final String carMake,
          @JsonKey(name: 'car_model') required final String carModel,
          @JsonKey(name: 'year_of_manufacture')
          required final int yearOfManufacture,
          @JsonKey(name: 'plate_number') required final String plateNumber,
          required final String color,
          required final int capacity,
          @JsonKey(name: 'vehicle_type') required final String vehicleType,
          @JsonKey(name: 'is_void') final bool isVoid,
          @JsonKey(name: 'created_at') required final String createdAt,
          @JsonKey(name: 'updated_at') required final String updatedAt}) =
      _$VehicleImpl;
  const _Vehicle._() : super._();

  factory _Vehicle.fromJson(Map<String, dynamic> json) = _$VehicleImpl.fromJson;

  @override
  String get id;
  @override
  Driver get driver;
  @override
  @JsonKey(name: 'car_make')
  String get carMake;
  @override
  @JsonKey(name: 'car_model')
  String get carModel;
  @override
  @JsonKey(name: 'year_of_manufacture')
  int get yearOfManufacture;
  @override
  @JsonKey(name: 'plate_number')
  String get plateNumber;
  @override
  String get color;
  @override
  int get capacity;
  @override
  @JsonKey(name: 'vehicle_type')
  String get vehicleType;
  @override
  @JsonKey(name: 'is_void')
  bool get isVoid;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;

  /// Create a copy of Vehicle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleImplCopyWith<_$VehicleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DriverDocument _$DriverDocumentFromJson(Map<String, dynamic> json) {
  return _DriverDocument.fromJson(json);
}

/// @nodoc
mixin _$DriverDocument {
  String get id => throw _privateConstructorUsedError;
  Driver get driver => throw _privateConstructorUsedError;
  @JsonKey(name: 'doc_type')
  String get docType => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiry_date')
  String? get expiryDate => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_void')
  bool get isVoid => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DriverDocument to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DriverDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverDocumentCopyWith<DriverDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverDocumentCopyWith<$Res> {
  factory $DriverDocumentCopyWith(
          DriverDocument value, $Res Function(DriverDocument) then) =
      _$DriverDocumentCopyWithImpl<$Res, DriverDocument>;
  @useResult
  $Res call(
      {String id,
      Driver driver,
      @JsonKey(name: 'doc_type') String docType,
      @JsonKey(name: 'expiry_date') String? expiryDate,
      String path,
      @JsonKey(name: 'is_void') bool isVoid,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt});

  $DriverCopyWith<$Res> get driver;
}

/// @nodoc
class _$DriverDocumentCopyWithImpl<$Res, $Val extends DriverDocument>
    implements $DriverDocumentCopyWith<$Res> {
  _$DriverDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? driver = null,
    Object? docType = null,
    Object? expiryDate = freezed,
    Object? path = null,
    Object? isVoid = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as Driver,
      docType: null == docType
          ? _value.docType
          : docType // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String?,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      isVoid: null == isVoid
          ? _value.isVoid
          : isVoid // ignore: cast_nullable_to_non_nullable
              as bool,
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

  /// Create a copy of DriverDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverCopyWith<$Res> get driver {
    return $DriverCopyWith<$Res>(_value.driver, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DriverDocumentImplCopyWith<$Res>
    implements $DriverDocumentCopyWith<$Res> {
  factory _$$DriverDocumentImplCopyWith(_$DriverDocumentImpl value,
          $Res Function(_$DriverDocumentImpl) then) =
      __$$DriverDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Driver driver,
      @JsonKey(name: 'doc_type') String docType,
      @JsonKey(name: 'expiry_date') String? expiryDate,
      String path,
      @JsonKey(name: 'is_void') bool isVoid,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt});

  @override
  $DriverCopyWith<$Res> get driver;
}

/// @nodoc
class __$$DriverDocumentImplCopyWithImpl<$Res>
    extends _$DriverDocumentCopyWithImpl<$Res, _$DriverDocumentImpl>
    implements _$$DriverDocumentImplCopyWith<$Res> {
  __$$DriverDocumentImplCopyWithImpl(
      _$DriverDocumentImpl _value, $Res Function(_$DriverDocumentImpl) _then)
      : super(_value, _then);

  /// Create a copy of DriverDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? driver = null,
    Object? docType = null,
    Object? expiryDate = freezed,
    Object? path = null,
    Object? isVoid = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$DriverDocumentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as Driver,
      docType: null == docType
          ? _value.docType
          : docType // ignore: cast_nullable_to_non_nullable
              as String,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String?,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      isVoid: null == isVoid
          ? _value.isVoid
          : isVoid // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$DriverDocumentImpl extends _DriverDocument {
  const _$DriverDocumentImpl(
      {required this.id,
      required this.driver,
      @JsonKey(name: 'doc_type') required this.docType,
      @JsonKey(name: 'expiry_date') this.expiryDate,
      required this.path,
      @JsonKey(name: 'is_void') this.isVoid = false,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : super._();

  factory _$DriverDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverDocumentImplFromJson(json);

  @override
  final String id;
  @override
  final Driver driver;
  @override
  @JsonKey(name: 'doc_type')
  final String docType;
  @override
  @JsonKey(name: 'expiry_date')
  final String? expiryDate;
  @override
  final String path;
  @override
  @JsonKey(name: 'is_void')
  final bool isVoid;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @override
  String toString() {
    return 'DriverDocument(id: $id, driver: $driver, docType: $docType, expiryDate: $expiryDate, path: $path, isVoid: $isVoid, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.docType, docType) || other.docType == docType) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.isVoid, isVoid) || other.isVoid == isVoid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, driver, docType, expiryDate,
      path, isVoid, createdAt, updatedAt);

  /// Create a copy of DriverDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverDocumentImplCopyWith<_$DriverDocumentImpl> get copyWith =>
      __$$DriverDocumentImplCopyWithImpl<_$DriverDocumentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverDocumentImplToJson(
      this,
    );
  }
}

abstract class _DriverDocument extends DriverDocument {
  const factory _DriverDocument(
          {required final String id,
          required final Driver driver,
          @JsonKey(name: 'doc_type') required final String docType,
          @JsonKey(name: 'expiry_date') final String? expiryDate,
          required final String path,
          @JsonKey(name: 'is_void') final bool isVoid,
          @JsonKey(name: 'created_at') required final String createdAt,
          @JsonKey(name: 'updated_at') required final String updatedAt}) =
      _$DriverDocumentImpl;
  const _DriverDocument._() : super._();

  factory _DriverDocument.fromJson(Map<String, dynamic> json) =
      _$DriverDocumentImpl.fromJson;

  @override
  String get id;
  @override
  Driver get driver;
  @override
  @JsonKey(name: 'doc_type')
  String get docType;
  @override
  @JsonKey(name: 'expiry_date')
  String? get expiryDate;
  @override
  String get path;
  @override
  @JsonKey(name: 'is_void')
  bool get isVoid;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;

  /// Create a copy of DriverDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverDocumentImplCopyWith<_$DriverDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VehicleDocument _$VehicleDocumentFromJson(Map<String, dynamic> json) {
  return _VehicleDocument.fromJson(json);
}

/// @nodoc
mixin _$VehicleDocument {
  String get id => throw _privateConstructorUsedError;
  Vehicle get vehicle => throw _privateConstructorUsedError;
  @JsonKey(name: 'doc_type')
  String get docType => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_void')
  bool get isVoid => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this VehicleDocument to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehicleDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleDocumentCopyWith<VehicleDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleDocumentCopyWith<$Res> {
  factory $VehicleDocumentCopyWith(
          VehicleDocument value, $Res Function(VehicleDocument) then) =
      _$VehicleDocumentCopyWithImpl<$Res, VehicleDocument>;
  @useResult
  $Res call(
      {String id,
      Vehicle vehicle,
      @JsonKey(name: 'doc_type') String docType,
      String path,
      @JsonKey(name: 'is_void') bool isVoid,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt});

  $VehicleCopyWith<$Res> get vehicle;
}

/// @nodoc
class _$VehicleDocumentCopyWithImpl<$Res, $Val extends VehicleDocument>
    implements $VehicleDocumentCopyWith<$Res> {
  _$VehicleDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehicleDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vehicle = null,
    Object? docType = null,
    Object? path = null,
    Object? isVoid = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      vehicle: null == vehicle
          ? _value.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as Vehicle,
      docType: null == docType
          ? _value.docType
          : docType // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      isVoid: null == isVoid
          ? _value.isVoid
          : isVoid // ignore: cast_nullable_to_non_nullable
              as bool,
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

  /// Create a copy of VehicleDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleCopyWith<$Res> get vehicle {
    return $VehicleCopyWith<$Res>(_value.vehicle, (value) {
      return _then(_value.copyWith(vehicle: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$VehicleDocumentImplCopyWith<$Res>
    implements $VehicleDocumentCopyWith<$Res> {
  factory _$$VehicleDocumentImplCopyWith(_$VehicleDocumentImpl value,
          $Res Function(_$VehicleDocumentImpl) then) =
      __$$VehicleDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Vehicle vehicle,
      @JsonKey(name: 'doc_type') String docType,
      String path,
      @JsonKey(name: 'is_void') bool isVoid,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt});

  @override
  $VehicleCopyWith<$Res> get vehicle;
}

/// @nodoc
class __$$VehicleDocumentImplCopyWithImpl<$Res>
    extends _$VehicleDocumentCopyWithImpl<$Res, _$VehicleDocumentImpl>
    implements _$$VehicleDocumentImplCopyWith<$Res> {
  __$$VehicleDocumentImplCopyWithImpl(
      _$VehicleDocumentImpl _value, $Res Function(_$VehicleDocumentImpl) _then)
      : super(_value, _then);

  /// Create a copy of VehicleDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vehicle = null,
    Object? docType = null,
    Object? path = null,
    Object? isVoid = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$VehicleDocumentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      vehicle: null == vehicle
          ? _value.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as Vehicle,
      docType: null == docType
          ? _value.docType
          : docType // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      isVoid: null == isVoid
          ? _value.isVoid
          : isVoid // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$VehicleDocumentImpl extends _VehicleDocument {
  const _$VehicleDocumentImpl(
      {required this.id,
      required this.vehicle,
      @JsonKey(name: 'doc_type') required this.docType,
      required this.path,
      @JsonKey(name: 'is_void') this.isVoid = false,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : super._();

  factory _$VehicleDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleDocumentImplFromJson(json);

  @override
  final String id;
  @override
  final Vehicle vehicle;
  @override
  @JsonKey(name: 'doc_type')
  final String docType;
  @override
  final String path;
  @override
  @JsonKey(name: 'is_void')
  final bool isVoid;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @override
  String toString() {
    return 'VehicleDocument(id: $id, vehicle: $vehicle, docType: $docType, path: $path, isVoid: $isVoid, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vehicle, vehicle) || other.vehicle == vehicle) &&
            (identical(other.docType, docType) || other.docType == docType) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.isVoid, isVoid) || other.isVoid == isVoid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, vehicle, docType, path, isVoid, createdAt, updatedAt);

  /// Create a copy of VehicleDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleDocumentImplCopyWith<_$VehicleDocumentImpl> get copyWith =>
      __$$VehicleDocumentImplCopyWithImpl<_$VehicleDocumentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleDocumentImplToJson(
      this,
    );
  }
}

abstract class _VehicleDocument extends VehicleDocument {
  const factory _VehicleDocument(
          {required final String id,
          required final Vehicle vehicle,
          @JsonKey(name: 'doc_type') required final String docType,
          required final String path,
          @JsonKey(name: 'is_void') final bool isVoid,
          @JsonKey(name: 'created_at') required final String createdAt,
          @JsonKey(name: 'updated_at') required final String updatedAt}) =
      _$VehicleDocumentImpl;
  const _VehicleDocument._() : super._();

  factory _VehicleDocument.fromJson(Map<String, dynamic> json) =
      _$VehicleDocumentImpl.fromJson;

  @override
  String get id;
  @override
  Vehicle get vehicle;
  @override
  @JsonKey(name: 'doc_type')
  String get docType;
  @override
  String get path;
  @override
  @JsonKey(name: 'is_void')
  bool get isVoid;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;

  /// Create a copy of VehicleDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleDocumentImplCopyWith<_$VehicleDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Token _$TokenFromJson(Map<String, dynamic> json) {
  return _Token.fromJson(json);
}

/// @nodoc
mixin _$Token {
  @JsonKey(name: 'accessToken')
  String get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'refreshToken')
  String get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this Token to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Token
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenCopyWith<Token> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenCopyWith<$Res> {
  factory $TokenCopyWith(Token value, $Res Function(Token) then) =
      _$TokenCopyWithImpl<$Res, Token>;
  @useResult
  $Res call(
      {@JsonKey(name: 'accessToken') String accessToken,
      @JsonKey(name: 'refreshToken') String refreshToken});
}

/// @nodoc
class _$TokenCopyWithImpl<$Res, $Val extends Token>
    implements $TokenCopyWith<$Res> {
  _$TokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Token
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenImplCopyWith<$Res> implements $TokenCopyWith<$Res> {
  factory _$$TokenImplCopyWith(
          _$TokenImpl value, $Res Function(_$TokenImpl) then) =
      __$$TokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'accessToken') String accessToken,
      @JsonKey(name: 'refreshToken') String refreshToken});
}

/// @nodoc
class __$$TokenImplCopyWithImpl<$Res>
    extends _$TokenCopyWithImpl<$Res, _$TokenImpl>
    implements _$$TokenImplCopyWith<$Res> {
  __$$TokenImplCopyWithImpl(
      _$TokenImpl _value, $Res Function(_$TokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of Token
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_$TokenImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenImpl extends _Token {
  const _$TokenImpl(
      {@JsonKey(name: 'accessToken') required this.accessToken,
      @JsonKey(name: 'refreshToken') required this.refreshToken})
      : super._();

  factory _$TokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenImplFromJson(json);

  @override
  @JsonKey(name: 'accessToken')
  final String accessToken;
  @override
  @JsonKey(name: 'refreshToken')
  final String refreshToken;

  @override
  String toString() {
    return 'Token(accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  /// Create a copy of Token
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenImplCopyWith<_$TokenImpl> get copyWith =>
      __$$TokenImplCopyWithImpl<_$TokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenImplToJson(
      this,
    );
  }
}

abstract class _Token extends Token {
  const factory _Token(
          {@JsonKey(name: 'accessToken') required final String accessToken,
          @JsonKey(name: 'refreshToken') required final String refreshToken}) =
      _$TokenImpl;
  const _Token._() : super._();

  factory _Token.fromJson(Map<String, dynamic> json) = _$TokenImpl.fromJson;

  @override
  @JsonKey(name: 'accessToken')
  String get accessToken;
  @override
  @JsonKey(name: 'refreshToken')
  String get refreshToken;

  /// Create a copy of Token
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenImplCopyWith<_$TokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
