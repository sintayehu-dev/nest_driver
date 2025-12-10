import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/utils/permission_handler_util.dart';

@lazySingleton
class LocationService {
  // Ensures location service and permission are ready
  Future<bool> ensurePermission(BuildContext context) async {
    if (!context.mounted) return false;

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (context.mounted) _showLocationServiceDialog(context);
        return false;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final granted =
            await PermissionHandlerUtil.requestLocationPermission(context);
        if (granted) {
          permission = await Geolocator.checkPermission();
        } else {
          return false;
        }
      }

      if (!context.mounted) {
        return permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse;
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (context.mounted) {
          _showLocationPermissionDeniedDialog(
            context,
            'Location Access Required',
            'This app needs location access to show your current position and provide location-based services.',
          );
        }
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  // Shows dialog when location service is disabled
  void _showLocationServiceDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Location Service Disabled',
          style: theme.textTheme.titleMedium,
        ),
        content: Text(
          'Please enable location services in your device settings to continue.',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Opens device location settings
  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  // Opens app settings for permissions
  Future<bool> openAppSettings() => Geolocator.openAppSettings();

  // Shows dialog when location permission is denied
  void _showLocationPermissionDeniedDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    final theme = Theme.of(context);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: theme.textTheme.titleMedium,
        ),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _requestLocationPermissionWithExtendedLifespan(context);
            },
            child: Text(
              'Open Settings',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Checks if location permission is granted without requesting
  Future<bool> isLocationPermissionGranted() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return false;

      final permission = await Geolocator.checkPermission();
      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      return false;
    }
  }

  // Requests location permission with extended app lifespan
  Future<void> _requestLocationPermissionWithExtendedLifespan(
      BuildContext context) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      if (!context.mounted) return;

      final keepAliveTimer =
          Timer.periodic(const Duration(seconds: 2), (timer) {
        if (timer.tick >= 30) timer.cancel();
      });

      await PermissionHandlerUtil.requestLocationPermission(context);

      Future.delayed(const Duration(seconds: 5), () {
        keepAliveTimer.cancel();
      });
    } catch (e) {
      // Handle errors silently
    }
  }

  // Gets current position with high accuracy
  Future<Position> getCurrentPosition() async {
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }
}
