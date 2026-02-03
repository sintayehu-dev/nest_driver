import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PermissionHandlerUtil {
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

      status = await Permission.camera.request();
      return status.isGranted;
    } catch (e) {
      return false;
    }
  }

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
        if (Platform.isAndroid) {
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

      if (Platform.isAndroid && await _isAndroid13OrAbove()) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    } catch (e) {
      return false;
    }
  }

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

      status = await Permission.location.request();
      return status.isGranted;
    } catch (e) {
      // Handle any errors
      return false;
    }
  }

  static Future<bool> requestMicPermission(BuildContext context) async {
    var status = await Permission.microphone.status;
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
      status = await Permission.microphone.request();
    } else if (!status.isGranted) {
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

  static Future<bool> _isAndroid13OrAbove() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt >= 33;
    }
    return false;
  }

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

  static Future<void> _openAppSettingsWithDelay() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      await openAppSettings();
      await Future.delayed(const Duration(milliseconds: 5000));
    } catch (e) {}
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

  static Future<bool> requestHealthPermissions(BuildContext context) async {
    bool granted = true;
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
