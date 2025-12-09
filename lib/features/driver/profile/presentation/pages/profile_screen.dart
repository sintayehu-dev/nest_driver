import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/theme/app_theme.dart';
import 'package:nest_driver/core/utils/local_storage.dart';
import 'package:nest_driver/features/driver/profile/presentation/widgets/logout_dialog.dart';
import 'package:nest_driver/features/driver/profile/presentation/widgets/profile_account_card.dart';
import 'package:nest_driver/features/driver/profile/presentation/widgets/profile_menu_item.dart';
import 'package:nest_driver/core/presentation/widgets/app_back_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _getUserName(Map<String, dynamic>? userData) {
    if (userData == null) return 'User';

    final fullName = userData['full_name'] as String?;
    if (fullName != null && fullName.trim().isNotEmpty) {
      return _firstToken(fullName);
    }

    final firstName = (userData['first_name'] as String?)?.trim();
    if (firstName != null && firstName.isNotEmpty) {
      return firstName;
    }

    final lastName = (userData['last_name'] as String?)?.trim();
    if (lastName != null && lastName.isNotEmpty) {
      return _firstToken(lastName);
    }

    final username = (userData['username'] as String?)?.trim();
    if (username != null && username.isNotEmpty) {
      return _firstToken(username);
    }

    return 'User';
  }

  String _firstToken(String value) {
    final parts = value.trim().split(RegExp(r'\s+'));
    return parts.isNotEmpty ? parts.first : value.trim();
  }

  String? _getUserPhone(Map<String, dynamic>? userData) {
    if (userData == null) return null;
    String? _asString(dynamic v) {
      if (v == null) return null;
      if (v is String) return v.trim().isEmpty ? null : v.trim();
      return v.toString().trim().isEmpty ? null : v.toString().trim();
    }

    final candidates = [
      _asString(userData['phone_number']),
      _asString(userData['phoneNumber']),
      _asString(userData['phone']),
      _asString(userData['mobile']),
      _asString(userData['mobile_number']),
      _asString(userData['contact']),
      // last resort: email if phone not present
      _asString(userData['email']),
    ];

    return candidates.firstWhere((v) => v != null, orElse: () => null);
  }

  void _refreshData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userData = LocalStorage.instance.getUserData();
    final userName = _getUserName(userData);
    final userPhone = _getUserPhone(userData);

    return Scaffold(
      backgroundColor: theme.colorScheme.innerPageSurface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppBackButton(
                    onPressed: () => context.goNamed(RouteName.driverHome),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Profile',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ProfileAccountCard(
                name: userName,
                phoneNumber: userPhone,
                onEdit: () async {
                  await context.pushNamed(
                    RouteName.editProfile,
                    extra: {
                      'fullName': userName,
                      'phoneNumber': userPhone,
                    },
                  );
                  _refreshData();
                },
              ),
              SizedBox(height: 16.h),
              _MenuCard(
                children: [
                  ProfileMenuItem(
                    icon: Icons.car_repair_outlined,
                    label: 'Change Car',
                    onTap: () {},
                    showTrailing: true,
                  ),
                  ProfileMenuItem(
                    icon: Icons.directions_car_outlined,
                    label: 'Vehicle Information',
                    onTap: () {},
                    showTrailing: true,
                  ),
                  ProfileMenuItem(
                    icon: Icons.payment_outlined,
                    label: 'Payment Info',
                    onTap: () {},
                    showTrailing: true,
                  ),
                  ProfileMenuItem(
                    icon: Icons.star_border_outlined,
                    label: 'Reviews and Ratings',
                    onTap: () {},
                    showTrailing: true,
                  ),
                  ProfileMenuItem(
                    icon: Icons.language_outlined,
                    label: 'Language',
                    onTap: () {},
                    showTrailing: true,
                  ),
                  ProfileMenuItem(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    onTap: () {},
                    showTrailing: true,
                  ),
                  ProfileMenuItem(
                    icon: Icons.tune_outlined,
                    label: 'Preferences',
                    onTap: () {},
                    showTrailing: true,
                  ),
                  ProfileMenuItem(
                    icon: Icons.security_outlined,
                    label: 'Security Settings',
                    onTap: () {},
                    showTrailing: true,
                  ),
                  ProfileMenuItem(
                    icon: Icons.help_outline,
                    label: 'Help & Support',
                    onTap: () {},
                    showTrailing: true,
                  ),
                  ProfileMenuItem(
                    icon: Icons.logout_outlined,
                    label: 'Log Out',
                    isDestructive: true,
                    showTrailing: false,
                    onTap: () => LogoutDialog.showAndHandleLogout(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.children});

  final List<ProfileMenuItem> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: children[i],
            ),
            if (i != children.length - 1)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: theme.colorScheme.outlineVariant.withOpacity(0.2),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
