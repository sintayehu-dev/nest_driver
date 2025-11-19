import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/core/services/image_picker_service.dart';
import 'package:nest_driver/core/theme/app_colors.dart';
import 'package:nest_driver/features/driver/registration/presentation/pages/widgets/driver_registration_progress_indicator.dart';

class InteriorPhotosPage extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;
  final int currentPage;
  final int totalPages;
  final String title;

  const InteriorPhotosPage({
    super.key,
    required this.onBackPressed,
    required this.onNextPressed,
    required this.currentPage,
    required this.totalPages,
    required this.title,
  });

  @override
  State<InteriorPhotosPage> createState() => _InteriorPhotosPageState();
}

class _InteriorPhotosPageState extends State<InteriorPhotosPage> {
  final _imagePickerService = ImagePickerService();
  File? _dashboardPhoto;
  File? _frontSeatsPhoto;
  File? _backSeatsPhoto;
  final List<File> _additionalPhotos = [];
  bool _agreedToTerms = false;

  Future<void> _pickImage(BuildContext context, String position) async {
    File? currentPhoto;
    switch (position) {
      case 'dashboard':
        currentPhoto = _dashboardPhoto;
        break;
      case 'frontSeats':
        currentPhoto = _frontSeatsPhoto;
        break;
      case 'backSeats':
        currentPhoto = _backSeatsPhoto;
        break;
      case 'additional':
        // For additional photos, we don't have a current photo to check
        break;
    }

    final imagePath = await _imagePickerService.showImageSourceSelectionDialog(
      context,
      currentImagePath: currentPhoto?.path,
    );

    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        switch (position) {
          case 'dashboard':
            _dashboardPhoto = File(imagePath);
            break;
          case 'frontSeats':
            _frontSeatsPhoto = File(imagePath);
            break;
          case 'backSeats':
            _backSeatsPhoto = File(imagePath);
            break;
          case 'additional':
            if (_additionalPhotos.length < 3) {
              _additionalPhotos.add(File(imagePath));
            }
            break;
        }
      });
    } else if (imagePath != null && imagePath.isEmpty && currentPhoto != null) {
      // User selected remove photo option (empty string indicates remove)
      setState(() {
        switch (position) {
          case 'dashboard':
            _dashboardPhoto = null;
            break;
          case 'frontSeats':
            _frontSeatsPhoto = null;
            break;
          case 'backSeats':
            _backSeatsPhoto = null;
            break;
        }
      });
    }
    // If imagePath is null, user cancelled - do nothing
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button and progress
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppBackButton(
                        onPressed: widget.onBackPressed ?? () => context.pop(),
                      ),
                      const Spacer(),
                      Text(
                        '${widget.currentPage + 1}/${widget.totalPages}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Progress indicator
                  DriverRegistrationProgressIndicator(
                    currentPage: widget.currentPage,
                    totalPages: widget.totalPages,
                  ),
                ],
              ),
            ),

            // Title
            Padding(
              padding: EdgeInsets.only(top: 32.h),
              child: Text(
                widget.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),

            // Description
            if (widget.title == 'Interior Photos') ...[
              SizedBox(height: 8.h),
              Text(
                'Take photos of the dashboard and all seats',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],

            SizedBox(height: 24.h),

            // Dashboard Photo
            Text(
              'Dashboard',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => _pickImage(context, 'dashboard'),
              child: Container(
                width: double.infinity,
                height: 140.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
                child: _dashboardPhoto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Stack(
                          children: [
                            Image.file(
                              _dashboardPhoto!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 8.h,
                              right: 8.w,
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 32.sp,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
              ),
            ),

            SizedBox(height: 16.h),

            // Front Seats Photo
            Text(
              'Front seat(Driver and Passenger)',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => _pickImage(context, 'frontSeats'),
              child: Container(
                width: double.infinity,
                height: 140.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
                child: _frontSeatsPhoto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Stack(
                          children: [
                            Image.file(
                              _frontSeatsPhoto!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 8.h,
                              right: 8.w,
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 32.sp,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
              ),
            ),

            SizedBox(height: 16.h),

            // Back Seats Photo
            Text(
              'Back seats',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => _pickImage(context, 'backSeats'),
              child: Container(
                width: double.infinity,
                height: 140.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
                child: _backSeatsPhoto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Stack(
                          children: [
                            Image.file(
                              _backSeatsPhoto!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 8.h,
                              right: 8.w,
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 32.sp,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
              ),
            ),

            SizedBox(height: 16.h),

            // Additional Photos
            Text(
              'Add more photos if you\'ve more seats like a minivan',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 8.h),

            Row(
              children: [
                ...List.generate(
                  3,
                  (index) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index < 2 ? 8.w : 0),
                      child: GestureDetector(
                        onTap: index < _additionalPhotos.length
                            ? null
                            : () => _pickImage(context, 'additional'),
                        child: Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: theme.colorScheme.outlineVariant,
                              width: 1,
                            ),
                          ),
                          child: index < _additionalPhotos.length
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        _additionalPhotos[index],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                      Positioned(
                                        top: 4.h,
                                        right: 4.w,
                                        child: Container(
                                          padding: EdgeInsets.all(4.w),
                                          decoration: BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 24.sp,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Terms and Conditions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value ?? false;
                    });
                  },
                  activeColor: AppColors.primary,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _agreedToTerms = !_agreedToTerms;
                        });
                      },
                      child: Text(
                        'I agree to the Driver Terms & Conditions.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Navigation Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onNextPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  widget.currentPage == widget.totalPages - 1 ? 'Submit' : 'Next',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
