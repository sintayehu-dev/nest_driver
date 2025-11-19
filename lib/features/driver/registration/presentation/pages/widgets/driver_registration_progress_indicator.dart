import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverRegistrationProgressIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const DriverRegistrationProgressIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: List.generate(
        totalPages,
        (index) => Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: index < totalPages - 1 ? 8.w : 0,
            ),
            height: 4.h,
            decoration: BoxDecoration(
              color: index <= currentPage
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ),
      ),
    );
  }
}

