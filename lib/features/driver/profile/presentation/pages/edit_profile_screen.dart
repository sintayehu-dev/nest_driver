import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/core/services/image_picker_service.dart';
import 'package:nest_driver/core/theme/app_colors.dart';
import 'package:nest_driver/core/theme/app_theme.dart';
import 'package:nest_driver/core/utils/app_helpers.dart';
import 'package:nest_driver/core/utils/local_storage.dart';
import 'package:nest_driver/features/auth/application/profile_update/bloc/profile_update_bloc.dart';
import 'package:nest_driver/core/utils/input_validation_message.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    super.key,
    this.initialFullName,
    this.initialPhoneNumber,
  });

  final String? initialFullName;
  final String? initialPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileUpdateBloc>(
      create: (_) => getIt<ProfileUpdateBloc>()
        ..add(const ProfileUpdateEvent.loadInitialData()),
      child: EditProfileView(
        initialFullName: initialFullName,
        initialPhoneNumber: initialPhoneNumber,
      ),
    );
  }
}

class EditProfileView extends StatefulWidget {
  const EditProfileView({
    super.key,
    this.initialFullName,
    this.initialPhoneNumber,
  });

  final String? initialFullName;
  final String? initialPhoneNumber;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final ImagePickerService _imagePickerService = getIt<ImagePickerService>();
  final GlobalKey _fullNameKey = GlobalKey();
  final GlobalKey _phoneNumberKey = GlobalKey();

  String? _profileImagePath;
  bool _isInitialLoad = true;

  // Remove validation state - now handled in bloc

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _prefillFields());
    _fullNameFocusNode.addListener(_onFocusChange);
    _phoneNumberFocusNode.addListener(_onFocusChange);
  }

  Future<void> _prefillFields() async {
    await LocalStorage.ensureInitialized();
    final userData = LocalStorage.instance.getUserData();
    if (userData == null) return;

    final extraFullName = widget.initialFullName?.trim();
    final extraPhone = widget.initialPhoneNumber?.trim();

    final fullName = (userData['full_name'] as String?)?.trim() ?? extraFullName;
    final firstName = (userData['first_name'] as String?)?.trim();
    final lastName = (userData['last_name'] as String?)?.trim();
    String? _asString(dynamic v) {
      if (v == null) return null;
      if (v is String) return v.trim().isEmpty ? null : v.trim();
      return v.toString().trim().isEmpty ? null : v.toString().trim();
    }

    final phoneNumber = _asString(userData['phone_number']) ??
        _asString(userData['phoneNumber']) ??
        _asString(userData['phone']) ??
        _asString(userData['mobile']) ??
        _asString(userData['mobile_number']) ??
        _asString(userData['contact']) ??
        _asString(extraPhone);

    final resolvedName = (fullName?.isNotEmpty ?? false)
        ? fullName!
        : [firstName, lastName]
            .where((e) => e != null && e.isNotEmpty)
            .join(' ')
            .trim();

    var prefilled = false;
    if (resolvedName.isNotEmpty) {
      _fullNameController.text = resolvedName;
      prefilled = true;
    }
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      _phoneNumberController.text = phoneNumber;
      prefilled = true;
    }

    if (!mounted) return;
    if (prefilled) {
      final bloc = context.read<ProfileUpdateBloc>();
      if (resolvedName.isNotEmpty) {
        bloc.add(ProfileUpdateEvent.fullNameChanged(resolvedName));
      }
      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        bloc.add(ProfileUpdateEvent.phoneNumberChanged(phoneNumber));
      }
      // Prevent initial empty state from overwriting prefilled values.
      _isInitialLoad = false;
    }
  }

  void _onFocusChange() {
    // Wait for keyboard to appear and then scroll
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted && _scrollController.hasClients) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        final screenHeight = MediaQuery.of(context).size.height;
        final availableHeight =
            screenHeight - keyboardHeight - 100.h; // Reserve space for button

        if (_fullNameFocusNode.hasFocus) {
          // For first field, scroll just enough to show it above keyboard
          _scrollToWidget(_fullNameKey, availableHeight * 0.4);
        } else if (_phoneNumberFocusNode.hasFocus) {
          // For second field, scroll to show it and the button
          _scrollToWidget(_phoneNumberKey, availableHeight * 0.6);
        }
      }
    });
  }

  void _scrollToWidget(GlobalKey key, double offset) {
    final context = key.currentContext;
    if (context != null) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final targetScrollPosition =
          _scrollController.offset + position.dy - offset;

      _scrollController.animateTo(
        targetScrollPosition.clamp(
            0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _updateControllersFromState(ProfileUpdateState state) {
    if (!mounted) return;

    // Use post-frame callback to avoid setState during build
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      // Debug: Print the state values
      final fullNameValue = state.fullName.getOrElse('');
      final phoneNumberValue = state.phoneNumber.getOrElse('');
      print(
          'Updating controllers - FullName: "$fullNameValue", Phone: "$phoneNumberValue"');

      // Update full name field
      if (_fullNameController.text != fullNameValue) {
        _fullNameController.text = fullNameValue;
        print('Updated full name field to: "$fullNameValue"');
      }

      // Update phone number field
      if (_phoneNumberController.text != phoneNumberValue) {
        _phoneNumberController.text = phoneNumberValue;
        print('Updated phone number field to: "$phoneNumberValue"');
      }

      _isInitialLoad = false;
    });
  }

  Future<void> _pickProfileImage() async {
    final imagePath = await _imagePickerService.showImageSourceSelectionDialog(
      context,
      currentImagePath: _profileImagePath,
    );

    if (!mounted) return;

    if (imagePath != null) {
      // Empty string means remove photo
      if (imagePath.isEmpty) {
        setState(() {
          _profileImagePath = null;
        });
      } else {
        // Valid image path
        setState(() {
          _profileImagePath = imagePath;
        });
      }
    }
  }

  void _onFullNameChanged(String value) {
    context.read<ProfileUpdateBloc>().add(
          ProfileUpdateEvent.fullNameChanged(value),
        );
  }

  void _onPhoneNumberChanged(String value) {
    context.read<ProfileUpdateBloc>().add(
          ProfileUpdateEvent.phoneNumberChanged(value),
        );
  }

  void _onSaveChanges() {
    final fullName = _fullNameController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();

    // Submit with current form values - validation handled in bloc
    context.read<ProfileUpdateBloc>().add(
          ProfileUpdateEvent.submitted(
            fullName: fullName,
            phoneNumber: phoneNumber,
          ),
        );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _fullNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSizes = theme.iconSizes;

    return BlocConsumer<ProfileUpdateBloc, ProfileUpdateState>(
      listenWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.isError != current.isError ||
          previous.isSuccess != current.isSuccess ||
          _isInitialLoad ||
          previous.fullName != current.fullName ||
          previous.phoneNumber != current.phoneNumber,
      listener: (context, state) {
        // Update controllers when initial data is loaded (only once)
        if (_isInitialLoad) {
          _updateControllersFromState(state);
        }

        if (!state.isLoading &&
            state.isError &&
            state.errorMessage.isNotEmpty) {
          AppHelpers.showErrorFlash(context, state.errorMessage);
        }
        if (!state.isLoading && state.isSuccess) {
          if (state.successMessage != null &&
              state.successMessage!.isNotEmpty) {
            AppHelpers.showCheckFlash(context, state.successMessage!);
          } else {
            AppHelpers.showCheckFlash(context, 'Profile updated successfully');
          }
          context.pop();
        }
      },
      builder: (context, state) {
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: theme.colorScheme.surface,
            resizeToAvoidBottomInset: true,
            body: Column(
              children: [
                // Scrollable content with top safe area
                Expanded(
                  child: SafeArea(
                    bottom: false, // Don't apply safe area to bottom
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 24.w,
                        bottom: keyboardHeight > 0
                            ? 120.h
                            : 24.h, // Extra space when keyboard is visible
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          _EditProfileHeader(
                            onBackPressed: () => context.pop(),
                            theme: theme,
                          ),
                          SizedBox(height: 24.h),
                          // Profile Picture Section
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60.r,
                                  backgroundColor:
                                      theme.colorScheme.surfaceContainerHighest,
                                  backgroundImage: _profileImagePath != null
                                      ? FileImage(File(_profileImagePath!))
                                      : null,
                                  child: _profileImagePath == null
                                      ? Icon(
                                          Icons.person_outline,
                                          size: iconSizes.xxl * 2,
                                          color: theme
                                              .colorScheme.onSurfaceVariant,
                                        )
                                      : null,
                                ),
                                // Camera Icon Overlay
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: _pickProfileImage,
                                    child: Container(
                                      width: 36.w,
                                      height: 36.h,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme
                                            .surfaceContainerHighest,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: theme.colorScheme.surface,
                                          width: 3,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        size: iconSizes.md,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.h),
                          // Form Section
                          _EditProfileFormSection(
                            fullNameController: _fullNameController,
                            phoneNumberController: _phoneNumberController,
                            fullNameFocusNode: _fullNameFocusNode,
                            phoneNumberFocusNode: _phoneNumberFocusNode,
                            fullNameKey: _fullNameKey,
                            phoneNumberKey: _phoneNumberKey,
                            onFullNameChanged: _onFullNameChanged,
                            onPhoneNumberChanged: _onPhoneNumberChanged,
                            fullNameError: state.activeFullNameError,
                            phoneNumberError: state.activePhoneNumberError,
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
                // Bottom Button at screen edge
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: 24.w,
                    right: 24.w,
                    top: 16.h,
                    bottom: keyboardHeight > 0
                        ? 8.h
                        : MediaQuery.of(context).padding.bottom + 16.h,
                  ),
                  color: theme.colorScheme.surface,
                  child: _EditProfileActions(
                    isLoading: state.isLoading,
                    onSave: _onSaveChanges,
                    theme: theme,
                    hasValidationErrors: state.hasActiveValidationErrors,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EditProfileHeader extends StatelessWidget {
  const _EditProfileHeader({
    required this.onBackPressed,
    required this.theme,
  });

  final VoidCallback onBackPressed;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        AppBackButton(onPressed: onBackPressed),
        SizedBox(height: 24.h),
        Text(
          'Edit Profile',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _EditProfileFormSection extends StatelessWidget {
  const _EditProfileFormSection({
    required this.fullNameController,
    required this.phoneNumberController,
    required this.fullNameFocusNode,
    required this.phoneNumberFocusNode,
    required this.fullNameKey,
    required this.phoneNumberKey,
    required this.onFullNameChanged,
    required this.onPhoneNumberChanged,
    this.fullNameError,
    this.phoneNumberError,
  });

  final TextEditingController fullNameController;
  final TextEditingController phoneNumberController;
  final FocusNode fullNameFocusNode;
  final FocusNode phoneNumberFocusNode;
  final GlobalKey fullNameKey;
  final GlobalKey phoneNumberKey;
  final ValueChanged<String> onFullNameChanged;
  final ValueChanged<String> onPhoneNumberChanged;
  final String? fullNameError;
  final String? phoneNumberError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(
          text: 'Full Name',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        _InputField(
          key: fullNameKey,
          controller: fullNameController,
          focusNode: fullNameFocusNode,
          hintText: 'Enter Full Name',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onChanged: onFullNameChanged,
          onSubmitted: (_) => phoneNumberFocusNode.requestFocus(),
          hasError: fullNameError != null,
        ),
        if (fullNameError != null)
          InputValidationMessage(
            message: fullNameError!,
            margin: EdgeInsets.only(top: 4.h),
          ),
        SizedBox(height: 16.h),
        _FieldLabel(
          text: 'Phone Number',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        _InputField(
          key: phoneNumberKey,
          controller: phoneNumberController,
          focusNode: phoneNumberFocusNode,
          hintText: 'Enter Phone Number',
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          onChanged: onPhoneNumberChanged,
          hasError: phoneNumberError != null,
        ),
        if (phoneNumberError != null)
          InputValidationMessage(
            message: phoneNumberError!,
            margin: EdgeInsets.only(top: 4.h),
          ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({
    required this.text,
    this.style,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: style ??
          theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.hasError = false,
  });

  final TextEditingController controller;
  final String hintText;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputFillColor =
        theme.inputDecorationTheme.fillColor ?? AppColors.inputBackground;

    return Container(
      decoration: BoxDecoration(
        color: inputFillColor,
        borderRadius: BorderRadius.circular(8.r),
        border: hasError
            ? Border.all(
                color: theme.colorScheme.error,
                width: 1.5,
              )
            : null,
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: hintText,
          filled: false,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintStyle: theme.inputDecorationTheme.hintStyle ??
              theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}

class _EditProfileActions extends StatelessWidget {
  const _EditProfileActions({
    required this.isLoading,
    required this.onSave,
    required this.theme,
    this.hasValidationErrors = false,
  });

  final bool isLoading;
  final VoidCallback onSave;
  final ThemeData theme;
  final bool hasValidationErrors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (isLoading || hasValidationErrors) ? null : onSave,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20.r,
                width: 20.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2.r,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.onPrimary,
                  ),
                ),
              )
            : Text(
                'Save Changes',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
      ),
    );
  }
}
