/// Acknowledgement returned by backend after a live location update.
class LocationUpdateAck {
  const LocationUpdateAck({
    required this.success,
    required this.timestamp,
    this.message,
  });

  final bool success;
  final String? message;
  final DateTime timestamp;

  factory LocationUpdateAck.fromJson(Map<String, dynamic> json) {
    return LocationUpdateAck(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      timestamp: DateTime.tryParse(json['timestamp'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

