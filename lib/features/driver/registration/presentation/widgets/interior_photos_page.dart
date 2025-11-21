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

class InteriorPhotosPage extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final String title;

  const InteriorPhotosPage({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.title,
  });

  Future<void> _pickImage(BuildContext context, String position) async {
    final state = context.read<DriverRegistrationBloc>().state;
    String? currentImagePath;
    
    switch (position) {
      case 'dashboard':
        currentImagePath = state.dashboardPhotoPath;
        break;
      case 'frontSeats':
        currentImagePath = state.frontSeatsPhotoPath;
        break;
      case 'backSeats':
        currentImagePath = state.backSeatsPhotoPath;
        break;
      case 'additional':
        break;
    }

    final imagePickerService = ImagePickerService();
    final imagePath = await imagePickerService.showImageSourceSelectionDialog(
      context,
      currentImagePath: currentImagePath,
    );

    if (imagePath != null) {
      switch (position) {
        case 'dashboard':
          context.read<DriverRegistrationBloc>().add(
                DriverRegistrationEvent.dashboardPhotoChanged(imagePath),
              );
          break;
        case 'frontSeats':
          context.read<DriverRegistrationBloc>().add(
                DriverRegistrationEvent.frontSeatsPhotoChanged(imagePath),
              );
          break;
        case 'backSeats':
          context.read<DriverRegistrationBloc>().add(
                DriverRegistrationEvent.backSeatsPhotoChanged(imagePath),
              );
          break;
        case 'additional':
          final currentPaths = List<String>.from(state.additionalPhotoPaths);
          if (currentPaths.length < 3) {
            currentPaths.add(imagePath);
            context.read<DriverRegistrationBloc>().add(
                  DriverRegistrationEvent.additionalPhotosChanged(currentPaths),
                );
          }
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
                                    const DriverRegistrationEvent.previousPage(),
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
                  'Take photos of the dashboard and all seats',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),

                SizedBox(height: 24.h),

                // Dashboard Photo
                RichText(
                  text: TextSpan(
                    text: 'Dashboard',
                    style: theme.textTheme.bodyMedium?.copyWith(
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
                  onTap: () => _pickImage(context, 'dashboard'),
                  child: Container(
                    width: double.infinity,
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: theme.inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: state.showErrorMessages &&
                                state.firstInvalidField == 'dashboardPhoto'
                            ? theme.colorScheme.error
                            : theme.colorScheme.outlineVariant,
                        width: state.showErrorMessages &&
                                state.firstInvalidField == 'dashboardPhoto'
                            ? 2
                            : 1,
                      ),
                    ),
                    child: state.dashboardPhotoPath != null &&
                            state.dashboardPhotoPath!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Stack(
                              children: [
                                Image.file(
                                  File(state.dashboardPhotoPath!),
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
                if (state.showErrorMessages &&
                    state.firstInvalidField == 'dashboardPhoto')
                  InputValidationMessage(
                    message: 'Please upload dashboard photo',
                  ),

                SizedBox(height: 16.h),

                // Front Seats Photo
                RichText(
                  text: TextSpan(
                    text: 'Front seat(Driver and Passenger)',
                    style: theme.textTheme.bodyMedium?.copyWith(
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
                  onTap: () => _pickImage(context, 'frontSeats'),
                  child: Container(
                    width: double.infinity,
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: theme.inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: state.showErrorMessages &&
                                state.firstInvalidField == 'frontSeatsPhoto'
                            ? theme.colorScheme.error
                            : theme.colorScheme.outlineVariant,
                        width: state.showErrorMessages &&
                                state.firstInvalidField == 'frontSeatsPhoto'
                            ? 2
                            : 1,
                      ),
                    ),
                    child: state.frontSeatsPhotoPath != null &&
                            state.frontSeatsPhotoPath!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Stack(
                              children: [
                                Image.file(
                                  File(state.frontSeatsPhotoPath!),
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
                if (state.showErrorMessages &&
                    state.firstInvalidField == 'frontSeatsPhoto')
                  InputValidationMessage(
                    message: 'Please upload front seats photo',
                  ),

                SizedBox(height: 16.h),

                // Back Seats Photo
                RichText(
                  text: TextSpan(
                    text: 'Back seats',
                    style: theme.textTheme.bodyMedium?.copyWith(
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
                  onTap: () => _pickImage(context, 'backSeats'),
                  child: Container(
                    width: double.infinity,
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: theme.inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: state.showErrorMessages &&
                                state.firstInvalidField == 'backSeatsPhoto'
                            ? theme.colorScheme.error
                            : theme.colorScheme.outlineVariant,
                        width: state.showErrorMessages &&
                                state.firstInvalidField == 'backSeatsPhoto'
                            ? 2
                            : 1,
                      ),
                    ),
                    child: state.backSeatsPhotoPath != null &&
                            state.backSeatsPhotoPath!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Stack(
                              children: [
                                Image.file(
                                  File(state.backSeatsPhotoPath!),
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
                if (state.showErrorMessages &&
                    state.firstInvalidField == 'backSeatsPhoto')
                  InputValidationMessage(
                    message: 'Please upload back seats photo',
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
                            onTap: index < state.additionalPhotoPaths.length
                                ? null
                                : () => _pickImage(context, 'additional'),
                            child: Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                color: theme.inputDecorationTheme.fillColor,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: theme.colorScheme.outlineVariant,
                                  width: 1,
                                ),
                              ),
                              child: index < state.additionalPhotoPaths.length
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Stack(
                                        children: [
                                          Image.file(
                                            File(state.additionalPhotoPaths[index]),
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
                                                color: theme.colorScheme.scrim.withOpacity(0.54),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.edit,
                                                color: theme.colorScheme.onPrimary,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: state.showErrorMessages &&
                                state.firstInvalidField == 'terms'
                            ? Border.all(
                                color: theme.colorScheme.error,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: state.termsAccepted,
                            onChanged: (value) {
                              context.read<DriverRegistrationBloc>().add(
                                    DriverRegistrationEvent.termsAcceptedChanged(value ?? false),
                                  );
                            },
                            activeColor: AppColors.primary,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: GestureDetector(
                                onTap: () {
                                  context.read<DriverRegistrationBloc>().add(
                                        DriverRegistrationEvent.termsAcceptedChanged(
                                          !state.termsAccepted,
                                        ),
                                      );
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
                    ),
                    if (state.showErrorMessages &&
                        state.firstInvalidField == 'terms')
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: InputValidationMessage(
                          message: 'You must agree to the terms and conditions',
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Submit Button (only on last page)
                DriverRegistrationButton(
                  onPressed: () {
                    context.read<DriverRegistrationBloc>().add(
                          const DriverRegistrationEvent.submitForm(),
                        );
                  },
                  isLastPage: true,
                  isLoading: state.isLoading,
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
