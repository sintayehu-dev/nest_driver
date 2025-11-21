import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/core/services/image_picker_service.dart';
import 'package:nest_driver/core/services/file_picker_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nest_driver/core/utils/input_validation_message.dart';
import 'package:nest_driver/features/driver/registration/application/bloc/driver_registration_bloc.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/driver_registration_progress_indicator.dart';
import 'package:nest_driver/features/driver/registration/presentation/widgets/driver_registration_button.dart';

class DriverProfilePage extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final String title;

  const DriverProfilePage({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.title,
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
  final _filePickerService = FilePickerService();

  @override
  void initState() {
    super.initState();
    final state = context.read<DriverRegistrationBloc>().state;
    _fullNameController = TextEditingController(
      text: state.fullName.getOrElse(''),
    );
    _emailController = TextEditingController(
      text: state.email.getOrElse(''),
    );
    _finNumberController = TextEditingController(
      text: state.finNumber.getOrElse(''),
    );

    _fullNameController.addListener(() {
      context.read<DriverRegistrationBloc>().add(
            DriverRegistrationEvent.fullNameChanged(_fullNameController.text),
          );
    });
    _emailController.addListener(() {
      context.read<DriverRegistrationBloc>().add(
            DriverRegistrationEvent.emailChanged(_emailController.text),
          );
    });
    _finNumberController.addListener(() {
      context.read<DriverRegistrationBloc>().add(
            DriverRegistrationEvent.finNumberChanged(_finNumberController.text),
          );
    });
  }

  Future<void> _pickImage(BuildContext context, bool isProfile) async {
    final state = context.read<DriverRegistrationBloc>().state;
    final currentImagePath = isProfile
        ? state.profileImagePath
        : state.licenseImagePath;

    final imagePath = await _imagePickerService.showImageSourceSelectionDialog(
      context,
      currentImagePath: currentImagePath,
    );

    if (imagePath != null) {
        if (isProfile) {
        context.read<DriverRegistrationBloc>().add(
              DriverRegistrationEvent.profileImageChanged(imagePath),
            );
        } else {
        context.read<DriverRegistrationBloc>().add(
              DriverRegistrationEvent.licenseImageChanged(imagePath),
            );
    }
    }
  }

  /// Show bottom sheet to pick license as image or document
  Future<void> _pickLicense(BuildContext context) async {
    final state = context.read<DriverRegistrationBloc>().state;
    final currentLicensePath = state.licenseImagePath;

    // Show bottom sheet with options: Pick Image or Pick Document
    final selectedOption = await showModalBottomSheet<String>(
      context: context,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        final theme = Theme.of(context);
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
                  'Select License Source',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Pick Image option
              ListTile(
                leading: Icon(
                  Icons.image_rounded,
                  color: theme.colorScheme.primary,
                ),
                title: Text(
                  'Pick Image',
                  style: GoogleFonts.outfit(),
                ),
                subtitle: Text(
                  'Camera or Gallery',
                  style: GoogleFonts.outfit(fontSize: 12.sp),
                ),
                onTap: () {
                  Navigator.pop(context, 'image');
                },
              ),
              // Pick Document option
              ListTile(
                leading: Icon(
                  Icons.description_rounded,
                  color: theme.colorScheme.primary,
                ),
                title: Text(
                  'Pick Document',
                  style: GoogleFonts.outfit(),
                ),
                subtitle: Text(
                  'PDF, DOC, DOCX',
                  style: GoogleFonts.outfit(fontSize: 12.sp),
                ),
                onTap: () {
                  Navigator.pop(context, 'document');
                },
              ),
              // Remove option (only if there's a current license)
              if (currentLicensePath.isNotEmpty)
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Remove License',
                    style: GoogleFonts.outfit(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.pop(context, 'remove');
                  },
                ),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );

    if (selectedOption == null || !context.mounted) {
      return;
    }

    if (selectedOption == 'remove') {
      // Remove license
      context.read<DriverRegistrationBloc>().add(
            const DriverRegistrationEvent.licenseImageChanged(''),
          );
      return;
    }

    String? filePath;

    if (selectedOption == 'image') {
      // Option A: Pick Image
      // Request Camera/Gallery permission and open Image Picker
      filePath = await _imagePickerService.showImageSourceSelectionDialog(
        context,
        currentImagePath: currentLicensePath.isNotEmpty ? currentLicensePath : null,
      );
    } else if (selectedOption == 'document') {
      // Option B: Pick Document
      // Request Storage permission and open File Picker
      filePath = await _filePickerService.pickDocument(
        context,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
    }

    // Update BLoC state with selected file
    if (filePath != null && context.mounted) {
      context.read<DriverRegistrationBloc>().add(
            DriverRegistrationEvent.licenseImageChanged(filePath),
          );
    }
  }

  /// Check if file is an image based on extension
  bool _isImageFile(String filePath) {
    final extension = filePath.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  /// Get file name from path
  String _getFileName(String filePath) {
    return filePath.split('/').last;
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

    return BlocBuilder<DriverRegistrationBloc, DriverRegistrationState>(
      builder: (context, state) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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
                              onPressed: widget.currentPage == 0
                                  ? () => context.pop()
                                  : () {
                                      context.read<DriverRegistrationBloc>().add(
                                            const DriverRegistrationEvent.previousPage(),
                                          );
                                    },
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
                  RichText(
                    text: TextSpan(
                      text: 'Profile Photo',
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
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 140.w,
                          height: 140.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.inputDecorationTheme.fillColor,
                            image: state.profileImagePath.isNotEmpty
                                ? DecorationImage(
                                    image: FileImage(File(state.profileImagePath)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: state.profileImagePath.isEmpty
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
                                state.profileImagePath.isNotEmpty
                                    ? Icons.camera_alt_outlined
                                    : Icons.camera_alt,
                                size: 20.sp,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.showErrorMessages &&
                      state.firstInvalidField == 'profileImage')
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: InputValidationMessage(
                        message: 'Please upload your profile picture',
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
                      fillColor: theme.inputDecorationTheme.fillColor,
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
                  if (state.showErrorMessages &&
                      state.firstInvalidField == 'fullName')
                    state.fullName.value.fold(
                      (failure) => InputValidationMessage(
                        message: failure.failedValue.toString(),
                      ),
                      (_) => const SizedBox.shrink(),
                  ),

                  SizedBox(height: 20.h),

                  // Email Address
                  RichText(
                    text: TextSpan(
                      text: 'Email Address',
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
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Enter Email Address',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      filled: true,
                      fillColor: theme.inputDecorationTheme.fillColor,
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
                  if (state.showErrorMessages &&
                      state.firstInvalidField == 'email')
                    state.email.value.fold(
                      (failure) => InputValidationMessage(
                        message: failure.failedValue.toString(),
                      ),
                      (_) => const SizedBox.shrink(),
                  ),

                  SizedBox(height: 20.h),

                  // Upload License
                  RichText(
                    text: TextSpan(
                      text: 'Upload photo of your license',
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
                  GestureDetector(
                    onTap: () => _pickLicense(context),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 48.h),
                      decoration: BoxDecoration(
                        color: theme.inputDecorationTheme.fillColor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: state.showErrorMessages &&
                                  state.firstInvalidField == 'licenseImage'
                              ? theme.colorScheme.error
                              : Colors.transparent,
                          width: state.showErrorMessages &&
                                  state.firstInvalidField == 'licenseImage'
                              ? 2
                              : 0,
                        ),
                      ),
                      child: state.licenseImagePath.isNotEmpty
                          ? Stack(
                              children: [
                                // Check if file is an image or document
                                _isImageFile(state.licenseImagePath)
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8.r),
                                        child: Image.file(
                                          File(state.licenseImagePath),
                                          height: 120.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        height: 120.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.surfaceVariant,
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.description_rounded,
                                              size: 48.sp,
                                              color: theme.colorScheme.primary,
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              _getFileName(state.licenseImagePath),
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                color: theme.colorScheme.onSurfaceVariant,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
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
                                  'Click to upload your driver\'s license',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Image (JPG, PNG) or Document (PDF, DOC, DOCX)',
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
                  if (state.showErrorMessages &&
                      state.firstInvalidField == 'licenseImage')
                    InputValidationMessage(
                      message: 'Please upload your driver\'s license photo',
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
                      fillColor: theme.inputDecorationTheme.fillColor,
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
                  if (state.showErrorMessages &&
                      state.firstInvalidField == 'finNumber')
                    state.finNumber.value.fold(
                      (failure) => InputValidationMessage(
                        message: failure.failedValue.toString(),
                      ),
                      (_) => const SizedBox.shrink(),
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
      ),
        );
      },
    );
  }
}
