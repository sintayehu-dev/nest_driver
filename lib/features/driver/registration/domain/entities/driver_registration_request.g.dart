// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverRegistrationRequestImpl _$$DriverRegistrationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$DriverRegistrationRequestImpl(
      driver:
          DriverRequestData.fromJson(json['driver'] as Map<String, dynamic>),
      vehicle:
          VehicleRequestData.fromJson(json['vehicle'] as Map<String, dynamic>),
      driverDocuments: (json['driverDocuments'] as List<dynamic>?)
              ?.map((e) =>
                  DriverDocumentRequestData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      vehicleDocuments: (json['vehicleDocuments'] as List<dynamic>?)
              ?.map((e) => VehicleDocumentRequestData.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$DriverRegistrationRequestImplToJson(
        _$DriverRegistrationRequestImpl instance) =>
    <String, dynamic>{
      'driver': instance.driver,
      'vehicle': instance.vehicle,
      'driverDocuments': instance.driverDocuments,
      'vehicleDocuments': instance.vehicleDocuments,
    };

_$DriverRequestDataImpl _$$DriverRequestDataImplFromJson(
        Map<String, dynamic> json) =>
    _$DriverRequestDataImpl(
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      finNumber: json['fin_number'] as String?,
    );

Map<String, dynamic> _$$DriverRequestDataImplToJson(
        _$DriverRequestDataImpl instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'fin_number': instance.finNumber,
    };

_$VehicleRequestDataImpl _$$VehicleRequestDataImplFromJson(
        Map<String, dynamic> json) =>
    _$VehicleRequestDataImpl(
      carMake: json['car_make'] as String,
      carModel: json['car_model'] as String,
      yearOfManufacture: (json['year_of_manufacture'] as num).toInt(),
      plateNumber: json['plate_number'] as String,
      color: json['color'] as String,
      capacity: (json['capacity'] as num).toInt(),
      vehicleType: json['vehicle_type'] as String,
    );

Map<String, dynamic> _$$VehicleRequestDataImplToJson(
        _$VehicleRequestDataImpl instance) =>
    <String, dynamic>{
      'car_make': instance.carMake,
      'car_model': instance.carModel,
      'year_of_manufacture': instance.yearOfManufacture,
      'plate_number': instance.plateNumber,
      'color': instance.color,
      'capacity': instance.capacity,
      'vehicle_type': instance.vehicleType,
    };

_$DriverDocumentRequestDataImpl _$$DriverDocumentRequestDataImplFromJson(
        Map<String, dynamic> json) =>
    _$DriverDocumentRequestDataImpl(
      docType: json['doc_type'] as String,
      expiryDate: json['expiry_date'] as String?,
      path: json['path'] as String,
    );

Map<String, dynamic> _$$DriverDocumentRequestDataImplToJson(
        _$DriverDocumentRequestDataImpl instance) =>
    <String, dynamic>{
      'doc_type': instance.docType,
      'expiry_date': instance.expiryDate,
      'path': instance.path,
    };

_$VehicleDocumentRequestDataImpl _$$VehicleDocumentRequestDataImplFromJson(
        Map<String, dynamic> json) =>
    _$VehicleDocumentRequestDataImpl(
      docType: json['doc_type'] as String,
      path: json['path'] as String,
    );

Map<String, dynamic> _$$VehicleDocumentRequestDataImplToJson(
        _$VehicleDocumentRequestDataImpl instance) =>
    <String, dynamic>{
      'doc_type': instance.docType,
      'path': instance.path,
    };
