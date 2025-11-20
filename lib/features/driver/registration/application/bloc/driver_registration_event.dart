part of 'driver_registration_bloc.dart';

@freezed
class DriverRegistrationEvent with _$DriverRegistrationEvent {
  const factory DriverRegistrationEvent.submitted({
    String? phoneNumber,
    required DriverRequestData driverData,
    required VehicleRequestData vehicleData,
    required List<DriverDocumentRequestData> driverDocuments,
    required List<VehicleDocumentRequestData> vehicleDocuments,
  }) = DriverRegistrationSubmitted;
}

