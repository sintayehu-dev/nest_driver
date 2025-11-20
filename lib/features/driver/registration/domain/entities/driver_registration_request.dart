import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_registration_request.freezed.dart';
part 'driver_registration_request.g.dart';

@freezed
class DriverRegistrationRequest with _$DriverRegistrationRequest {
  const factory DriverRegistrationRequest({
    @JsonKey(name: 'phone_number') String? phoneNumber,
    required DriverRequestData driver,
    required VehicleRequestData vehicle,
    @Default([]) List<DriverDocumentRequestData> driverDocuments,
    @Default([]) List<VehicleDocumentRequestData> vehicleDocuments,
  }) = _DriverRegistrationRequest;

  const DriverRegistrationRequest._();

  factory DriverRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$DriverRegistrationRequestFromJson(json);
}

@freezed
class DriverRequestData with _$DriverRequestData {
  const factory DriverRequestData({
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    @JsonKey(name: 'fin_number') String? finNumber,
  }) = _DriverRequestData;

  const DriverRequestData._();

  factory DriverRequestData.fromJson(Map<String, dynamic> json) =>
      _$DriverRequestDataFromJson(json);
}

@freezed
class VehicleRequestData with _$VehicleRequestData {
  const factory VehicleRequestData({
    @JsonKey(name: 'car_make') required String carMake,
    @JsonKey(name: 'car_model') required String carModel,
    @JsonKey(name: 'year_of_manufacture') required int yearOfManufacture,
    @JsonKey(name: 'plate_number') required String plateNumber,
    required String color,
    required int capacity,
    @JsonKey(name: 'vehicle_type') required String vehicleType,
  }) = _VehicleRequestData;

  const VehicleRequestData._();

  factory VehicleRequestData.fromJson(Map<String, dynamic> json) =>
      _$VehicleRequestDataFromJson(json);
}

@freezed
class DriverDocumentRequestData with _$DriverDocumentRequestData {
  const factory DriverDocumentRequestData({
    @JsonKey(name: 'doc_type') required String docType,
    @JsonKey(name: 'expiry_date') String? expiryDate,
    required String path, // File path or base64 encoded image
  }) = _DriverDocumentRequestData;

  const DriverDocumentRequestData._();

  factory DriverDocumentRequestData.fromJson(Map<String, dynamic> json) =>
      _$DriverDocumentRequestDataFromJson(json);
}

@freezed
class VehicleDocumentRequestData with _$VehicleDocumentRequestData {
  const factory VehicleDocumentRequestData({
    @JsonKey(name: 'doc_type') required String docType,
    required String path, // File path or base64 encoded image
  }) = _VehicleDocumentRequestData;

  const VehicleDocumentRequestData._();

  factory VehicleDocumentRequestData.fromJson(Map<String, dynamic> json) =>
      _$VehicleDocumentRequestDataFromJson(json);
}

