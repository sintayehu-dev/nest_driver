import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/router/route_name.dart';

class DriverShellPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const DriverShellPage({
    super.key,
    required this.navigationShell,
  });

  @override
  State<DriverShellPage> createState() => _DriverShellPageState();
}

class _DriverShellPageState extends State<DriverShellPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes if needed
  }

  void _onNavigationItemSelected(int? branchIndex, BuildContext context) {
    if (branchIndex == null) {
      context.goNamed(RouteName.settings);
      return;
    }
    
    widget.navigationShell.goBranch(
      branchIndex,
      initialLocation: branchIndex == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.4),
                width: 0.5,
              ),
            ),
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.08),
                blurRadius: 18,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
            top: false,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _navItems
                    .map(
                      (item) => _buildNavItem(
                  context,
                        item: item,
                ),
                    )
                    .toList(),
                ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required _DriverNavItem item,
  }) {
    final theme = Theme.of(context);
    final branchIndex = item.branchIndex;
    final isSelected =
        branchIndex != null && widget.navigationShell.currentIndex == branchIndex;

    return InkWell(
      borderRadius: BorderRadius.circular(24.r),
      onTap: () => _onNavigationItemSelected(branchIndex, context),
      child: SizedBox(
        width: 64.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            SizedBox(height: 4.h),
            SvgPicture.asset(
              item.assetPath,
              width: 24.w,
              height: 24.w,
              colorFilter: ColorFilter.mode(
                isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
                BlendMode.srcIn,
            ),
          ),
            SizedBox(height: 10.h),
          Text(
              item.label,
              overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        ),
      ),
    );
  }
}

class _DriverNavItem {
  const _DriverNavItem({
    required this.assetPath,
    required this.label,
    this.branchIndex,
  });

  final String assetPath;
  final String label;
  final int? branchIndex;
}

const List<_DriverNavItem> _navItems = [
  _DriverNavItem(
    assetPath: 'assets/home.svg',
    label: 'Home',
    branchIndex: 0,
  ),
  _DriverNavItem(
    assetPath: 'assets/trip history.svg',
    label: 'Trip History',
    branchIndex: 1,
  ),
  _DriverNavItem(
    assetPath: 'assets/earning.svg',
    label: 'Earnings',
    branchIndex: 2,
  ),
  _DriverNavItem(
    assetPath: 'assets/message.svg',
    label: 'Message',
    branchIndex: 3,
  ),
  _DriverNavItem(
    assetPath: 'assets/account.svg',
    label: 'Account',
    branchIndex: null,
  ),
];

