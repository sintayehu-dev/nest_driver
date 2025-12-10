import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

// Utility class for handling app permissions
class PermissionHandlerUtil {
  // Checks and requests camera permission
  static Future<bool> requestCameraPermission(BuildContext context) async {
    try {
      PermissionStatus status = await Permission.camera.status;

      if (status.isGranted) {
        return true;
      }

      if (status.isDenied) {
        status = await Permission.camera.request();
        if (status.isGranted) {
          return true;
        }
        // If still denied after request, it might be permanently denied
        if (status.isPermanentlyDenied) {
          _showPermissionDeniedDialog(
            context,
            'Camera access is required',
            'Please enable camera access in your device settings to continue.',
          );
          return false;
        }
        return false;
      }

      if (status.isPermanentlyDenied) {
        _showPermissionDeniedDialog(
          context,
          'Camera access is required',
          'Please enable camera access in your device settings to continue.',
        );
        return false;
      }

      if (status.isRestricted || status.isLimited) {
        _showPermissionDeniedDialog(
          context,
          'Camera access is restricted',
          'Camera permissions are restricted on your device.',
        );
        return false;
      }

      // For any other status, try requesting
      status = await Permission.camera.request();
      return status.isGranted;
    } catch (e) {
      // Handle any errors
      return false;
    }
  }

  // Checks and requests photo library/storage permission
  static Future<bool> requestPhotoLibraryPermission(
      BuildContext context) async {
    try {
      PermissionStatus status;

      if (Platform.isIOS) {
        status = await Permission.photos.status;

        if (status.isGranted) {
          return true;
        }

        if (status.isDenied) {
          status = await Permission.photos.request();
          if (status.isGranted) {
            return true;
          }
          if (status.isPermanentlyDenied) {
            _showPermissionDeniedDialog(
              context,
              'Storage access is required',
              'Please enable storage/photos access in your device settings to continue.',
            );
          }
          return false;
        }

        if (status.isPermanentlyDenied) {
          _showPermissionDeniedDialog(
            context,
            'Storage access is required',
            'Please enable storage/photos access in your device settings to continue.',
          );
          return false;
        }
      } else {
        // On Android, check Android version
        if (Platform.isAndroid) {
          // For Android 13 (API 33) and above, we need to request photos permission
          if (await _isAndroid13OrAbove()) {
            status = await Permission.photos.status;

            if (status.isGranted) {
              return true;
            }

            if (status.isDenied) {
              status = await Permission.photos.request();
              if (status.isGranted) {
                return true;
              }
              if (status.isPermanentlyDenied) {
                _showPermissionDeniedDialog(
                  context,
                  'Storage access is required',
                  'Please enable storage/photos access in your device settings to continue.',
                );
              }
              return false;
            }
          } else {
            // For older Android versions, use storage permission
            status = await Permission.storage.status;

            if (status.isGranted) {
              return true;
            }

            if (status.isDenied) {
              status = await Permission.storage.request();
              if (status.isGranted) {
                return true;
              }
              if (status.isPermanentlyDenied) {
                _showPermissionDeniedDialog(
                  context,
                  'Storage access is required',
                  'Please enable storage/photos access in your device settings to continue.',
                );
              }
              return false;
            }
          }
        } else {
          // Fallback for other platforms
          status = await Permission.storage.status;

          if (status.isGranted) {
            return true;
          }

          if (status.isDenied) {
            status = await Permission.storage.request();
            return status.isGranted;
          }
        }
      }

      if (status.isPermanentlyDenied) {
        _showPermissionDeniedDialog(
          context,
          'Storage access is required',
          'Please enable storage/photos access in your device settings to continue.',
        );
        return false;
      }

      if (status.isRestricted || status.isLimited) {
        _showPermissionDeniedDialog(
          context,
          'Storage access is restricted',
          'Storage/photos permissions are restricted on your device.',
        );
        return false;
      }

      // For any other status, try requesting
      if (Platform.isAndroid && await _isAndroid13OrAbove()) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    } catch (e) {
      // Handle any errors
      return false;
    }
  }

  // Checks and requests location permission
  static Future<bool> requestLocationPermission(BuildContext context) async {
    try {
      PermissionStatus status = await Permission.location.status;

      if (status.isGranted) {
        return true;
      }

      if (status.isDenied) {
        status = await Permission.location.request();
        if (status.isGranted) {
          return true;
        }
        // If still denied after request, it might be permanently denied
        if (status.isPermanentlyDenied) {
          _showPermissionDeniedDialog(
            context,
            'Location access is required',
            'Please enable location access in your device settings to continue.',
          );
          return false;
        }
        return false;
      }

      if (status.isPermanentlyDenied) {
        _showPermissionDeniedDialog(
          context,
          'Location access is required',
          'Please enable location access in your device settings to continue.',
        );
        return false;
      }

      if (status.isRestricted || status.isLimited) {
        _showPermissionDeniedDialog(
          context,
          'Location access is restricted',
          'Location permissions are restricted on your device.',
        );
        return false;
      }

      // For any other status, try requesting
      status = await Permission.location.request();
      return status.isGranted;
    } catch (e) {
      // Handle any errors
      return false;
    }
  }

  static Future<bool> requestMicPermission(BuildContext context) async {
    var status = await Permission.microphone.status;
    // If permission is undetermined (not granted, not denied, not permanently denied)
    if (!status.isGranted && !status.isDenied && !status.isPermanentlyDenied) {
      final proceed = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(
            'Microphone Access Needed',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Melo needs access to your microphone to enable voice journaling. Your voice will be converted to text in real time. Tap Continue to allow access.',
            style: GoogleFonts.outfit(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: GoogleFonts.outfit(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Continue',
                style: GoogleFonts.outfit(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
      if (proceed != true) {
        return false;
      }
      // Now trigger the OS permission sheet
      status = await Permission.microphone.request();
    } else if (!status.isGranted) {
      // If not granted (but not undetermined), trigger OS permission sheet
      status = await Permission.microphone.request();
    }
    if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog(
        context,
        'Microphone access is required',
        'Please enable microphone access in your device settings to continue.',
      );
      return false;
    }
    return status.isGranted;
  }

  // Checks if device is running Android 13 or higher
  static Future<bool> _isAndroid13OrAbove() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt >= 33; // Android 13 is API level 33
    }
    return false;
  }

  // Shows dialog when permission is permanently denied
  static void _showPermissionDeniedDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.outfit(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.outfit(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              // Add delays to increase app lifespan when going to settings
              await _openAppSettingsWithDelay();
            },
            child: Text(
              'Open Settings',
              style: GoogleFonts.outfit(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Opens app settings with extended delays to prevent app exit
  static Future<void> _openAppSettingsWithDelay() async {
    try {
      // Wait longer to ensure dialog is fully closed and app is stable
      await Future.delayed(const Duration(milliseconds: 500));

      // Open app settings
      await openAppSettings();

      // Add additional delay after opening settings to keep app alive longer
      await Future.delayed(const Duration(milliseconds: 5000));
    } catch (e) {
      // Handle any errors silently
    }
  }

  // Shows error dialog for permission-related errors
  static void showErrorDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.outfit(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: GoogleFonts.outfit(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Checks and requests health-related permissions
  static Future<bool> requestHealthPermissions(BuildContext context) async {
    bool granted = true;
    // Request ACTIVITY_RECOGNITION
    var activityStatus = await Permission.activityRecognition.status;
    if (!activityStatus.isGranted) {
      activityStatus = await Permission.activityRecognition.request();
      if (!activityStatus.isGranted) {
        granted = false;
        showErrorDialog(
          context,
          'Activity Recognition Required',
          'Melo needs access to your physical activity to track steps and provide insights.',
        );
      }
    }
    // Request BODY_SENSORS
    var sensorsStatus = await Permission.sensors.status;
    if (!sensorsStatus.isGranted) {
      sensorsStatus = await Permission.sensors.request();
      if (!sensorsStatus.isGranted) {
        granted = false;
        showErrorDialog(
          context,
          'Body Sensors Required',
          'Melo needs access to your device sensors to read health data like heart rate.',
        );
      }
    }
    return granted;
  }
}
