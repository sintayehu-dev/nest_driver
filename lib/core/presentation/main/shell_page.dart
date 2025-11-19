import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/router/route_name.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> with WidgetsBindingObserver {
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

  void _onNavigationItemSelected(int index, BuildContext context) {
    // If "More" button (index 3), navigate to settings
    if (index == 3) {
      context.goNamed(RouteName.settings);
      return;
    }
    
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home tab (index 0)
                _buildNavItem(
                  context,
                  Icons.home_outlined,
                  Icons.home,
                  'Home',
                  0,
                ),
                // Calendar tab (index 1)
                _buildNavItem(
                  context,
                  Icons.calendar_today_outlined,
                  Icons.calendar_today,
                  'Calendar',
                  1,
                ),
                // Stats tab (index 2)
                _buildNavItem(
                  context,
                  Icons.bar_chart_outlined,
                  Icons.bar_chart,
                  'Stats',
                  2,
                ),
                // More/Settings tab (index 3)
                _buildNavItem(
                  context,
                  Icons.settings_outlined,
                  Icons.settings,
                  'More',
                  3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    IconData selectedIcon,
    String label,
    int index,
  ) {
    final theme = Theme.of(context);
    // For "More" button (index 3), check if we're on settings page
    final isSelected = index == 3 
        ? false // Settings page is separate, so don't highlight
        : widget.navigationShell.currentIndex == index;

    return InkWell(
      onTap: () => _onNavigationItemSelected(index, context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(isSelected ? 12.w : 8.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary.withOpacity(0.1)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}