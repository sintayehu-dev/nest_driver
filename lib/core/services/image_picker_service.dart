import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/utils/permission_handler_util.dart';
import 'dart:developer' as dev;
import 'dart:io';

/// A service class to handle image picking functionality
@injectable
class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();
  
  /// Take a photo using the device camera
  /// Returns the file path if successful, null otherwise
  Future<String?> takePhoto(
    BuildContext context, {
    double maxWidth = 800,
    double maxHeight = 800,
    int imageQuality = 85,
  }) async {
    dev.log('ImagePickerService: Starting takePhoto');
    
    final hasPermission =
        await PermissionHandlerUtil.requestCameraPermission(context);
    dev.log('ImagePickerService: Camera permission granted: $hasPermission');
    
    if (!hasPermission) {
      dev.log('ImagePickerService: Camera permission denied');
      return null;
    }
    
    try {
      dev.log('ImagePickerService: Attempting to take photo');
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );
      
      if (pickedImage != null) {
        dev.log(
            'ImagePickerService: Photo taken successfully: ${pickedImage.path}');
        
        // Verify file exists
        final file = File(pickedImage.path);
        final exists = await file.exists();
        dev.log('ImagePickerService: File exists: $exists');
        
        return pickedImage.path;
      } else {
        dev.log('ImagePickerService: No photo was taken (pickedImage is null)');
        return null;
      }
    } catch (e) {
      dev.log('ImagePickerService: Error taking photo: $e');
      // Only show error if context is still valid
      if (context.mounted) {
        PermissionHandlerUtil.showErrorDialog(
          context,
          'Camera Error',
          'Could not access camera. Please try again.',
        );
      }
      return null;
    }
  }
  
  /// Choose an image from the device gallery
  /// Returns the file path if successful, null otherwise
  Future<String?> chooseFromGallery(
    BuildContext context, {
    double maxWidth = 800,
    double maxHeight = 800,
    int imageQuality = 85,
  }) async {
    dev.log('ImagePickerService: Starting chooseFromGallery');
    
    final hasPermission =
        await PermissionHandlerUtil.requestPhotoLibraryPermission(context);
    dev.log('ImagePickerService: Gallery permission granted: $hasPermission');
    
    if (!hasPermission) {
      dev.log('ImagePickerService: Gallery permission denied');
      return null;
    }
    
    try {
      dev.log('ImagePickerService: Attempting to pick image from gallery');
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );
      
      if (pickedImage != null) {
        dev.log(
            'ImagePickerService: Image picked successfully: ${pickedImage.path}');
        
        // Verify file exists
        final file = File(pickedImage.path);
        final exists = await file.exists();
        dev.log(
            'ImagePickerService: File exists: $exists, file size: ${await file.length()} bytes');
        
        return pickedImage.path;
      } else {
        dev.log(
            'ImagePickerService: No image was picked (pickedImage is null)');
        return null;
      }
    } catch (e) {
      dev.log('ImagePickerService: Error picking image: $e');
      // Only show error if context is still valid
      if (context.mounted) {
        PermissionHandlerUtil.showErrorDialog(
          context,
          'Gallery Error',
          'Could not access photo gallery. Please try again.',
        );
      }
      return null;
    }
  }
  
  /// Show a bottom sheet to select image source (camera or gallery)
  /// Returns the selected image path, or null if canceled or error
  Future<String?> showImageSourceSelectionDialog(
    BuildContext context, {
    String? currentImagePath,
    double maxWidth = 800,
    double maxHeight = 800,
    int imageQuality = 85,
  }) async {
    dev.log('ImagePickerService: Showing image source selection bottom sheet');
    
    final selectedSource = await showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              // Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: Text(
                  'Select Image Source',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Camera option
              ListTile(
                leading: Icon(Icons.camera_alt_rounded, color: Theme.of(context).colorScheme.primary),
                title: Text('Take a Photo', style: GoogleFonts.outfit()),
                onTap: () {
                  dev.log('ImagePickerService: Camera option selected');
                  Navigator.pop(context, 'camera');
                },
              ),
              // Gallery option
              ListTile(
                leading: Icon(Icons.photo_library_rounded, color: Theme.of(context).colorScheme.primary),
                title: Text('Choose from Gallery', style: GoogleFonts.outfit()),
                onTap: () {
                  dev.log('ImagePickerService: Gallery option selected');
                  Navigator.pop(context, 'gallery');
                },
              ),
              // Remove photo option (only if there's a current image)
              if (currentImagePath != null)
                ListTile(
                  leading: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                  title: Text('Remove Photo', style: GoogleFonts.outfit(color: Colors.red)),
                  onTap: () {
                    dev.log('ImagePickerService: Remove photo option selected');
                    Navigator.pop(context, 'remove'); // 'remove' indicates remove action
                  },
                ),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
    
    if (selectedSource == null) {
      dev.log('ImagePickerService: Bottom sheet cancelled');
      return null;
    }
    
    if (selectedSource == 'remove') {
      dev.log('ImagePickerService: Photo removed (empty string result)');
      return ''; // Empty string indicates remove action
    }
    
    String? result;
    if (selectedSource == 'camera') {
      result = await takePhoto(
        context,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );
      dev.log('ImagePickerService: Camera result: $result');
    } else if (selectedSource == 'gallery') {
      result = await chooseFromGallery(
        context,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );
      dev.log('ImagePickerService: Gallery result: $result');
    }
    
    dev.log('ImagePickerService: Bottom sheet closed, final result: $result');
    return result;
  }
} 
