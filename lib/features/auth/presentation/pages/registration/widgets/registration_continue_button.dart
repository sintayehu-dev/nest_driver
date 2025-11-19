import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
import 'package:nest_driver/core/theme/app_colors.dart';
import 'package:nest_driver/features/auth/application/otplogin/bloc/otp_login_bloc.dart';

/// Next button widget for registration screen (wired to OtpLoginBloc)
class RegistrationContinueButton extends StatelessWidget {
  final TextEditingController phoneController;
  final Country selectedCountry;

  const RegistrationContinueButton({
    super.key,
    required this.phoneController,
    required this.selectedCountry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<OtpLoginBloc, OtpLoginState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: state.isLoading
                ? null
                : () {
                    // Ensure latest phone is set in bloc with dial code
                    context.read<OtpLoginBloc>().add(
                          OtpLoginEvent.phoneChanged(
                            '+${selectedCountry.phoneCode}${phoneController.text.trim()}',
                          ),
                        );
                    // Submit OTP request
                    context
                        .read<OtpLoginBloc>()
                        .add(const OtpLoginEvent.submit());
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.r),
              ),
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: state.isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.onPrimary,
                      ),
                    ),
                  )
                : Text(
                    ' Next',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onPrimary,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
