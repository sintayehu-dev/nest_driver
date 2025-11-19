import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:nest_driver/core/theme/app_colors.dart';

/// OTP input field widget with 6 square boxes
class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const OtpInputField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PinCodeTextField(
      appContext: context,
      length: 6,
      controller: controller,
      animationType: AnimationType.none,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8.r),
        fieldHeight: 56.h,
        fieldWidth: 48.w,
        activeFillColor: AppColors.white,
        inactiveFillColor: AppColors.white,
        selectedFillColor: AppColors.white,
        activeColor: AppColors.divider,
        inactiveColor: AppColors.divider,
        selectedColor: AppColors.primary,
        borderWidth: 1,
      ),
      cursorColor: theme.colorScheme.primary,
      animationDuration: const Duration(milliseconds: 0),
      enableActiveFill: true,
      keyboardType: TextInputType.none,
      readOnly: true,
      enablePinAutofill: false,
      textStyle: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      onChanged: onChanged ?? (value) {},
    );
  }
}
