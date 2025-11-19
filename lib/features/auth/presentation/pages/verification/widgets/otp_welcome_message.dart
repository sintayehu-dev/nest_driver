import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Welcome message widget for OTP verification screen
class OtpWelcomeMessage extends StatelessWidget {
  final String phoneNumber;

  const OtpWelcomeMessage({
    super.key,
    required this.phoneNumber,
  });

  /// Masks the phone number to show format like "+251-912****25"
  String _maskPhoneNumber(String phone) {
    if (phone.isEmpty) return phone;
    
    // Remove any non-digit characters except + at the start
    final digits = phone.replaceAll(RegExp(r'[^\d+]'), '');
    
    // If it starts with +, keep it
    final hasPlus = digits.startsWith('+');
    final cleanDigits = hasPlus ? digits.substring(1) : digits;
    
    if (cleanDigits.length < 5) return phone;
    
    // Format: +251-912****25
    // Country code: first 3 digits (251)
    // First 3 digits of number: next 3 digits (912)
    // Masked middle: ****
    // Last 2 digits: last 2 digits (25)
    
    if (cleanDigits.length < 8) {
      // If too short, just mask the middle
      final firstThree = cleanDigits.substring(0, 3);
      final lastTwo = cleanDigits.length >= 5 
          ? cleanDigits.substring(cleanDigits.length - 2)
          : '';
      final masked = hasPlus 
          ? '+$firstThree-****$lastTwo'
          : '$firstThree-****$lastTwo';
      return masked;
    }
    
    // Full format: +251-912****25
    final countryCode = cleanDigits.substring(0, 3);
    final firstThreeDigits = cleanDigits.length >= 6 
        ? cleanDigits.substring(3, 6)
        : cleanDigits.substring(3);
    final lastTwo = cleanDigits.substring(cleanDigits.length - 2);
    
    final masked = hasPlus 
        ? '+$countryCode-$firstThreeDigits****$lastTwo'
        : '$countryCode-$firstThreeDigits****$lastTwo';
    
    return masked;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maskedPhone = _maskPhoneNumber(phoneNumber);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify your phone number.',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Enter the 6-digit OTP sent to your phone\n$maskedPhone',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

