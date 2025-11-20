import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/core/services/image_picker_service.dart';
import 'package:nest_driver/features/driver/registration/presentation/models/driver_registration_form_data.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/driver_registration_progress_indicator.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/driver_registration_button.dart';

class DriverProfilePage extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;
  final int currentPage;
  final int totalPages;
  final String title;
  final DriverRegistrationFormData formData;

  const DriverProfilePage({
    super.key,
    required this.onBackPressed,
    required this.onNextPressed,
    required this.currentPage,
    required this.totalPages,
    required this.title,
    required this.formData,
  });

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _finNumberController;
  final _imagePickerService = ImagePickerService();

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.formData.fullName);
    _emailController = TextEditingController(text: widget.formData.email);
    _finNumberController = TextEditingController(text: widget.formData.finNumber);
    
    // Add listeners to update formData
    _fullNameController.addListener(() {
      widget.formData.fullName = _fullNameController.text;
    });
    _emailController.addListener(() {
      widget.formData.email = _emailController.text;
    });
    _finNumberController.addListener(() {
      widget.formData.finNumber = _finNumberController.text.isEmpty ? null : _finNumberController.text;
    });
  }

  Future<void> _pickImage(BuildContext context, bool isProfile) async {
    final imagePath = await _imagePickerService.showImageSourceSelectionDialog(
      context,
      currentImagePath: isProfile 
          ? (widget.formData.profileImage?.path) 
          : (widget.formData.licenseImage?.path),
    );

    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        if (isProfile) {
          widget.formData.profileImage = File(imagePath);
        } else {
          widget.formData.licenseImage = File(imagePath);
        }
      });
    } else if (imagePath != null && imagePath.isEmpty) {
      // User selected remove photo option (empty string indicates remove)
      setState(() {
        if (isProfile) {
          widget.formData.profileImage = null;
        } else {
          widget.formData.licenseImage = null;
        }
      });
    }
    // If imagePath is null, user cancelled - do nothing
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _finNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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

              SizedBox(height: 32.h),

              // Profile Photo
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 140.w,
                          height: 140.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.surfaceContainerHighest,
                            image: widget.formData.profileImage != null
                                ? DecorationImage(
                                    image: FileImage(widget.formData.profileImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: widget.formData.profileImage == null
                              ? Center(
                                  child: Icon(
                                    Icons.person_outline,
                                    size: 70.sp,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 4.h,
                          right: 4.w,
                          child: GestureDetector(
                            onTap: () => _pickImage(context, true),
                            child: Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 20.sp,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Full Name
                  RichText(
                    text: TextSpan(
                      text: 'Full Name',
                      style: theme.textTheme.bodyMedium?.copyWith(
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
                  TextFormField(
                    controller: _fullNameController,
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Enter Full Name',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20.h),

                  // Email Address
                  Text(
                    'Email Address',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Enter Email Address',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Upload License
                  Text(
                    'Upload photo of your license',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () => _pickImage(context, false),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 48.h),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: widget.formData.licenseImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.file(
                                widget.formData.licenseImage!,
                                height: 120.h,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.insert_drive_file_outlined,
                                  size: 32.sp,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  'Click to upload your driver\'s license photo',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'File should be JPG, PNG, or PDF',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                Text(
                                  'Max. File Size: 10MB',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // FIN Number
                  RichText(
                    text: TextSpan(
                      text: 'FIN Number',
                      style: theme.textTheme.bodyMedium?.copyWith(
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
                  TextFormField(
                    controller: _finNumberController,
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Fayda Identification Number',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your FIN number';
                      }
                      return null;
                    },
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
      ),
    );
  }
}
