// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_registration_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DriverRegistrationRequest _$DriverRegistrationRequestFromJson(
    Map<String, dynamic> json) {
  return _DriverRegistrationRequest.fromJson(json);
}

/// @nodoc
mixin _$DriverRegistrationRequest {
  @JsonKey(name: 'phone_number')
  String? get phoneNumber => throw _privateConstructorUsedError;
  DriverRequestData get driver => throw _privateConstructorUsedError;
  VehicleRequestData get vehicle => throw _privateConstructorUsedError;
  List<DriverDocumentRequestData> get driverDocuments =>
      throw _privateConstructorUsedError;
  List<VehicleDocumentRequestData> get vehicleDocuments =>
      throw _privateConstructorUsedError;

  /// Serializes this DriverRegistrationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DriverRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverRegistrationRequestCopyWith<DriverRegistrationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverRegistrationRequestCopyWith<$Res> {
  factory $DriverRegistrationRequestCopyWith(DriverRegistrationRequest value,
          $Res Function(DriverRegistrationRequest) then) =
      _$DriverRegistrationRequestCopyWithImpl<$Res, DriverRegistrationRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'phone_number') String? phoneNumber,
      DriverRequestData driver,
      VehicleRequestData vehicle,
      List<DriverDocumentRequestData> driverDocuments,
      List<VehicleDocumentRequestData> vehicleDocuments});

  $DriverRequestDataCopyWith<$Res> get driver;
  $VehicleRequestDataCopyWith<$Res> get vehicle;
}

/// @nodoc
class _$DriverRegistrationRequestCopyWithImpl<$Res,
        $Val extends DriverRegistrationRequest>
    implements $DriverRegistrationRequestCopyWith<$Res> {
  _$DriverRegistrationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = freezed,
    Object? driver = null,
    Object? vehicle = null,
    Object? driverDocuments = null,
    Object? vehicleDocuments = null,
  }) {
    return _then(_value.copyWith(
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as DriverRequestData,
      vehicle: null == vehicle
          ? _value.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as VehicleRequestData,
      driverDocuments: null == driverDocuments
          ? _value.driverDocuments
          : driverDocuments // ignore: cast_nullable_to_non_nullable
              as List<DriverDocumentRequestData>,
      vehicleDocuments: null == vehicleDocuments
          ? _value.vehicleDocuments
          : vehicleDocuments // ignore: cast_nullable_to_non_nullable
              as List<VehicleDocumentRequestData>,
    ) as $Val);
  }

  /// Create a copy of DriverRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverRequestDataCopyWith<$Res> get driver {
    return $DriverRequestDataCopyWith<$Res>(_value.driver, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }

  /// Create a copy of DriverRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VehicleRequestDataCopyWith<$Res> get vehicle {
    return $VehicleRequestDataCopyWith<$Res>(_value.vehicle, (value) {
      return _then(_value.copyWith(vehicle: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DriverRegistrationRequestImplCopyWith<$Res>
    implements $DriverRegistrationRequestCopyWith<$Res> {
  factory _$$DriverRegistrationRequestImplCopyWith(
          _$DriverRegistrationRequestImpl value,
          $Res Function(_$DriverRegistrationRequestImpl) then) =
      __$$DriverRegistrationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'phone_number') String? phoneNumber,
      DriverRequestData driver,
      VehicleRequestData vehicle,
      List<DriverDocumentRequestData> driverDocuments,
      List<VehicleDocumentRequestData> vehicleDocuments});

  @override
  $DriverRequestDataCopyWith<$Res> get driver;
  @override
  $VehicleRequestDataCopyWith<$Res> get vehicle;
}

/// @nodoc
class __$$DriverRegistrationRequestImplCopyWithImpl<$Res>
    extends _$DriverRegistrationRequestCopyWithImpl<$Res,
        _$DriverRegistrationRequestImpl>
    implements _$$DriverRegistrationRequestImplCopyWith<$Res> {
  __$$DriverRegistrationRequestImplCopyWithImpl(
      _$DriverRegistrationRequestImpl _value,
      $Res Function(_$DriverRegistrationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of DriverRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = freezed,
    Object? driver = null,
    Object? vehicle = null,
    Object? driverDocuments = null,
    Object? vehicleDocuments = null,
  }) {
    return _then(_$DriverRegistrationRequestImpl(
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      driver: null == driver
          ? _value.driver
          : driver // ignore: cast_nullable_to_non_nullable
              as DriverRequestData,
      vehicle: null == vehicle
          ? _value.vehicle
          : vehicle // ignore: cast_nullable_to_non_nullable
              as VehicleRequestData,
      driverDocuments: null == driverDocuments
          ? _value._driverDocuments
          : driverDocuments // ignore: cast_nullable_to_non_nullable
              as List<DriverDocumentRequestData>,
      vehicleDocuments: null == vehicleDocuments
          ? _value._vehicleDocuments
          : vehicleDocuments // ignore: cast_nullable_to_non_nullable
              as List<VehicleDocumentRequestData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverRegistrationRequestImpl extends _DriverRegistrationRequest {
  const _$DriverRegistrationRequestImpl(
      {@JsonKey(name: 'phone_number') this.phoneNumber,
      required this.driver,
      required this.vehicle,
      final List<DriverDocumentRequestData> driverDocuments = const [],
      final List<VehicleDocumentRequestData> vehicleDocuments = const []})
      : _driverDocuments = driverDocuments,
        _vehicleDocuments = vehicleDocuments,
        super._();

  factory _$DriverRegistrationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverRegistrationRequestImplFromJson(json);

  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @override
  final DriverRequestData driver;
  @override
  final VehicleRequestData vehicle;
  final List<DriverDocumentRequestData> _driverDocuments;
  @override
  @JsonKey()
  List<DriverDocumentRequestData> get driverDocuments {
    if (_driverDocuments is EqualUnmodifiableListView) return _driverDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_driverDocuments);
  }

  final List<VehicleDocumentRequestData> _vehicleDocuments;
  @override
  @JsonKey()
  List<VehicleDocumentRequestData> get vehicleDocuments {
    if (_vehicleDocuments is EqualUnmodifiableListView)
      return _vehicleDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vehicleDocuments);
  }

  @override
  String toString() {
    return 'DriverRegistrationRequest(phoneNumber: $phoneNumber, driver: $driver, vehicle: $vehicle, driverDocuments: $driverDocuments, vehicleDocuments: $vehicleDocuments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverRegistrationRequestImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.vehicle, vehicle) || other.vehicle == vehicle) &&
            const DeepCollectionEquality()
                .equals(other._driverDocuments, _driverDocuments) &&
            const DeepCollectionEquality()
                .equals(other._vehicleDocuments, _vehicleDocuments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      phoneNumber,
      driver,
      vehicle,
      const DeepCollectionEquality().hash(_driverDocuments),
      const DeepCollectionEquality().hash(_vehicleDocuments));

  /// Create a copy of DriverRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverRegistrationRequestImplCopyWith<_$DriverRegistrationRequestImpl>
      get copyWith => __$$DriverRegistrationRequestImplCopyWithImpl<
          _$DriverRegistrationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverRegistrationRequestImplToJson(
      this,
    );
  }
}

abstract class _DriverRegistrationRequest extends DriverRegistrationRequest {
  const factory _DriverRegistrationRequest(
          {@JsonKey(name: 'phone_number') final String? phoneNumber,
          required final DriverRequestData driver,
          required final VehicleRequestData vehicle,
          final List<DriverDocumentRequestData> driverDocuments,
          final List<VehicleDocumentRequestData> vehicleDocuments}) =
      _$DriverRegistrationRequestImpl;
  const _DriverRegistrationRequest._() : super._();

  factory _DriverRegistrationRequest.fromJson(Map<String, dynamic> json) =
      _$DriverRegistrationRequestImpl.fromJson;

  @override
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;
  @override
  DriverRequestData get driver;
  @override
  VehicleRequestData get vehicle;
  @override
  List<DriverDocumentRequestData> get driverDocuments;
  @override
  List<VehicleDocumentRequestData> get vehicleDocuments;

  /// Create a copy of DriverRegistrationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverRegistrationRequestImplCopyWith<_$DriverRegistrationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DriverRequestData _$DriverRequestDataFromJson(Map<String, dynamic> json) {
  return _DriverRequestData.fromJson(json);
}

/// @nodoc
mixin _$DriverRequestData {
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'fin_number')
  String? get finNumber => throw _privateConstructorUsedError;

  /// Serializes this DriverRequestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DriverRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverRequestDataCopyWith<DriverRequestData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverRequestDataCopyWith<$Res> {
  factory $DriverRequestDataCopyWith(
          DriverRequestData value, $Res Function(DriverRequestData) then) =
      _$DriverRequestDataCopyWithImpl<$Res, DriverRequestData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'full_name') String fullName,
      String email,
      @JsonKey(name: 'fin_number') String? finNumber});
}

/// @nodoc
class _$DriverRequestDataCopyWithImpl<$Res, $Val extends DriverRequestData>
    implements $DriverRequestDataCopyWith<$Res> {
  _$DriverRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? finNumber = freezed,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      finNumber: freezed == finNumber
          ? _value.finNumber
          : finNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DriverRequestDataImplCopyWith<$Res>
    implements $DriverRequestDataCopyWith<$Res> {
  factory _$$DriverRequestDataImplCopyWith(_$DriverRequestDataImpl value,
          $Res Function(_$DriverRequestDataImpl) then) =
      __$$DriverRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'full_name') String fullName,
      String email,
      @JsonKey(name: 'fin_number') String? finNumber});
}

/// @nodoc
class __$$DriverRequestDataImplCopyWithImpl<$Res>
    extends _$DriverRequestDataCopyWithImpl<$Res, _$DriverRequestDataImpl>
    implements _$$DriverRequestDataImplCopyWith<$Res> {
  __$$DriverRequestDataImplCopyWithImpl(_$DriverRequestDataImpl _value,
      $Res Function(_$DriverRequestDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DriverRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? finNumber = freezed,
  }) {
    return _then(_$DriverRequestDataImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      finNumber: freezed == finNumber
          ? _value.finNumber
          : finNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverRequestDataImpl extends _DriverRequestData {
  const _$DriverRequestDataImpl(
      {@JsonKey(name: 'full_name') required this.fullName,
      required this.email,
      @JsonKey(name: 'fin_number') this.finNumber})
      : super._();

  factory _$DriverRequestDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverRequestDataImplFromJson(json);

  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final String email;
  @override
  @JsonKey(name: 'fin_number')
  final String? finNumber;

  @override
  String toString() {
    return 'DriverRequestData(fullName: $fullName, email: $email, finNumber: $finNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverRequestDataImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.finNumber, finNumber) ||
                other.finNumber == finNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fullName, email, finNumber);

  /// Create a copy of DriverRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverRequestDataImplCopyWith<_$DriverRequestDataImpl> get copyWith =>
      __$$DriverRequestDataImplCopyWithImpl<_$DriverRequestDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverRequestDataImplToJson(
      this,
    );
  }
}

abstract class _DriverRequestData extends DriverRequestData {
  const factory _DriverRequestData(
          {@JsonKey(name: 'full_name') required final String fullName,
          required final String email,
          @JsonKey(name: 'fin_number') final String? finNumber}) =
      _$DriverRequestDataImpl;
  const _DriverRequestData._() : super._();

  factory _DriverRequestData.fromJson(Map<String, dynamic> json) =
      _$DriverRequestDataImpl.fromJson;

  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get email;
  @override
  @JsonKey(name: 'fin_number')
  String? get finNumber;

  /// Create a copy of DriverRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverRequestDataImplCopyWith<_$DriverRequestDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VehicleRequestData _$VehicleRequestDataFromJson(Map<String, dynamic> json) {
  return _VehicleRequestData.fromJson(json);
}

/// @nodoc
mixin _$VehicleRequestData {
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

  /// Serializes this VehicleRequestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehicleRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleRequestDataCopyWith<VehicleRequestData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleRequestDataCopyWith<$Res> {
  factory $VehicleRequestDataCopyWith(
          VehicleRequestData value, $Res Function(VehicleRequestData) then) =
      _$VehicleRequestDataCopyWithImpl<$Res, VehicleRequestData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'car_make') String carMake,
      @JsonKey(name: 'car_model') String carModel,
      @JsonKey(name: 'year_of_manufacture') int yearOfManufacture,
      @JsonKey(name: 'plate_number') String plateNumber,
      String color,
      int capacity,
      @JsonKey(name: 'vehicle_type') String vehicleType});
}

/// @nodoc
class _$VehicleRequestDataCopyWithImpl<$Res, $Val extends VehicleRequestData>
    implements $VehicleRequestDataCopyWith<$Res> {
  _$VehicleRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehicleRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carMake = null,
    Object? carModel = null,
    Object? yearOfManufacture = null,
    Object? plateNumber = null,
    Object? color = null,
    Object? capacity = null,
    Object? vehicleType = null,
  }) {
    return _then(_value.copyWith(
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VehicleRequestDataImplCopyWith<$Res>
    implements $VehicleRequestDataCopyWith<$Res> {
  factory _$$VehicleRequestDataImplCopyWith(_$VehicleRequestDataImpl value,
          $Res Function(_$VehicleRequestDataImpl) then) =
      __$$VehicleRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'car_make') String carMake,
      @JsonKey(name: 'car_model') String carModel,
      @JsonKey(name: 'year_of_manufacture') int yearOfManufacture,
      @JsonKey(name: 'plate_number') String plateNumber,
      String color,
      int capacity,
      @JsonKey(name: 'vehicle_type') String vehicleType});
}

/// @nodoc
class __$$VehicleRequestDataImplCopyWithImpl<$Res>
    extends _$VehicleRequestDataCopyWithImpl<$Res, _$VehicleRequestDataImpl>
    implements _$$VehicleRequestDataImplCopyWith<$Res> {
  __$$VehicleRequestDataImplCopyWithImpl(_$VehicleRequestDataImpl _value,
      $Res Function(_$VehicleRequestDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of VehicleRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carMake = null,
    Object? carModel = null,
    Object? yearOfManufacture = null,
    Object? plateNumber = null,
    Object? color = null,
    Object? capacity = null,
    Object? vehicleType = null,
  }) {
    return _then(_$VehicleRequestDataImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VehicleRequestDataImpl extends _VehicleRequestData {
  const _$VehicleRequestDataImpl(
      {@JsonKey(name: 'car_make') required this.carMake,
      @JsonKey(name: 'car_model') required this.carModel,
      @JsonKey(name: 'year_of_manufacture') required this.yearOfManufacture,
      @JsonKey(name: 'plate_number') required this.plateNumber,
      required this.color,
      required this.capacity,
      @JsonKey(name: 'vehicle_type') required this.vehicleType})
      : super._();

  factory _$VehicleRequestDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleRequestDataImplFromJson(json);

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
  String toString() {
    return 'VehicleRequestData(carMake: $carMake, carModel: $carModel, yearOfManufacture: $yearOfManufacture, plateNumber: $plateNumber, color: $color, capacity: $capacity, vehicleType: $vehicleType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleRequestDataImpl &&
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
                other.vehicleType == vehicleType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, carMake, carModel,
      yearOfManufacture, plateNumber, color, capacity, vehicleType);

  /// Create a copy of VehicleRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleRequestDataImplCopyWith<_$VehicleRequestDataImpl> get copyWith =>
      __$$VehicleRequestDataImplCopyWithImpl<_$VehicleRequestDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleRequestDataImplToJson(
      this,
    );
  }
}

abstract class _VehicleRequestData extends VehicleRequestData {
  const factory _VehicleRequestData(
          {@JsonKey(name: 'car_make') required final String carMake,
          @JsonKey(name: 'car_model') required final String carModel,
          @JsonKey(name: 'year_of_manufacture')
          required final int yearOfManufacture,
          @JsonKey(name: 'plate_number') required final String plateNumber,
          required final String color,
          required final int capacity,
          @JsonKey(name: 'vehicle_type') required final String vehicleType}) =
      _$VehicleRequestDataImpl;
  const _VehicleRequestData._() : super._();

  factory _VehicleRequestData.fromJson(Map<String, dynamic> json) =
      _$VehicleRequestDataImpl.fromJson;

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

  /// Create a copy of VehicleRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleRequestDataImplCopyWith<_$VehicleRequestDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DriverDocumentRequestData _$DriverDocumentRequestDataFromJson(
    Map<String, dynamic> json) {
  return _DriverDocumentRequestData.fromJson(json);
}

/// @nodoc
mixin _$DriverDocumentRequestData {
  @JsonKey(name: 'doc_type')
  String get docType => throw _privateConstructorUsedError;
  @JsonKey(name: 'expiry_date')
  String? get expiryDate => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;

  /// Serializes this DriverDocumentRequestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DriverDocumentRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverDocumentRequestDataCopyWith<DriverDocumentRequestData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverDocumentRequestDataCopyWith<$Res> {
  factory $DriverDocumentRequestDataCopyWith(DriverDocumentRequestData value,
          $Res Function(DriverDocumentRequestData) then) =
      _$DriverDocumentRequestDataCopyWithImpl<$Res, DriverDocumentRequestData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'doc_type') String docType,
      @JsonKey(name: 'expiry_date') String? expiryDate,
      String path});
}

/// @nodoc
class _$DriverDocumentRequestDataCopyWithImpl<$Res,
        $Val extends DriverDocumentRequestData>
    implements $DriverDocumentRequestDataCopyWith<$Res> {
  _$DriverDocumentRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverDocumentRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docType = null,
    Object? expiryDate = freezed,
    Object? path = null,
  }) {
    return _then(_value.copyWith(
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DriverDocumentRequestDataImplCopyWith<$Res>
    implements $DriverDocumentRequestDataCopyWith<$Res> {
  factory _$$DriverDocumentRequestDataImplCopyWith(
          _$DriverDocumentRequestDataImpl value,
          $Res Function(_$DriverDocumentRequestDataImpl) then) =
      __$$DriverDocumentRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'doc_type') String docType,
      @JsonKey(name: 'expiry_date') String? expiryDate,
      String path});
}

/// @nodoc
class __$$DriverDocumentRequestDataImplCopyWithImpl<$Res>
    extends _$DriverDocumentRequestDataCopyWithImpl<$Res,
        _$DriverDocumentRequestDataImpl>
    implements _$$DriverDocumentRequestDataImplCopyWith<$Res> {
  __$$DriverDocumentRequestDataImplCopyWithImpl(
      _$DriverDocumentRequestDataImpl _value,
      $Res Function(_$DriverDocumentRequestDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of DriverDocumentRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docType = null,
    Object? expiryDate = freezed,
    Object? path = null,
  }) {
    return _then(_$DriverDocumentRequestDataImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverDocumentRequestDataImpl extends _DriverDocumentRequestData {
  const _$DriverDocumentRequestDataImpl(
      {@JsonKey(name: 'doc_type') required this.docType,
      @JsonKey(name: 'expiry_date') this.expiryDate,
      required this.path})
      : super._();

  factory _$DriverDocumentRequestDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverDocumentRequestDataImplFromJson(json);

  @override
  @JsonKey(name: 'doc_type')
  final String docType;
  @override
  @JsonKey(name: 'expiry_date')
  final String? expiryDate;
  @override
  final String path;

  @override
  String toString() {
    return 'DriverDocumentRequestData(docType: $docType, expiryDate: $expiryDate, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverDocumentRequestDataImpl &&
            (identical(other.docType, docType) || other.docType == docType) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, docType, expiryDate, path);

  /// Create a copy of DriverDocumentRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverDocumentRequestDataImplCopyWith<_$DriverDocumentRequestDataImpl>
      get copyWith => __$$DriverDocumentRequestDataImplCopyWithImpl<
          _$DriverDocumentRequestDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverDocumentRequestDataImplToJson(
      this,
    );
  }
}

abstract class _DriverDocumentRequestData extends DriverDocumentRequestData {
  const factory _DriverDocumentRequestData(
      {@JsonKey(name: 'doc_type') required final String docType,
      @JsonKey(name: 'expiry_date') final String? expiryDate,
      required final String path}) = _$DriverDocumentRequestDataImpl;
  const _DriverDocumentRequestData._() : super._();

  factory _DriverDocumentRequestData.fromJson(Map<String, dynamic> json) =
      _$DriverDocumentRequestDataImpl.fromJson;

  @override
  @JsonKey(name: 'doc_type')
  String get docType;
  @override
  @JsonKey(name: 'expiry_date')
  String? get expiryDate;
  @override
  String get path;

  /// Create a copy of DriverDocumentRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverDocumentRequestDataImplCopyWith<_$DriverDocumentRequestDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

VehicleDocumentRequestData _$VehicleDocumentRequestDataFromJson(
    Map<String, dynamic> json) {
  return _VehicleDocumentRequestData.fromJson(json);
}

/// @nodoc
mixin _$VehicleDocumentRequestData {
  @JsonKey(name: 'doc_type')
  String get docType => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;

  /// Serializes this VehicleDocumentRequestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehicleDocumentRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleDocumentRequestDataCopyWith<VehicleDocumentRequestData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleDocumentRequestDataCopyWith<$Res> {
  factory $VehicleDocumentRequestDataCopyWith(VehicleDocumentRequestData value,
          $Res Function(VehicleDocumentRequestData) then) =
      _$VehicleDocumentRequestDataCopyWithImpl<$Res,
          VehicleDocumentRequestData>;
  @useResult
  $Res call({@JsonKey(name: 'doc_type') String docType, String path});
}

/// @nodoc
class _$VehicleDocumentRequestDataCopyWithImpl<$Res,
        $Val extends VehicleDocumentRequestData>
    implements $VehicleDocumentRequestDataCopyWith<$Res> {
  _$VehicleDocumentRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehicleDocumentRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docType = null,
    Object? path = null,
  }) {
    return _then(_value.copyWith(
      docType: null == docType
          ? _value.docType
          : docType // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VehicleDocumentRequestDataImplCopyWith<$Res>
    implements $VehicleDocumentRequestDataCopyWith<$Res> {
  factory _$$VehicleDocumentRequestDataImplCopyWith(
          _$VehicleDocumentRequestDataImpl value,
          $Res Function(_$VehicleDocumentRequestDataImpl) then) =
      __$$VehicleDocumentRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'doc_type') String docType, String path});
}

/// @nodoc
class __$$VehicleDocumentRequestDataImplCopyWithImpl<$Res>
    extends _$VehicleDocumentRequestDataCopyWithImpl<$Res,
        _$VehicleDocumentRequestDataImpl>
    implements _$$VehicleDocumentRequestDataImplCopyWith<$Res> {
  __$$VehicleDocumentRequestDataImplCopyWithImpl(
      _$VehicleDocumentRequestDataImpl _value,
      $Res Function(_$VehicleDocumentRequestDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of VehicleDocumentRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docType = null,
    Object? path = null,
  }) {
    return _then(_$VehicleDocumentRequestDataImpl(
      docType: null == docType
          ? _value.docType
          : docType // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VehicleDocumentRequestDataImpl extends _VehicleDocumentRequestData {
  const _$VehicleDocumentRequestDataImpl(
      {@JsonKey(name: 'doc_type') required this.docType, required this.path})
      : super._();

  factory _$VehicleDocumentRequestDataImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$VehicleDocumentRequestDataImplFromJson(json);

  @override
  @JsonKey(name: 'doc_type')
  final String docType;
  @override
  final String path;

  @override
  String toString() {
    return 'VehicleDocumentRequestData(docType: $docType, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleDocumentRequestDataImpl &&
            (identical(other.docType, docType) || other.docType == docType) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, docType, path);

  /// Create a copy of VehicleDocumentRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleDocumentRequestDataImplCopyWith<_$VehicleDocumentRequestDataImpl>
      get copyWith => __$$VehicleDocumentRequestDataImplCopyWithImpl<
          _$VehicleDocumentRequestDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleDocumentRequestDataImplToJson(
      this,
    );
  }
}

abstract class _VehicleDocumentRequestData extends VehicleDocumentRequestData {
  const factory _VehicleDocumentRequestData(
      {@JsonKey(name: 'doc_type') required final String docType,
      required final String path}) = _$VehicleDocumentRequestDataImpl;
  const _VehicleDocumentRequestData._() : super._();

  factory _VehicleDocumentRequestData.fromJson(Map<String, dynamic> json) =
      _$VehicleDocumentRequestDataImpl.fromJson;

  @override
  @JsonKey(name: 'doc_type')
  String get docType;
  @override
  String get path;

  /// Create a copy of VehicleDocumentRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleDocumentRequestDataImplCopyWith<_$VehicleDocumentRequestDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
