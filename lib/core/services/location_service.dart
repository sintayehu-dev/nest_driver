import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/utils/permission_handler_util.dart';

@lazySingleton
class LocationService {
  /// Ensures location service is enabled and permission is granted.
  /// Returns true when ready to read location.
  Future<bool> ensurePermission(BuildContext context) async {
    // Check service
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Prompt user to enable location
      await Geolocator.openLocationSettings();
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Leverage existing permission dialog util for consistency
      if (context.mounted) {
        PermissionHandlerUtil.showErrorDialog(
          context,
          'Location Required',
          'Please allow location access in settings to continue.',
        );
      }
      return false;
    }

    return true;
  }

  /// Get current position with best available accuracy.
  Future<Position> getCurrentPosition() async {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Opens location settings screen.
  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  /// Opens app settings to allow permissions.
  Future<bool> openAppSettings() => Geolocator.openAppSettings();
}

