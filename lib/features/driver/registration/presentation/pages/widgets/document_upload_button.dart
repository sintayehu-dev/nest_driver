import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocumentUploadButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const DocumentUploadButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.upload_file),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        alignment: Alignment.centerLeft,
        minimumSize: Size(double.infinity, 56.h),
      ),
    );
  }
}

