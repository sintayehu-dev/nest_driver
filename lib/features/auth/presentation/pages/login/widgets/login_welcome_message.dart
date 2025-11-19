import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Welcome message widget with title and subtitle
class LoginWelcomeMessage extends StatelessWidget {
  const LoginWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Log in into your account',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "Enter your phone number below and We'll send you a one-time code to verify your account.",
          style: theme.textTheme.bodyMedium, // B-1: 14px, Regular 400, line-height 1.5, letter-spacing 0px
        ),
      ],
    );
  }
}
