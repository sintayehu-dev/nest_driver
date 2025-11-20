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

class MirrorsWipersPage extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;
  final int currentPage;
  final int totalPages;
  final String title;
  final DriverRegistrationFormData formData;

  const MirrorsWipersPage({
    super.key,
    required this.onBackPressed,
    required this.onNextPressed,
    required this.currentPage,
    required this.totalPages,
    required this.title,
    required this.formData,
  });

  @override
  State<MirrorsWipersPage> createState() => _MirrorsWipersPageState();
}

class _MirrorsWipersPageState extends State<MirrorsWipersPage> {
  final _imagePickerService = ImagePickerService();

  Future<void> _pickImage(BuildContext context, String position) async {
    File? currentPhoto;
    switch (position) {
      case 'frontWiper':
        currentPhoto = widget.formData.frontWiperPhoto;
        break;
      case 'rearWiper':
        currentPhoto = widget.formData.rearWiperPhoto;
        break;
      case 'sideMirror1':
        currentPhoto = widget.formData.sideMirror1Photo;
        break;
      case 'sideMirror2':
        currentPhoto = widget.formData.sideMirror2Photo;
        break;
      case 'rearViewMirror':
        currentPhoto = widget.formData.rearViewMirrorPhoto;
        break;
    }

    final imagePath = await _imagePickerService.showImageSourceSelectionDialog(
      context,
      currentImagePath: currentPhoto?.path,
    );

    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        switch (position) {
          case 'frontWiper':
            widget.formData.frontWiperPhoto = File(imagePath);
            break;
          case 'rearWiper':
            widget.formData.rearWiperPhoto = File(imagePath);
            break;
          case 'sideMirror1':
            widget.formData.sideMirror1Photo = File(imagePath);
            break;
          case 'sideMirror2':
            widget.formData.sideMirror2Photo = File(imagePath);
            break;
          case 'rearViewMirror':
            widget.formData.rearViewMirrorPhoto = File(imagePath);
            break;
        }
      });
    } else if (imagePath != null && imagePath.isEmpty) {
      // User selected remove photo option (empty string indicates remove)
      setState(() {
        switch (position) {
          case 'frontWiper':
            widget.formData.frontWiperPhoto = null;
            break;
          case 'rearWiper':
            widget.formData.rearWiperPhoto = null;
            break;
          case 'sideMirror1':
            widget.formData.sideMirror1Photo = null;
            break;
          case 'sideMirror2':
            widget.formData.sideMirror2Photo = null;
            break;
          case 'rearViewMirror':
            widget.formData.rearViewMirrorPhoto = null;
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
            if (widget.title == 'Mirrors & Wipers') ...[
              SizedBox(height: 8.h),
              Text(
                'Capture photos of mirrors and windshield wipers',
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
              child: Text(
                'Ensure all photos are clear, well-lit, and show the required parts of your vehicle. Photos will be reviewed for verification before you can start driving.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Wipers Row
            Row(
              children: [
                Expanded(
                  child: _buildPhotoCard(
                    context,
                    'Front Wiper',
                    widget.formData.frontWiperPhoto,
                    () => _pickImage(context, 'frontWiper'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildPhotoCard(
                    context,
                    'Rear wiper',
                    widget.formData.rearWiperPhoto,
                    () => _pickImage(context, 'rearWiper'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Side Mirrors Row
            Row(
              children: [
                Expanded(
                  child: _buildPhotoCard(
                    context,
                    'Side Mirror 1',
                    widget.formData.sideMirror1Photo,
                    () => _pickImage(context, 'sideMirror1'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildPhotoCard(
                    context,
                    'Side Mirror 2',
                    widget.formData.sideMirror2Photo,
                    () => _pickImage(context, 'sideMirror2'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Rear View Mirror
            Text(
              'Rear view mirror',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => _pickImage(context, 'rearViewMirror'),
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
                child: widget.formData.rearViewMirrorPhoto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Stack(
                          children: [
                            Image.file(
                              widget.formData.rearViewMirrorPhoto!,
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
