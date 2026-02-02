import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/presentation/widgets/app_helpers.dart';
import 'package:nest_driver/core/presentation/widgets/custom_numeric_keyboard.dart';
import 'package:nest_driver/features/auth/application/otplogin/bloc/otp_login_bloc.dart';
import 'package:nest_driver/features/auth/presentation/pages/login/widgets/login_welcome_message.dart';
import 'package:nest_driver/features/auth/presentation/pages/login/widgets/login_phone_form.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:country_picker/country_picker.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpLoginBloc>(
      create: (_) => getIt<OtpLoginBloc>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    // Update bloc phone with new dial code
    final bloc = context.read<OtpLoginBloc>();
    bloc.add(
      OtpLoginEvent.phoneChanged(
          '+${_selectedCountry.phoneCode}${_phoneController.text.trim()}'),
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
      listenWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.isError != current.isError ||
          previous.isCodeSent != current.isCodeSent,
      listener: (context, state) {
        if (!state.isLoading && state.isCodeSent) {
          // Show success toast with backend message
          if (state.infoMessage.isNotEmpty) {
            AppHelpers.showCheckFlash(context, state.infoMessage);
          }
          // Navigate to OTP verification step if available
          final phone = state.phoneNumber.getOrCrash();
          context.goNamed(
            RouteName.otpVerification,
            extra: {
              'phoneNumber': phone,
              'source': 'login',
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
                  const LoginWelcomeMessage(),

                  SizedBox(height: 32.h),

                  // Phone Input Form
                  LoginPhoneForm(
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
