import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';
import 'package:nest_driver/features/auth/presentation/pages/verification/widgets/otp_welcome_message.dart';
import 'package:nest_driver/features/auth/presentation/pages/verification/widgets/otp_input_field.dart';
import 'package:nest_driver/features/auth/presentation/pages/verification/widgets/otp_resend_section.dart';
import 'package:nest_driver/core/presentation/widgets/custom_numeric_keyboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/core/presentation/widgets/app_helpers.dart';
import 'package:nest_driver/core/utils/local_storage/local_storage.dart';
import 'package:nest_driver/features/auth/application/verify_otp/bloc/verify_otp_bloc.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({
    super.key,
    required this.phoneNumber,
    this.expiresAt,
    this.source = 'login', // 'login' or 'registration'
  });
  final String phoneNumber;
  final DateTime? expiresAt;
  final String source;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VerifyOtpBloc>(),
      child: OTPVerificationView(
        phoneNumber: phoneNumber,
        source: source,
      ),
    );
  }
}

class OTPVerificationView extends StatelessWidget {
  const OTPVerificationView({
    super.key,
    required this.phoneNumber,
    required this.source,
  });
  final String phoneNumber;
  final String source;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
            listenWhen: (p, c) =>
                p.isLoading != c.isLoading ||
                p.isError != c.isError ||
                p.isSuccess != c.isSuccess,
            listener: (context, state) {
              if (!state.isLoading && state.isSuccess) {
                dev.log('✅ OTP Verification: Success!');
                dev.log('   Session Created: ${state.sessionCreated}');

                if (state.sessionCreated) {
                  // Check if user has driver role
                  final user = state.account;

                  dev.log('👤 OTP Verification: User Info:');
                  dev.log('   User ID: ${user?.id ?? "null"}');
                  dev.log('   Username: ${user?.username ?? "null"}');
                  dev.log('   User Status: ${user?.status ?? "null"}');
                  dev.log('   Is Verified: ${user?.isVerified ?? "null"}');

                  if (user?.roles != null && user!.roles.isNotEmpty) {
                    dev.log('   Roles Count: ${user.roles.length}');
                    dev.log('   Roles:');
                    for (var role in user.roles) {
                      dev.log('     - ID: ${role.id}, Name: "${role.name}"');
                    }
                  } else {
                    dev.log('   Roles: null or empty');
                  }

                  final hasDriverRole = user?.roles.any(
                        (role) => role.name.toLowerCase() == 'driver',
                      ) ??
                      false;

                  dev.log('   Has Driver Role: $hasDriverRole');

                  if (hasDriverRole) {
                    // User is a driver, route to home/onboarding
                    final isDoneOnboarding =
                        LocalStorage.instance.getIsDoneOnboarding();
                    dev.log('🚗 OTP Verification: User is a DRIVER');
                    dev.log('   Onboarding Done: $isDoneOnboarding');
                    if (!isDoneOnboarding) {
                      dev.log('   → Routing to: Onboarding');
                      context.goNamed(RouteName.onboarding);
                    } else {
                      dev.log('   → Routing to: Driver Home');
                      context.goNamed(RouteName.driverHome);
                    }
                  } else {
                    // User is not a driver, route to registration
                    dev.log('📝 OTP Verification: User is NOT a driver');
                    dev.log('   → Routing to: Driver Registration');
                    context.goNamed(
                      RouteName.driverRegistration,
                      extra: {
                        'phoneNumber': phoneNumber,
                      },
                    );
                  }
                } else {
                  // No session created, route to driver registration
                  dev.log('❌ OTP Verification: No session created');
                  dev.log('   → Routing to: Driver Registration');
                  context.goNamed(
                    RouteName.driverRegistration,
                    extra: {
                      'phoneNumber': phoneNumber,
                    },
                  );
                }
              } else if (!state.isLoading &&
                  state.isError &&
                  state.errorMessage.isNotEmpty) {
                dev.log('❌ OTP Verification: Error - ${state.errorMessage}');
                // Check if it's a connectivity error
                if (state.errorMessage
                        .toLowerCase()
                        .contains('no internet connection') ||
                    state.errorMessage.toLowerCase().contains('network')) {
                  AppHelpers.showNoConnectionSnackBar(context,
                      message: state.errorMessage);
                } else {
                  AppHelpers.showErrorFlash(context, state.errorMessage);
                }
              }
            },
            builder: (context, state) {
              return OTPVerificationBody(
                phoneNumber: phoneNumber,
                source: source,
              );
            },
          ),
        ),
      ),
    );
  }
}

class OTPVerificationBody extends StatefulWidget {
  final String phoneNumber;
  final String source;

  const OTPVerificationBody({
    super.key,
    required this.phoneNumber,
    required this.source,
  });

  @override
  State<OTPVerificationBody> createState() => _OTPVerificationBodyState();
}

class _OTPVerificationBodyState extends State<OTPVerificationBody> {
  final TextEditingController _otpController = TextEditingController();
  Timer? _resendTimer;
  int _secondsRemaining = 60;
  bool _timerActive = true;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    setState(() {
      _timerActive = true;
      _secondsRemaining = 45; // Start at 45 seconds (00:45)
    });

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _timerActive = false;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _resendTimer?.cancel();
    super.dispose();
  }

  void _handleOtpChange(String value) {
    if (_isDisposed || !mounted) return;
    setState(() {});
    context.read<VerifyOtpBloc>().add(VerifyOtpEvent.otpChanged(value));
  }

  void _handleSubmit() {
    if (_isDisposed || !mounted) return;
    if (_otpController.text.length == 6) {
      context.read<VerifyOtpBloc>().add(const VerifyOtpEvent.submitted());
    }
  }

  void _handleDigitTap(String digit) {
    if (_isDisposed || !mounted) return;
    if (_otpController.text.length < 6) {
      _otpController.text += digit;
      _handleOtpChange(_otpController.text);
    }
  }

  void _handleBackspace() {
    if (_isDisposed || !mounted) return;
    if (_otpController.text.isNotEmpty) {
      _otpController.text =
          _otpController.text.substring(0, _otpController.text.length - 1);
      _handleOtpChange(_otpController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),

        // Back Button
        AppBackButton(
          onPressed: () {
            if (widget.source == 'registration') {
              context.goNamed(RouteName.registrationScreen);
            } else {
              context.goNamed(RouteName.login);
            }
          },
        ),

        SizedBox(height: 24.h),

        // Welcome Message
        OtpWelcomeMessage(phoneNumber: widget.phoneNumber),

        SizedBox(height: 32.h),

        // OTP Input Field (read-only, controlled by custom keyboard)
        OtpInputField(
          controller: _otpController,
          onChanged: _handleOtpChange,
        ),

        SizedBox(height: 24.h),

        // Resend Section
        OtpResendSection(
          secondsRemaining: _secondsRemaining,
          timerActive: _timerActive,
          onResendTimerComplete: _startResendTimer,
        ),

        // Spacer to push keyboard to bottom
        const Spacer(),

        // Custom Numeric Keyboard
        CustomNumericKeyboard(
          onDigitTap: _handleDigitTap,
          onBackspace: _handleBackspace,
          onSubmit: _handleSubmit,
          showSubmit: false,
          isLoading: context.select((VerifyOtpBloc b) => b.state.isLoading),
        ),

        SizedBox(height: 24.h),
      ],
    );
  }
}
