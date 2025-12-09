import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/theme/app_theme.dart';
import 'package:nest_driver/core/utils/local_storage.dart';
import 'package:nest_driver/core/router/route_name.dart';

class LocationHeaderCard extends StatelessWidget {
  const LocationHeaderCard({
    super.key,
    required this.currentLocation,
    this.onRefresh,
  });

  final String currentLocation;
  final VoidCallback? onRefresh;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSizes = theme.iconSizes;
    final imageSizes = theme.imageSizes;
    // Name not shown currently, but reserved for future use.
    final userData = LocalStorage.instance.getUserData();
    _extractUserName(userData, fallback: currentLocation);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
      color: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/NEST.svg',
                width: imageSizes.logoSm.w,
                height: (imageSizes.logoSm * 0.6).h,
                fit: BoxFit.contain,
              ),
              GestureDetector(
                onTap: () => context.goNamed(RouteName.profile),
                child: CircleAvatar(
                  radius: imageSizes.avatarSm.r,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  backgroundImage: const AssetImage('assets/avatar_placeholder.png'),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/avatar_placeholder.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.person,
                        size: iconSizes.lg.sp,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _extractUserName(
    Map<String, dynamic>? userData, {
    required String fallback,
  }) {
    if (userData == null) return fallback;
    final nameKeys = ['firstName', 'fullName', 'name'];
    for (final key in nameKeys) {
      final value = userData[key];
      if (value is String && value.trim().isNotEmpty) {
        return _firstName(value.trim());
      }
    }
    return _firstName(fallback);
  }

  String _firstName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    return parts.isNotEmpty ? parts.first : fullName;
  }
}


