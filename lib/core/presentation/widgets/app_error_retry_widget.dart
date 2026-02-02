import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppErrorRetryWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  final String? buttonText;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;

  const AppErrorRetryWidget({
    Key? key,
    required this.errorMessage,
    required this.onRetry,
    this.buttonText,
    this.icon,
    this.iconColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.error_outline,
            color: iconColor ?? Colors.grey[400],
            size: 32.sp,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              errorMessage.isNotEmpty ? errorMessage : 'Failed to fetch data',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: textColor ?? Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 12.h),
          TextButton.icon(
            onPressed: onRetry,
            icon: Icon(
              Icons.refresh_rounded,
              color: iconColor ?? Theme.of(context).colorScheme.secondary,
              size: 20.sp,
            ),
            label: Text(
              buttonText ?? 'Try Again',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: iconColor ?? Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
