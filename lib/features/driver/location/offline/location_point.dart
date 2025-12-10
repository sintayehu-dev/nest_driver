import 'package:hive/hive.dart';

class LocationPoint {
  LocationPoint({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    Map<String, dynamic>? metadata,
  }) : metadata = metadata ?? <String, dynamic>{};

  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final Map<String, dynamic> metadata;
}

class LocationPointAdapter extends TypeAdapter<LocationPoint> {
  @override
  final int typeId = 101;

  @override
  LocationPoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return LocationPoint(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      timestamp: fields[2] as DateTime,
      metadata: (fields[3] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, LocationPoint obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.metadata);
  }
}

