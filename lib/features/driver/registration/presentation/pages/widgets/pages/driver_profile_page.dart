import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/features/driver/registration/presentation/pages/widgets/driver_registration_progress_indicator.dart';

class DriverProfilePage extends StatefulWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onNextPressed;
  final int currentPage;
  final int totalPages;
  final String title;

  const DriverProfilePage({
    super.key,
    required this.onBackPressed,
    required this.onNextPressed,
    required this.currentPage,
    required this.totalPages,
    required this.title,
  });

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _finNumberController = TextEditingController();
  File? _profileImage;
  File? _licenseImage;

  Future<void> _pickImage(ImageSource source, bool isProfile) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        if (isProfile) {
          _profileImage = File(pickedFile.path);
        } else {
          _licenseImage = File(pickedFile.path);
        }
      });
    }
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
                            color: const Color(0xFFF5F5F5),
                            image: _profileImage != null
                                ? DecorationImage(
                                    image: FileImage(_profileImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _profileImage == null
                              ? Center(
                                  child: Icon(
                                    Icons.person_outline,
                                    size: 70.sp,
                                    color: const Color(0xFFE0E0E0),
                                  ),
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 4.h,
                          right: 4.w,
                          child: GestureDetector(
                            onTap: () => _pickImage(ImageSource.gallery, true),
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
                                color: const Color(0xFF9E9E9E),
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
                        color: const Color(0xFF212121),
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _fullNameController,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xFF212121),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter Full Name',
                      hintStyle: TextStyle(
                        color: const Color(0xFFBDBDBD),
                        fontSize: 14.sp,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
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
                      color: const Color(0xFF212121),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xFF212121),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter Email Address',
                      hintStyle: TextStyle(
                        color: const Color(0xFFBDBDBD),
                        fontSize: 14.sp,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
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
                      color: const Color(0xFF212121),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery, false),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 48.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: _licenseImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.file(
                                _licenseImage!,
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
                                  color: const Color(0xFFBDBDBD),
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  'Click to upload your driver\'s license photo',
                                  style: TextStyle(
                                    color: const Color(0xFF757575),
                                    fontSize: 13.sp,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'File should be JPG, PNG, or PDF',
                                  style: TextStyle(
                                    color: const Color(0xFF9E9E9E),
                                    fontSize: 11.sp,
                                  ),
                                ),
                                Text(
                                  'Max. File Size: 10MB',
                                  style: TextStyle(
                                    color: const Color(0xFF9E9E9E),
                                    fontSize: 11.sp,
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
                        color: const Color(0xFF212121),
                        fontSize: 14.sp,
                      ),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _finNumberController,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xFF212121),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Fayda Identification Number',
                      hintStyle: TextStyle(
                        color: const Color(0xFFBDBDBD),
                        fontSize: 14.sp,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
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
      ),
    );
  }
}
