/// Driver availability for live location payloads.
enum DriverStatus {
  available,
  busy,
}

extension DriverStatusX on DriverStatus {
  String get wireValue {
    switch (this) {
      case DriverStatus.available:
        return 'available';
      case DriverStatus.busy:
        return 'busy';
    }
  }

  static DriverStatus fromWire(String value) {
    switch (value) {
      case 'available':
        return DriverStatus.available;
      case 'busy':
        return DriverStatus.busy;
      default:
        return DriverStatus.available;
    }
  }
}

