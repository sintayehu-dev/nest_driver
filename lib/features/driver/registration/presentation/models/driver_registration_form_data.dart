import 'dart:io';

/// Model to hold all form data collected from the 5 registration pages
class DriverRegistrationFormData {
  // Phone number from OTP login/registration
  String? phoneNumber;

  // Driver Profile Page (Page 0)
  String? fullName;
  String? email;
  String? finNumber;
  File? profileImage;
  File? licenseImage;

  // Vehicle Information Page (Page 1)
  String? carMake;
  String? carModel;
  int? yearOfManufacture;
  String? plateNumber;
  String? color;
  int? capacity;
  String? vehicleType;

  // Mirrors & Wipers Page (Page 2)
  File? frontWiperPhoto;
  File? rearWiperPhoto;
  File? sideMirror1Photo;
  File? sideMirror2Photo;
  File? rearViewMirrorPhoto;

  // Exterior Photos Page (Page 3)
  File? frontPhoto;
  File? backPhoto;
  File? leftPhoto;
  File? rightPhoto;

  // Interior Photos Page (Page 4)
  File? dashboardPhoto;
  File? frontSeatsPhoto;
  File? backSeatsPhoto;
  List<File> additionalPhotos = [];
  bool agreedToTerms = false;

  /// Check if all required fields are filled
  bool get isComplete {
    return fullName != null &&
        fullName!.isNotEmpty &&
        email != null &&
        email!.isNotEmpty &&
        carMake != null &&
        carMake!.isNotEmpty &&
        carModel != null &&
        carModel!.isNotEmpty &&
        yearOfManufacture != null &&
        plateNumber != null &&
        plateNumber!.isNotEmpty &&
        color != null &&
        color!.isNotEmpty &&
        capacity != null &&
        vehicleType != null &&
        vehicleType!.isNotEmpty &&
        agreedToTerms;
  }

  /// Get validation errors
  List<String> get validationErrors {
    final errors = <String>[];
    if (fullName == null || fullName!.isEmpty) {
      errors.add('Full name is required');
    }
    if (email == null || email!.isEmpty) {
      errors.add('Email is required');
    }
    if (carMake == null || carMake!.isEmpty) {
      errors.add('Car make is required');
    }
    if (carModel == null || carModel!.isEmpty) {
      errors.add('Car model is required');
    }
    if (yearOfManufacture == null) {
      errors.add('Year of manufacture is required');
    }
    if (plateNumber == null || plateNumber!.isEmpty) {
      errors.add('Plate number is required');
    }
    if (color == null || color!.isEmpty) {
      errors.add('Color is required');
    }
    if (capacity == null) {
      errors.add('Capacity is required');
    }
    if (vehicleType == null || vehicleType!.isEmpty) {
      errors.add('Vehicle type is required');
    }
    if (!agreedToTerms) {
      errors.add('You must agree to the terms and conditions');
    }
    return errors;
  }
}

