import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/core/services/image_picker_service.dart';
import 'package:nest_driver/core/theme/app_colors.dart';
import 'package:nest_driver/core/utils/input_validation_message.dart';
import 'package:nest_driver/features/driver/registration/application/bloc/driver_registration_bloc.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/driver_registration_progress_indicator.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/driver_registration_button.dart';

class ExteriorPhotosPage extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final String title;

  const ExteriorPhotosPage({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.title,
  });

  Future<void> _pickImage(BuildContext context, String position) async {
    final state = context.read<DriverRegistrationBloc>().state;
    String? currentImagePath;

    switch (position) {
      case 'front':
        currentImagePath = state.frontPhotoPath;
        break;
      case 'back':
        currentImagePath = state.backPhotoPath;
        break;
      case 'left':
        currentImagePath = state.leftPhotoPath;
        break;
      case 'right':
        currentImagePath = state.rightPhotoPath;
        break;
    }

    final imagePickerService = ImagePickerService();
    final imagePath = await imagePickerService.showImageSourceSelectionDialog(
      context,
      currentImagePath: currentImagePath,
    );

    if (imagePath != null) {
      switch (position) {
        case 'front':
          context.read<DriverRegistrationBloc>().add(
                DriverRegistrationEvent.frontPhotoChanged(imagePath),
              );
          break;
        case 'back':
          context.read<DriverRegistrationBloc>().add(
                DriverRegistrationEvent.backPhotoChanged(imagePath),
              );
          break;
        case 'left':
          context.read<DriverRegistrationBloc>().add(
                DriverRegistrationEvent.leftPhotoChanged(imagePath),
              );
          break;
        case 'right':
          context.read<DriverRegistrationBloc>().add(
                DriverRegistrationEvent.rightPhotoChanged(imagePath),
              );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<DriverRegistrationBloc, DriverRegistrationState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AppBackButton(
                            onPressed: () {
                              context.read<DriverRegistrationBloc>().add(
                                    const DriverRegistrationEvent
                                        .previousPage(),
                                  );
                            },
                          ),
                          const Spacer(),
                          Text(
                            '${currentPage + 1}/${totalPages}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      DriverRegistrationProgressIndicator(
                        currentPage: currentPage,
                        totalPages: totalPages,
                      ),
                    ],
                  ),
                ),

                // Title
                Padding(
                  padding: EdgeInsets.only(top: 32.h),
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),
                Text(
                  'Take photos of all four sides of your vehicle',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),

                SizedBox(height: 24.h),

                // Info Box
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.infoBoxBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.infoBoxBorder,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Make sure to include the tires when taking the photos',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.infoBoxForeground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                // Photo Grid
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildPhotoCard(
                            context,
                            'Front side of the vehicle',
                            state.frontPhotoPath,
                            () => _pickImage(context, 'front'),
                            'frontPhoto',
                            state,
                            showError: false, // Don't show error inside card
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildPhotoCard(
                            context,
                            'Back side of the vehicle',
                            state.backPhotoPath,
                            () => _pickImage(context, 'back'),
                            'backPhoto',
                            state,
                            showError: false, // Don't show error inside card
                          ),
                        ),
                      ],
                    ),
                    // Show validation message below the row for full width
                    if (state.showErrorMessages &&
                        (state.firstInvalidField == 'frontPhoto' ||
                            state.firstInvalidField == 'backPhoto'))
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: InputValidationMessage(
                          message: state.firstInvalidField == 'frontPhoto'
                              ? 'Please upload Front side of the vehicle photo'
                              : 'Please upload Back side of the vehicle photo',
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 16.h),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildPhotoCard(
                            context,
                            'Left side of the vehicle',
                            state.leftPhotoPath,
                            () => _pickImage(context, 'left'),
                            'leftPhoto',
                            state,
                            showError: false, // Don't show error inside card
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildPhotoCard(
                            context,
                            'Right side of the vehicle',
                            state.rightPhotoPath,
                            () => _pickImage(context, 'right'),
                            'rightPhoto',
                            state,
                            showError: false, // Don't show error inside card
                          ),
                        ),
                      ],
                    ),
                    // Show validation message below the row for full width
                    if (state.showErrorMessages &&
                        (state.firstInvalidField == 'leftPhoto' ||
                            state.firstInvalidField == 'rightPhoto'))
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: InputValidationMessage(
                          message: state.firstInvalidField == 'leftPhoto'
                              ? 'Please upload Left side of the vehicle photo'
                              : 'Please upload Right side of the vehicle photo',
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Next Button
                DriverRegistrationButton(
                  onPressed: () {
                    context.read<DriverRegistrationBloc>().add(
                          const DriverRegistrationEvent.nextPage(),
                        );
                  },
                  isLastPage: false,
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotoCard(
    BuildContext context,
    String label,
    String? imagePath,
    VoidCallback onTap,
    String fieldName,
    DriverRegistrationState state, {
    bool showError = true, // Default to true for backward compatibility
  }) {
    final theme = Theme.of(context);
    final hasError = state.showErrorMessages &&
        state.firstInvalidField == fieldName;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 140.h,
            decoration: BoxDecoration(
              color: theme.inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: hasError
                    ? theme.colorScheme.error
                    : theme.colorScheme.outlineVariant,
                width: hasError ? 2 : 1,
              ),
            ),
            child: imagePath != null && imagePath.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Stack(
                      children: [
                        Image.file(
                          File(imagePath),
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
        // Only show error inside card if showError is true
        if (hasError && showError)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: InputValidationMessage(
              message: 'Please upload $label photo',
            ),
          ),
      ],
    );
  }
}
