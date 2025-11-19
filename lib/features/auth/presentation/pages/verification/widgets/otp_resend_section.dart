import 'package:flutter/material.dart';
import 'package:nest_driver/core/theme/app_colors.dart';

/// Resend code section with timer
class OtpResendSection extends StatelessWidget {
  final int secondsRemaining;
  final bool timerActive;
  final VoidCallback? onResendTimerComplete;

  const OtpResendSection({
    super.key,
    required this.secondsRemaining,
    required this.timerActive,
    this.onResendTimerComplete,
  });

  String _formatTimer(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't get the code? ",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        if (timerActive)
          Text(
            'Resend in ${_formatTimer(secondsRemaining)}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          )
        else
          GestureDetector(
            onTap: () {
              // Restart timer when resend is clicked
              onResendTimerComplete?.call();
            },
            child: Text(
              'Resend',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

