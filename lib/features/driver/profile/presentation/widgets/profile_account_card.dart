import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nest_driver/core/theme/app_theme.dart';

class ProfileAccountCard extends StatelessWidget {
  final String? profileImageUrl;
  final String? profileImagePath;
  final String? name;
  final String? phoneNumber;
  final VoidCallback? onEdit;

  const ProfileAccountCard({
    super.key,
    this.profileImageUrl,
    this.profileImagePath,
    this.name,
    this.phoneNumber,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSizes = theme.iconSizes;
    final imageSizes = theme.imageSizes;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: imageSizes.avatarSm,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            backgroundImage: profileImagePath != null
                ? FileImage(File(profileImagePath!))
                : profileImageUrl != null
                    ? NetworkImage(profileImageUrl!) as ImageProvider
                    : null,
            child: profileImagePath == null && profileImageUrl == null
                ? Icon(
                    Icons.person_outline,
                    size: iconSizes.xl,
                    color: theme.colorScheme.onSurfaceVariant,
                  )
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name?.trim().isNotEmpty == true ? name!.trim() : 'User',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (phoneNumber != null && phoneNumber!.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    phoneNumber!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onEdit != null)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(12.r),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Icon(
                    Icons.edit_outlined,
                    size: iconSizes.md,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
