import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/utils/permission_handler_util.dart';
import 'dart:developer' as dev;
import 'dart:io';

/// A service class to handle file picking functionality
@injectable
class FilePickerService {
  /// Pick a file from the device storage
  /// Returns the file path if successful, null otherwise
  Future<String?> pickFile(
    BuildContext context, {
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    bool allowMultiple = false,
  }) async {
    dev.log('FilePickerService: Starting pickFile');
    
    // Check if context is still valid
    if (!context.mounted) {
      dev.log('FilePickerService: Context is no longer mounted');
      return null;
    }
    
    // Request storage permission for file access
    final hasPermission =
        await PermissionHandlerUtil.requestPhotoLibraryPermission(context);
    dev.log('FilePickerService: Storage permission granted: $hasPermission');
    
    if (!hasPermission) {
      dev.log('FilePickerService: Storage permission denied');
      return null;
    }
    
    // Check context again after permission request (async operation)
    if (!context.mounted) {
      dev.log('FilePickerService: Context is no longer mounted after permission request');
      return null;
    }
    
    try {
      dev.log('FilePickerService: Attempting to pick file');
      
      // Add a small delay to ensure platform is ready
      await Future.delayed(const Duration(milliseconds: 100));
      
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        allowMultiple: allowMultiple,
      );
      
      // Check context after file picker returns (app might have gone to background)
      if (!context.mounted) {
        dev.log('FilePickerService: Context is no longer mounted after file picker returned');
        // Still return the file path if we got one, even if context is invalid
        if (result != null && result.files.single.path != null) {
          return result.files.single.path;
        }
        return null;
      }
      
      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        dev.log('FilePickerService: File picked successfully: $filePath');
        
        // Verify file exists
        try {
          final file = File(filePath);
          final exists = await file.exists();
          dev.log('FilePickerService: File exists: $exists');
          
          if (!exists) {
            dev.log('FilePickerService: File does not exist at path: $filePath');
            return null;
          }
          
          return filePath;
        } catch (e) {
          dev.log('FilePickerService: Error verifying file: $e');
          return null;
        }
      } else {
        dev.log('FilePickerService: No file was picked (result is null or path is null)');
        return null;
      }
    } catch (e, stackTrace) {
      dev.log('FilePickerService: Error picking file: $e');
      dev.log('FilePickerService: Stack trace: $stackTrace');
      
      // Handle LateInitializationError specifically
      if (e.toString().contains('LateInitializationError') || 
          e.toString().contains('has not been initialized')) {
        dev.log('FilePickerService: Plugin not initialized, retrying...');
        // Retry once after a short delay
        try {
          await Future.delayed(const Duration(milliseconds: 300));
          final FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: type,
            allowedExtensions: allowedExtensions,
            allowMultiple: allowMultiple,
          );
          
          if (result != null && result.files.single.path != null) {
            final filePath = result.files.single.path!;
            final file = File(filePath);
            final exists = await file.exists();
            if (exists) {
              return filePath;
            }
          }
        } catch (retryError) {
          dev.log('FilePickerService: Retry also failed: $retryError');
        }
      }
      
      // Only show error if context is still valid
      if (context.mounted) {
        PermissionHandlerUtil.showErrorDialog(
          context,
          'File Picker Error',
          'Could not access file picker. Please try again.',
        );
      }
      return null;
    }
  }
  
  /// Pick multiple files from the device storage
  /// Returns a list of file paths if successful, empty list otherwise
  Future<List<String>> pickMultipleFiles(
    BuildContext context, {
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    dev.log('FilePickerService: Starting pickMultipleFiles');
    
    final hasPermission =
        await PermissionHandlerUtil.requestPhotoLibraryPermission(context);
    dev.log('FilePickerService: Storage permission granted: $hasPermission');
    
    if (!hasPermission) {
      dev.log('FilePickerService: Storage permission denied');
      return [];
    }
    
    try {
      dev.log('FilePickerService: Attempting to pick multiple files');
      
      // Add a small delay to ensure platform is ready
      await Future.delayed(const Duration(milliseconds: 100));
      
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        allowMultiple: true,
      );
      
      if (result != null && result.files.isNotEmpty) {
        final filePaths = result.files
            .where((file) => file.path != null)
            .map((file) => file.path!)
            .toList();
        
        dev.log('FilePickerService: ${filePaths.length} file(s) picked successfully');
        
        // Verify all files exist
        final validPaths = <String>[];
        for (final filePath in filePaths) {
          try {
            final file = File(filePath);
            final exists = await file.exists();
            if (exists) {
              validPaths.add(filePath);
            } else {
              dev.log('FilePickerService: File does not exist at path: $filePath');
            }
          } catch (e) {
            dev.log('FilePickerService: Error verifying file $filePath: $e');
          }
        }
        
        return validPaths;
      } else {
        dev.log('FilePickerService: No files were picked (result is null or empty)');
        return [];
      }
    } catch (e, stackTrace) {
      dev.log('FilePickerService: Error picking multiple files: $e');
      dev.log('FilePickerService: Stack trace: $stackTrace');
      // Only show error if context is still valid
      if (context.mounted) {
        PermissionHandlerUtil.showErrorDialog(
          context,
          'File Picker Error',
          'Could not access file picker. Please try again.',
        );
      }
      return [];
    }
  }
  
  /// Pick a document file (PDF, DOC, DOCX, etc.)
  /// Returns the file path if successful, null otherwise
  Future<String?> pickDocument(
    BuildContext context, {
    List<String>? allowedExtensions,
  }) async {
    dev.log('FilePickerService: Starting pickDocument');
    return pickFile(
      context,
      type: FileType.custom,
      allowedExtensions: allowedExtensions ?? ['pdf', 'doc', 'docx', 'txt', 'rtf'],
    );
  }
  
  /// Pick a media file (image, video, audio)
  /// Returns the file path if successful, null otherwise
  Future<String?> pickMedia(
    BuildContext context, {
    FileType type = FileType.media,
  }) async {
    dev.log('FilePickerService: Starting pickMedia');
    return pickFile(
      context,
      type: type,
    );
  }
  
  /// Show a bottom sheet to select file type and source
  /// Returns the selected file path, or null if canceled or error
  Future<String?> showFileSourceSelectionDialog(
    BuildContext context, {
    String? currentFilePath,
    FileType? defaultFileType,
    List<String>? allowedExtensions,
  }) async {
    dev.log('FilePickerService: Showing file source selection bottom sheet');
    
    final selectedSource = await showModalBottomSheet<String>(
      context: context,
      isDismissible: true,
      enableDrag: true,
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
                  'Select File Type',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Document option
              ListTile(
                leading: Icon(Icons.description_rounded, color: Theme.of(context).colorScheme.primary),
                title: Text('Document', style: GoogleFonts.outfit()),
                subtitle: Text('PDF, DOC, DOCX, TXT', style: GoogleFonts.outfit(fontSize: 12.sp)),
                onTap: () {
                  dev.log('FilePickerService: Document option selected');
                  Navigator.pop(context, 'document');
                },
              ),
              // Media option
              ListTile(
                leading: Icon(Icons.perm_media_rounded, color: Theme.of(context).colorScheme.primary),
                title: Text('Media', style: GoogleFonts.outfit()),
                subtitle: Text('Images, Videos, Audio', style: GoogleFonts.outfit(fontSize: 12.sp)),
                onTap: () {
                  dev.log('FilePickerService: Media option selected');
                  Navigator.pop(context, 'media');
                },
              ),
              // Any file option
              ListTile(
                leading: Icon(Icons.folder_rounded, color: Theme.of(context).colorScheme.primary),
                title: Text('Any File', style: GoogleFonts.outfit()),
                subtitle: Text('All file types', style: GoogleFonts.outfit(fontSize: 12.sp)),
                onTap: () {
                  dev.log('FilePickerService: Any file option selected');
                  Navigator.pop(context, 'any');
                },
              ),
              // Remove file option (only if there's a current file)
              if (currentFilePath != null && currentFilePath.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                  title: Text('Remove File', style: GoogleFonts.outfit(color: Colors.red)),
                  onTap: () {
                    dev.log('FilePickerService: Remove file option selected');
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
      dev.log('FilePickerService: Bottom sheet cancelled');
      return null;
    }
    
    if (selectedSource == 'remove') {
      dev.log('FilePickerService: File removed (empty string result)');
      return ''; // Empty string indicates remove action
    }
    
    String? result;
    try {
      // Wait a bit to ensure bottom sheet is fully closed and app is ready
      await Future.delayed(const Duration(milliseconds: 300));
      
      // Check if context is still valid before opening file picker
      if (!context.mounted) {
        dev.log('FilePickerService: Context is no longer mounted, cannot open file picker');
        return null;
      }
      
      if (selectedSource == 'document') {
        result = await pickDocument(
          context,
          allowedExtensions: allowedExtensions,
        );
        dev.log('FilePickerService: Document result: $result');
      } else if (selectedSource == 'media') {
        result = await pickMedia(
          context,
          type: defaultFileType ?? FileType.media,
        );
        dev.log('FilePickerService: Media result: $result');
      } else if (selectedSource == 'any') {
        result = await pickFile(
          context,
          type: FileType.any,
          allowedExtensions: allowedExtensions,
        );
        dev.log('FilePickerService: Any file result: $result');
      }
    } catch (e, stackTrace) {
      dev.log('FilePickerService: Error in showFileSourceSelectionDialog: $e');
      dev.log('FilePickerService: Stack trace: $stackTrace');
      // If context is still valid, show error
      if (context.mounted) {
        PermissionHandlerUtil.showErrorDialog(
          context,
          'Error',
          'An error occurred while selecting file. Please try again.',
        );
      }
      return null;
    }
    
    dev.log('FilePickerService: Bottom sheet closed, final result: $result');
    return result;
  }
}

