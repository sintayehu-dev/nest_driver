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
    try {
      // Create FormData for multipart request
      final formData = FormData();

      // Add driver data
      formData.fields.addAll([
        MapEntry('driver[full_name]', request.driver.fullName),
        MapEntry('driver[email]', request.driver.email),
        if (request.driver.finNumber != null)
          MapEntry('driver[fin_number]', request.driver.finNumber!),
      ]);

      // Add vehicle data
      formData.fields.addAll([
        MapEntry('vehicle[car_make]', request.vehicle.carMake),
        MapEntry('vehicle[car_model]', request.vehicle.carModel),
        MapEntry(
          'vehicle[year_of_manufacture]',
          request.vehicle.yearOfManufacture.toString(),
        ),
        MapEntry('vehicle[plate_number]', request.vehicle.plateNumber),
        MapEntry('vehicle[color]', request.vehicle.color),
        MapEntry('vehicle[capacity]', request.vehicle.capacity.toString()),
        MapEntry('vehicle[vehicle_type]', request.vehicle.vehicleType),
      ]);

      // Add driver documents
      for (var i = 0; i < request.driverDocuments.length; i++) {
        final doc = request.driverDocuments[i];
        final file = File(doc.path);
        
        if (await file.exists()) {
          final fileName = file.path.split('/').last;
          formData.files.add(
            MapEntry(
              'driverDocuments[$i][file]',
              await MultipartFile.fromFile(
                doc.path,
                filename: fileName,
              ),
            ),
          );
          formData.fields.add(
            MapEntry('driverDocuments[$i][doc_type]', doc.docType),
          );
          if (doc.expiryDate != null) {
            formData.fields.add(
              MapEntry('driverDocuments[$i][expiry_date]', doc.expiryDate!),
            );
          }
        }
      }

      // Add vehicle documents
      for (var i = 0; i < request.vehicleDocuments.length; i++) {
        final doc = request.vehicleDocuments[i];
        final file = File(doc.path);
        
        if (await file.exists()) {
          final fileName = file.path.split('/').last;
          formData.files.add(
            MapEntry(
              'vehicleDocuments[$i][file]',
              await MultipartFile.fromFile(
                doc.path,
                filename: fileName,
              ),
            ),
          );
          formData.fields.add(
            MapEntry('vehicleDocuments[$i][doc_type]', doc.docType),
          );
        }
      }

      final response = await getIt<HttpService>()
          .client(requireAuth: true, isMultipart: true)
          .post(
        '/driver/register',
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

