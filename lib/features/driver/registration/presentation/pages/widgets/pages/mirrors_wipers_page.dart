import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/core/theme/app_colors.dart';
import 'package:nest_driver/features/driver/registration/presentation/pages/widgets/driver_registration_progress_indicator.dart';

class MirrorsWipersPage extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;
  final int currentPage;
  final int totalPages;
  final String title;

  const MirrorsWipersPage({
    super.key,
    required this.onBackPressed,
    required this.onNextPressed,
    required this.currentPage,
    required this.totalPages,
    required this.title,
  });

  @override
  State<MirrorsWipersPage> createState() => _MirrorsWipersPageState();
}

class _MirrorsWipersPageState extends State<MirrorsWipersPage> {
  File? _frontWiperPhoto;
  File? _rearWiperPhoto;
  File? _sideMirror1Photo;
  File? _sideMirror2Photo;
  File? _rearViewMirrorPhoto;

  Future<void> _pickImage(String position) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        switch (position) {
          case 'frontWiper':
            _frontWiperPhoto = File(pickedFile.path);
            break;
          case 'rearWiper':
            _rearWiperPhoto = File(pickedFile.path);
            break;
          case 'sideMirror1':
            _sideMirror1Photo = File(pickedFile.path);
            break;
          case 'sideMirror2':
            _sideMirror2Photo = File(pickedFile.path);
            break;
          case 'rearViewMirror':
            _rearViewMirrorPhoto = File(pickedFile.path);
            break;
        }
      });
    }
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
                    _frontWiperPhoto,
                    () => _pickImage('frontWiper'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildPhotoCard(
                    context,
                    'Rear wiper',
                    _rearWiperPhoto,
                    () => _pickImage('rearWiper'),
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
                    _sideMirror1Photo,
                    () => _pickImage('sideMirror1'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildPhotoCard(
                    context,
                    'Side Mirror 2',
                    _sideMirror2Photo,
                    () => _pickImage('sideMirror2'),
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
              onTap: () => _pickImage('rearViewMirror'),
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
                child: _rearViewMirrorPhoto != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Stack(
                          children: [
                            Image.file(
                              _rearViewMirrorPhoto!,
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

            SizedBox(height: 24.h),

            // Navigation Buttons
            Row(
              children: [
                if (widget.currentPage > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onBackPressed,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: theme.colorScheme.surfaceContainerHighest,
                        foregroundColor: theme.colorScheme.onSurface,
                        side: BorderSide(
                          color: theme.colorScheme.outlineVariant,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text(
                        'Previous',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                if (widget.currentPage > 0) SizedBox(width: 16.w),
                Expanded(
                  flex: widget.currentPage > 0 ? 1 : 1,
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
              ],
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
      ],
    );
  }
}
