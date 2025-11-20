import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/core/handlers/http_service.dart';
import 'package:nest_driver/features/driver/registration/domain/entities/driver_registration_request.dart';
import 'package:nest_driver/features/driver/registration/domain/entities/driver_registration_response.dart';

abstract class DriverRegistrationRemoteDataSource {
  Future<DriverRegistrationResponse> registerDriver(
    DriverRegistrationRequest request,
  );
}

@Injectable(as: DriverRegistrationRemoteDataSource)
class DriverRegistrationRemoteDataSourceImpl
    implements DriverRegistrationRemoteDataSource {
  @override
  Future<DriverRegistrationResponse> registerDriver(
    DriverRegistrationRequest request,
  ) async {
    // Create FormData for multipart request
    final formData = FormData();

    // Add phone number (required field)
    final phoneNumber = request.phoneNumber?.trim();
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      formData.fields.add(
        MapEntry('phone_number', phoneNumber),
      );
    } else {
      throw Exception('Phone number is required but was not provided');
    }

    // Add driver data (flat structure) - trim all string fields
    formData.fields.addAll([
      MapEntry('email', request.driver.email.trim()),
      MapEntry('full_name', request.driver.fullName.trim()),
      if (request.driver.finNumber != null)
        MapEntry('fin_number', request.driver.finNumber!.trim()),
    ]);

    // Add vehicle data (flat structure) - trim all string fields
    formData.fields.addAll([
      MapEntry('car_make', request.vehicle.carMake.trim()),
      MapEntry('car_model', request.vehicle.carModel.trim()),
      MapEntry(
        'year_of_manufacture',
        request.vehicle.yearOfManufacture.toString(),
      ),
      MapEntry('plate_number', request.vehicle.plateNumber.trim()),
      MapEntry('color', request.vehicle.color.trim()),
      MapEntry('capacity', request.vehicle.capacity.toString()),
      MapEntry('vehicle_type', request.vehicle.vehicleType.trim()),
    ]);

    // Add driver documents (direct field names)
    for (final doc in request.driverDocuments) {
      final file = File(doc.path);
      
      if (await file.exists()) {
        final fileName = file.path.split('/').last;
        formData.files.add(
          MapEntry(
            doc.docType, // Direct field name: 'profile_picture' or 'driver_license'
            await MultipartFile.fromFile(
              doc.path,
              filename: fileName,
            ),
          ),
        );
      }
    }

    // Add vehicle documents (direct field names)
    for (final doc in request.vehicleDocuments) {
      final file = File(doc.path);
      
      if (await file.exists()) {
        final fileName = file.path.split('/').last;
        // For 'other_seats', we can add multiple files with the same field name
        formData.files.add(
          MapEntry(
            doc.docType, // Direct field name: 'front_side', 'back_side', etc.
            await MultipartFile.fromFile(
              doc.path,
              filename: fileName,
            ),
          ),
        );
      }
    }

    try {
      final response = await getIt<HttpService>()
          .client(requireAuth: false, isMultipart: true)
          .post(
        '/drivers/bulk-register',
        data: formData,
      );

      return DriverRegistrationResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException {
      rethrow;
    }
  }
}


