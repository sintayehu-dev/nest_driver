// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverRegistrationResponseImpl _$$DriverRegistrationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DriverRegistrationResponseImpl(
      success: json['success'] as bool,
      data:
          DriverRegistrationData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$DriverRegistrationResponseImplToJson(
        _$DriverRegistrationResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

_$DriverRegistrationDataImpl _$$DriverRegistrationDataImplFromJson(
        Map<String, dynamic> json) =>
    _$DriverRegistrationDataImpl(
      driver: Driver.fromJson(json['driver'] as Map<String, dynamic>),
      vehicle: Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
      driverDocuments: (json['driverDocuments'] as List<dynamic>?)
              ?.map((e) => DriverDocument.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      vehicleDocuments: (json['vehicleDocuments'] as List<dynamic>?)
              ?.map((e) => VehicleDocument.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      token: Token.fromJson(json['token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DriverRegistrationDataImplToJson(
        _$DriverRegistrationDataImpl instance) =>
    <String, dynamic>{
      'driver': instance.driver,
      'vehicle': instance.vehicle,
      'driverDocuments': instance.driverDocuments,
      'vehicleDocuments': instance.vehicleDocuments,
      'token': instance.token,
    };

_$DriverImpl _$$DriverImplFromJson(Map<String, dynamic> json) => _$DriverImpl(
      id: json['id'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      isApproved: json['is_approved'] as bool? ?? false,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      userId: json['user_id'] as String,
      isVoid: json['is_void'] as bool? ?? false,
    );

Map<String, dynamic> _$$DriverImplToJson(_$DriverImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'full_name': instance.fullName,
      'is_approved': instance.isApproved,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user_id': instance.userId,
      'is_void': instance.isVoid,
    };

_$VehicleImpl _$$VehicleImplFromJson(Map<String, dynamic> json) =>
    _$VehicleImpl(
      id: json['id'] as String,
      driver: Driver.fromJson(json['driver'] as Map<String, dynamic>),
      carMake: json['car_make'] as String,
      carModel: json['car_model'] as String,
      yearOfManufacture: (json['year_of_manufacture'] as num).toInt(),
      plateNumber: json['plate_number'] as String,
      color: json['color'] as String,
      capacity: (json['capacity'] as num).toInt(),
      vehicleType: json['vehicle_type'] as String,
      isVoid: json['is_void'] as bool? ?? false,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$$VehicleImplToJson(_$VehicleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'driver': instance.driver,
      'car_make': instance.carMake,
      'car_model': instance.carModel,
      'year_of_manufacture': instance.yearOfManufacture,
      'plate_number': instance.plateNumber,
      'color': instance.color,
      'capacity': instance.capacity,
      'vehicle_type': instance.vehicleType,
      'is_void': instance.isVoid,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$DriverDocumentImpl _$$DriverDocumentImplFromJson(Map<String, dynamic> json) =>
    _$DriverDocumentImpl(
      id: json['id'] as String,
      driver: Driver.fromJson(json['driver'] as Map<String, dynamic>),
      docType: json['doc_type'] as String,
      expiryDate: json['expiry_date'] as String?,
      path: json['path'] as String,
      isVoid: json['is_void'] as bool? ?? false,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$$DriverDocumentImplToJson(
        _$DriverDocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'driver': instance.driver,
      'doc_type': instance.docType,
      'expiry_date': instance.expiryDate,
      'path': instance.path,
      'is_void': instance.isVoid,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$VehicleDocumentImpl _$$VehicleDocumentImplFromJson(
        Map<String, dynamic> json) =>
    _$VehicleDocumentImpl(
      id: json['id'] as String,
      vehicle: Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
      docType: json['doc_type'] as String,
      path: json['path'] as String,
      isVoid: json['is_void'] as bool? ?? false,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$$VehicleDocumentImplToJson(
        _$VehicleDocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicle': instance.vehicle,
      'doc_type': instance.docType,
      'path': instance.path,
      'is_void': instance.isVoid,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

_$TokenImpl _$$TokenImplFromJson(Map<String, dynamic> json) => _$TokenImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$$TokenImplToJson(_$TokenImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
