part of 'driver_registration_bloc.dart';

@freezed
class DriverRegistrationState with _$DriverRegistrationState {
  const factory DriverRegistrationState({
    // Value objects for driver profile
    required PhoneNumber phoneNumber,
    required FullName fullName,
    required EmailAddress email,
    required FinNumber finNumber,
    
    // Value objects for vehicle information
    required CarMake carMake,
    required CarModel carModel,
    required YearOfManufacture yearOfManufacture,
    required PlateNumber plateNumber,
    required VehicleColor color,
    required VehicleCapacity capacity,
    required VehicleType vehicleType,
    
    // Image paths (stored as strings, converted to File when needed)
    @Default('') String profileImagePath,
    @Default('') String licenseImagePath,
    String? frontWiperPhotoPath,
    String? rearWiperPhotoPath,
    String? sideMirror1PhotoPath,
    String? sideMirror2PhotoPath,
    String? rearViewMirrorPhotoPath,
    String? frontPhotoPath,
    String? backPhotoPath,
    String? leftPhotoPath,
    String? rightPhotoPath,
    String? dashboardPhotoPath,
    String? frontSeatsPhotoPath,
    String? backSeatsPhotoPath,
    @Default([]) List<String> additionalPhotoPaths,
    
    // Terms
    @Default(false) bool termsAccepted,
    
    // UI state
    @Default(0) int currentPage,
    @Default(<int>{}) Set<int> validatedPages,
    String? firstInvalidField,
    @Default(false) bool showErrorMessages,
    
    // Navigation flags
    bool? shouldNavigateNext,
    bool? shouldNavigatePrevious,
    
    // API state
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default(false) bool isSuccess,
    DriverRegistrationResponse? response,
    @Default(false) bool sessionCreated,
  }) = _DriverRegistrationState;

  const DriverRegistrationState._();
}
