import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nest_driver/core/theme/app_theme.dart';

/// A themed validation helper used to display inline input errors.
class InputValidationMessage extends StatelessWidget {
  const InputValidationMessage({
    super.key,
    required this.message,
    this.icon = Icons.info,
    this.margin,
    this.padding,
  });

  final String message;
  final IconData icon;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textStyle = theme.textTheme.bodySmall?.copyWith(
      color: colorScheme.error,
      fontWeight: FontWeight.w500,
    );

    return Container(
      margin: margin ?? EdgeInsets.only(left: 16.w, top: 4.h, right: 16.w),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: colorScheme.error,
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
