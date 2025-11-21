part of 'driver_registration_bloc.dart';

@freezed
class DriverRegistrationEvent with _$DriverRegistrationEvent {
  // Initialize with phone number
  const factory DriverRegistrationEvent.initialized({
    String? phoneNumber,
  }) = DriverRegistrationInitialized;

  // Driver Profile Page fields
  const factory DriverRegistrationEvent.fullNameChanged(String fullName) = FullNameChanged;
  const factory DriverRegistrationEvent.emailChanged(String email) = EmailChanged;
  const factory DriverRegistrationEvent.finNumberChanged(String finNumber) = FinNumberChanged;
  const factory DriverRegistrationEvent.profileImageChanged(String? imagePath) = ProfileImageChanged;
  const factory DriverRegistrationEvent.licenseImageChanged(String? imagePath) = LicenseImageChanged;

  // Vehicle Information Page fields
  const factory DriverRegistrationEvent.carMakeChanged(String carMake) = CarMakeChanged;
  const factory DriverRegistrationEvent.carModelChanged(String carModel) = CarModelChanged;
  const factory DriverRegistrationEvent.yearOfManufactureChanged(int year) = YearOfManufactureChanged;
  const factory DriverRegistrationEvent.plateNumberChanged(String plateNumber) = PlateNumberChanged;
  const factory DriverRegistrationEvent.colorChanged(String color) = ColorChanged;
  const factory DriverRegistrationEvent.capacityChanged(int capacity) = CapacityChanged;
  const factory DriverRegistrationEvent.vehicleTypeChanged(String vehicleType) = VehicleTypeChanged;

  // Photo pages fields
  const factory DriverRegistrationEvent.frontWiperPhotoChanged(String? imagePath) = FrontWiperPhotoChanged;
  const factory DriverRegistrationEvent.rearWiperPhotoChanged(String? imagePath) = RearWiperPhotoChanged;
  const factory DriverRegistrationEvent.sideMirror1PhotoChanged(String? imagePath) = SideMirror1PhotoChanged;
  const factory DriverRegistrationEvent.sideMirror2PhotoChanged(String? imagePath) = SideMirror2PhotoChanged;
  const factory DriverRegistrationEvent.rearViewMirrorPhotoChanged(String? imagePath) = RearViewMirrorPhotoChanged;
  const factory DriverRegistrationEvent.frontPhotoChanged(String? imagePath) = FrontPhotoChanged;
  const factory DriverRegistrationEvent.backPhotoChanged(String? imagePath) = BackPhotoChanged;
  const factory DriverRegistrationEvent.leftPhotoChanged(String? imagePath) = LeftPhotoChanged;
  const factory DriverRegistrationEvent.rightPhotoChanged(String? imagePath) = RightPhotoChanged;
  const factory DriverRegistrationEvent.dashboardPhotoChanged(String? imagePath) = DashboardPhotoChanged;
  const factory DriverRegistrationEvent.frontSeatsPhotoChanged(String? imagePath) = FrontSeatsPhotoChanged;
  const factory DriverRegistrationEvent.backSeatsPhotoChanged(String? imagePath) = BackSeatsPhotoChanged;
  const factory DriverRegistrationEvent.additionalPhotosChanged(List<String> imagePaths) = AdditionalPhotosChanged;
  const factory DriverRegistrationEvent.termsAcceptedChanged(bool accepted) = TermsAcceptedChanged;

  // Navigation events
  const factory DriverRegistrationEvent.nextPage() = NextPage;
  const factory DriverRegistrationEvent.previousPage() = PreviousPage;
  const factory DriverRegistrationEvent.pageChanged(int pageIndex) = PageChanged;

  // Submit
  const factory DriverRegistrationEvent.submitForm() = SubmitForm;

  // Legacy submit (for backward compatibility)
  const factory DriverRegistrationEvent.submitted({
    String? phoneNumber,
    required DriverRequestData driverData,
    required VehicleRequestData vehicleData,
    required List<DriverDocumentRequestData> driverDocuments,
    required List<VehicleDocumentRequestData> vehicleDocuments,
  }) = DriverRegistrationSubmitted;
}
