import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef DigitTapCallback = void Function(String digit);
typedef BackspaceTapCallback = void Function();
typedef SubmitTapCallback = void Function();

class CustomNumericKeyboard extends StatelessWidget {
  final DigitTapCallback onDigitTap;
  final BackspaceTapCallback onBackspace;
  final SubmitTapCallback? onSubmit;
  final bool showSubmit;
  final bool isLoading;

  const CustomNumericKeyboard({
    super.key,
    required this.onDigitTap,
    required this.onBackspace,
    this.onSubmit,
    this.showSubmit = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Widget buildKey(Widget child, {VoidCallback? onTap}) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.all(6.w),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              height: 56.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: child,
            ),
          ),
        ),
      );
    }

    Widget buildDigit(String d) => Text(
          d,
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          buildKey(buildDigit('1'), onTap: () => onDigitTap('1')),
          buildKey(buildDigit('2'), onTap: () => onDigitTap('2')),
          buildKey(buildDigit('3'), onTap: () => onDigitTap('3')),
        ]),
        Row(children: [
          buildKey(buildDigit('4'), onTap: () => onDigitTap('4')),
          buildKey(buildDigit('5'), onTap: () => onDigitTap('5')),
          buildKey(buildDigit('6'), onTap: () => onDigitTap('6')),
        ]),
        Row(children: [
          buildKey(buildDigit('7'), onTap: () => onDigitTap('7')),
          buildKey(buildDigit('8'), onTap: () => onDigitTap('8')),
          buildKey(buildDigit('9'), onTap: () => onDigitTap('9')),
        ]),
        Row(children: [
          buildKey(
            Icon(Icons.close, color: colorScheme.onSurface, size: 28),
            onTap: isLoading ? null : onBackspace,
          ),
          buildKey(buildDigit('0'),
              onTap: isLoading ? null : () => onDigitTap('0')),
          buildKey(
            isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colorScheme.primary,
                      ),
                    ),
                  )
                : Icon(Icons.check, color: colorScheme.onSurface, size: 28),
            onTap: isLoading ? null : onSubmit,
          ),
        ]),
        if (showSubmit)
          Padding(
            padding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 0),
            child: SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r)),
                ),
                child: Text('Continue',
                    style: textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ),
            ),
          ),
      ],
    );
  }
}
