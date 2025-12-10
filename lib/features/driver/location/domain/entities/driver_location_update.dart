import 'package:nest_driver/features/driver/location/domain/entities/driver_status.dart';

/// Domain entity representing a live driver location update payload.
///
/// Notes:
/// - `driver_id` must NOT be sent; backend derives it from the JWT.
/// - `status` must be `available` or `busy` (not `offline`).
/// - `bookingId` is optional (only when in an active booking).
class DriverLocationUpdate {
  const DriverLocationUpdate({
    this.bookingId,
    required this.lat,
    required this.lon,
    this.speed,
    this.heading,
    this.accuracy,
    required this.status,
    required this.timestamp,
  });

  final String? bookingId;
  final double lat;
  final double lon;
  final double? speed;
  final double? heading;
  final double? accuracy;
  final DriverStatus status;
  final DateTime timestamp;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'booking_id': bookingId,
      'lat': lat,
      'lon': lon,
      'speed': speed,
      'heading': heading,
      'accuracy': accuracy,
      'status': status.wireValue,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  DriverLocationUpdate copyWith({
    String? bookingId,
    double? lat,
    double? lon,
    double? speed,
    double? heading,
    double? accuracy,
    DriverStatus? status,
    DateTime? timestamp,
  }) {
    return DriverLocationUpdate(
      bookingId: bookingId ?? this.bookingId,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      speed: speed ?? this.speed,
      heading: heading ?? this.heading,
      accuracy: accuracy ?? this.accuracy,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

