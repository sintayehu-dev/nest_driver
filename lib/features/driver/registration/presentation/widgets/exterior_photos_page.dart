import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/core/services/image_picker_service.dart';
import 'package:nest_driver/core/theme/app_colors.dart';
import 'package:nest_driver/features/driver/registration/presentation/models/driver_registration_form_data.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/driver_registration_progress_indicator.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/driver_registration_button.dart';

class ExteriorPhotosPage extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;
  final int currentPage;
  final int totalPages;
  final String title;
  final DriverRegistrationFormData formData;

  const ExteriorPhotosPage({
    super.key,
    required this.onBackPressed,
    required this.onNextPressed,
    required this.currentPage,
    required this.totalPages,
    required this.title,
    required this.formData,
  });

  @override
  State<ExteriorPhotosPage> createState() => _ExteriorPhotosPageState();
}

class _ExteriorPhotosPageState extends State<ExteriorPhotosPage> {
  final _imagePickerService = ImagePickerService();

  Future<void> _pickImage(BuildContext context, String position) async {
    File? currentPhoto;
    switch (position) {
      case 'front':
        currentPhoto = widget.formData.frontPhoto;
        break;
      case 'back':
        currentPhoto = widget.formData.backPhoto;
        break;
      case 'left':
        currentPhoto = widget.formData.leftPhoto;
        break;
      case 'right':
        currentPhoto = widget.formData.rightPhoto;
        break;
    }

    final imagePath = await _imagePickerService.showImageSourceSelectionDialog(
      context,
      currentImagePath: currentPhoto?.path,
    );

    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        switch (position) {
          case 'front':
            widget.formData.frontPhoto = File(imagePath);
            break;
          case 'back':
            widget.formData.backPhoto = File(imagePath);
            break;
          case 'left':
            widget.formData.leftPhoto = File(imagePath);
            break;
          case 'right':
            widget.formData.rightPhoto = File(imagePath);
            break;
        }
      });
    } else if (imagePath != null && imagePath.isEmpty) {
      // User selected remove photo option (empty string indicates remove)
      setState(() {
        switch (position) {
          case 'front':
            widget.formData.frontPhoto = null;
            break;
          case 'back':
            widget.formData.backPhoto = null;
            break;
          case 'left':
            widget.formData.leftPhoto = null;
            break;
          case 'right':
            widget.formData.rightPhoto = null;
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
            if (widget.title == 'Exterior Photos') ...[
              SizedBox(height: 8.h),
              Text(
                'Take photos of all four sides of your vehicle',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],

            SizedBox(height: 24.h),

            // Info Box
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Make sure to include the tires when taking the photos',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Photo Grid
            Row(
              children: [
                Expanded(
                  child: _buildPhotoCard(
                    context,
                    'Front side of the vehicle',
                    widget.formData.frontPhoto,
                    () => _pickImage(context, 'front'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildPhotoCard(
                    context,
                    'Back side of the vehicle',
                    widget.formData.backPhoto,
                    () => _pickImage(context, 'back'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            Row(
              children: [
                Expanded(
                  child: _buildPhotoCard(
                    context,
                    'Left side of the vehicle',
                    widget.formData.leftPhoto,
                    () => _pickImage(context, 'left'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildPhotoCard(
                    context,
                    'Right side of the vehicle',
                    widget.formData.rightPhoto,
                    () => _pickImage(context, 'right'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Navigation Button
            DriverRegistrationButton(
              onPressed: widget.onNextPressed,
              isLastPage: widget.currentPage == widget.totalPages - 1,
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoCard(
    BuildContext context,
    String label,
    File? photo,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 140.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            child: photo != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Stack(
                      children: [
                        Image.file(
                          photo,
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
                                color: theme.colorScheme.scrim.withOpacity(0.54),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: theme.colorScheme.onPrimary,
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
      ],
    );
  }
}
