import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:country_picker/country_picker.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/core/presentation/widgets/app_helpers.dart';
import 'package:nest_driver/core/presentation/widgets/custom_numeric_keyboard.dart';
import 'package:nest_driver/features/auth/application/otplogin/bloc/otp_login_bloc.dart';
import 'widgets/registration_welcome_message.dart';
import 'widgets/registration_form_fields.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpLoginBloc>(
      create: (_) => getIt<OtpLoginBloc>(),
      child: const RegistrationView(),
    );
  }
}

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final TextEditingController _phoneController = TextEditingController();
  Country _selectedCountry = Country.parse('ET');

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onCountryChanged(Country country) {
    setState(() {
      _selectedCountry = country;
    });
    context.read<OtpLoginBloc>().add(
          OtpLoginEvent.phoneChanged(
            '+${_selectedCountry.phoneCode}${_phoneController.text.trim()}',
          ),
        );
  }

  void _handleDigitTap(String digit) {
    _phoneController.text += digit;
    context.read<OtpLoginBloc>().add(
          OtpLoginEvent.phoneChanged(
            '+${_selectedCountry.phoneCode}${_phoneController.text.trim()}',
          ),
        );
  }

  void _handleBackspace() {
    if (_phoneController.text.isNotEmpty) {
      _phoneController.text =
          _phoneController.text.substring(0, _phoneController.text.length - 1);
      context.read<OtpLoginBloc>().add(
            OtpLoginEvent.phoneChanged(
              '+${_selectedCountry.phoneCode}${_phoneController.text.trim()}',
            ),
          );
    }
  }

  void _handleSubmit() {
    context.read<OtpLoginBloc>().add(const OtpLoginEvent.submit());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<OtpLoginBloc, OtpLoginState>(
      listenWhen: (p, c) =>
          p.isLoading != c.isLoading ||
          p.isError != c.isError ||
          p.isCodeSent != c.isCodeSent,
      listener: (context, state) {
        if (!state.isLoading && state.isCodeSent) {
          final phone = state.phoneNumber.getOrCrash();
          if (state.infoMessage.isNotEmpty) {
            AppHelpers.showCheckFlash(context, state.infoMessage);
          }
          context.goNamed(
            RouteName.otpVerification,
            extra: {
              'phoneNumber': phone,
              'source': 'registration',
            },
          );
        } else if (!state.isLoading && state.isError) {
          // Don't toast for input validation (inline error handles it)
          if (!state.showErrorMessages && state.errorMessage.isNotEmpty) {
            AppHelpers.showErrorFlash(context, state.errorMessage);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: SafeArea(
            top: true,
            bottom: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  // Back Button - Navigate to onboarding
                  AppBackButton(
                    onPressed: () => context.goNamed(RouteName.authSelection),
                  ),
                  SizedBox(height: 24.h),
                  // Welcome Message
                  const RegistrationWelcomeMessage(),
                  SizedBox(height: 32.h),
                  // Phone Number Form Fields
                  RegistrationFormFields(
                    phoneController: _phoneController,
                    onPhoneChanged: (value) {
                      context.read<OtpLoginBloc>().add(
                            OtpLoginEvent.phoneChanged(
                              '+${_selectedCountry.phoneCode}${value.trim()}',
                            ),
                          );
                    },
                    onCountryChanged: _onCountryChanged,
                  ),
                  // Spacer to push keyboard to bottom
                  const Spacer(),
                  // Custom Numeric Keyboard
                  CustomNumericKeyboard(
                    onDigitTap: _handleDigitTap,
                    onBackspace: _handleBackspace,
                    onSubmit: _handleSubmit,
                    showSubmit: false,
                    isLoading: state.isLoading,
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
