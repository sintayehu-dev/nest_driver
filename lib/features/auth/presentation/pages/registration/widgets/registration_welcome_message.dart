import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationWelcomeMessage extends StatelessWidget {
  const RegistrationWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create your account',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "Enter your phone number below and We'll send you a one-time code to verify your phone number.",
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
