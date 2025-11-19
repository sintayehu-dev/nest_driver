import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_registration_response.freezed.dart';
part 'driver_registration_response.g.dart';

@freezed
class DriverRegistrationResponse with _$DriverRegistrationResponse {
  const factory DriverRegistrationResponse({
    required bool success,
    required DriverRegistrationData data,
    required String message,
  }) = _DriverRegistrationResponse;

  const DriverRegistrationResponse._();

  factory DriverRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$DriverRegistrationResponseFromJson(json);
}

@freezed
class DriverRegistrationData with _$DriverRegistrationData {
  const factory DriverRegistrationData({
    required Driver driver,
    required Vehicle vehicle,
    @Default([]) List<DriverDocument> driverDocuments,
    @Default([]) List<VehicleDocument> vehicleDocuments,
    required Token token,
  }) = _DriverRegistrationData;

  const DriverRegistrationData._();

  factory DriverRegistrationData.fromJson(Map<String, dynamic> json) =>
      _$DriverRegistrationDataFromJson(json);
}

@freezed
class Driver with _$Driver {
  const factory Driver({
    required String id,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    required String email,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'is_approved') @Default(false) bool isApproved,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'is_void') @Default(false) bool isVoid,
  }) = _Driver;

  const Driver._();

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
}

@freezed
class Vehicle with _$Vehicle {
  const factory Vehicle({
    required String id,
    required Driver driver,
    @JsonKey(name: 'car_make') required String carMake,
    @JsonKey(name: 'car_model') required String carModel,
    @JsonKey(name: 'year_of_manufacture') required int yearOfManufacture,
    @JsonKey(name: 'plate_number') required String plateNumber,
    required String color,
    required int capacity,
    @JsonKey(name: 'vehicle_type') required String vehicleType,
    @JsonKey(name: 'is_void') @Default(false) bool isVoid,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _Vehicle;

  const Vehicle._();

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);
}

@freezed
class DriverDocument with _$DriverDocument {
  const factory DriverDocument({
    required String id,
    required Driver driver,
    @JsonKey(name: 'doc_type') required String docType,
    @JsonKey(name: 'expiry_date') String? expiryDate,
    required String path,
    @JsonKey(name: 'is_void') @Default(false) bool isVoid,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _DriverDocument;

  const DriverDocument._();

  factory DriverDocument.fromJson(Map<String, dynamic> json) =>
      _$DriverDocumentFromJson(json);
}

@freezed
class VehicleDocument with _$VehicleDocument {
  const factory VehicleDocument({
    required String id,
    required Vehicle vehicle,
    @JsonKey(name: 'doc_type') required String docType,
    required String path,
    @JsonKey(name: 'is_void') @Default(false) bool isVoid,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _VehicleDocument;

  const VehicleDocument._();

  factory VehicleDocument.fromJson(Map<String, dynamic> json) =>
      _$VehicleDocumentFromJson(json);
}

@freezed
class Token with _$Token {
  const factory Token({
    @JsonKey(name: 'accessToken') required String accessToken,
    @JsonKey(name: 'refreshToken') required String refreshToken,
  }) = _Token;

  const Token._();

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}
