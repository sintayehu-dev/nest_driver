import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nest_driver/core/theme/app_colors.dart';
import 'package:nest_driver/core/theme/app_theme.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final double? size;

  const AppBackButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSizes = theme.iconSizes;

    final buttonSize = size ?? 36.0;
    final iconSize = iconSizes.md;

    final arrowColor = iconColor ?? const Color(0xFF1A1A1A);
    final border = borderColor ?? AppColors.outlineVariant;

    return Container(
      width: buttonSize.w,
      height: buttonSize.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: border,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed ?? () => Navigator.of(context).pop(),
          borderRadius: BorderRadius.circular(10.r),
          splashColor: AppColors.grey200.withOpacity(0.3),
          highlightColor: AppColors.grey200.withOpacity(0.1),
          child: Center(
            child: Icon(
              Icons.arrow_back,
              size: iconSize,
              color: arrowColor,
            ),
          ),
        ),
      ),
    );
  }
}
