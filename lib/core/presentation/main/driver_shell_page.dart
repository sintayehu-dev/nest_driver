import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/theme/app_theme.dart';
import 'package:nest_driver/features/driver/location/application/location_bloc.dart';
import 'package:nest_driver/features/driver/location/application/location_event.dart';

class DriverShellPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const DriverShellPage({
    super.key,
    required this.navigationShell,
  });

  @override
  State<DriverShellPage> createState() => _DriverShellPageState();
}

class _DriverShellPageState extends State<DriverShellPage>
    with WidgetsBindingObserver {
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
    if (state == AppLifecycleState.resumed) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          final locationBloc = context.read<LocationBloc>();
          locationBloc.add(LocationPermissionChecked(context));
        }
      });
    } else if (state == AppLifecycleState.detached) {
      print('🔌 DriverShellPage: App detached');
    }
  }

  void _onNavigationItemSelected(int? branchIndex, BuildContext context) {
    if (branchIndex == null) {
      context.goNamed(RouteName.profile);
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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outlineVariant.withOpacity(0.4),
                width: 0.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Row(
                        children: _navItems
                            .asMap()
                            .entries
                            .map((entry) => _buildNavItem(
                                  context,
                                  item: entry.value,
                                ))
                            .toList(),
                      ),
                    ),
                    _buildTopIndicator(context, constraints.maxWidth),
                  ],
                );
              },
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
    final iconSizes = theme.extension<IconSizes>() ??
        const IconSizes(xs: 12, sm: 16, md: 20, lg: 24, xl: 28, xxl: 32);
    final branchIndex = item.branchIndex;
    final isSelected = branchIndex != null &&
        widget.navigationShell.currentIndex == branchIndex;

    return Expanded(
      child: InkWell(
        onTap: () => _onNavigationItemSelected(branchIndex, context),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: iconSizes.md.w,
                height: iconSizes.md.h,
                child: _buildIcon(context, item, isSelected),
              ),
              SizedBox(height: 6.h),
              Text(
                item.label,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(
      BuildContext context, _DriverNavItem item, bool isSelected) {
    final theme = Theme.of(context);
    final iconSizes = theme.extension<IconSizes>() ??
        const IconSizes(xs: 12, sm: 16, md: 20, lg: 24, xl: 28, xxl: 32);
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;

    switch (item.iconType) {
      case _IconType.svg:
        return SvgPicture.asset(
          item.assetPath,
          width: iconSizes.md.w,
          height: iconSizes.md.h,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      case _IconType.png:
        return ColorFiltered(
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          child: Image.asset(
            item.assetPath,
            width: iconSizes.md.w,
            height: iconSizes.md.h,
            fit: BoxFit.contain,
          ),
        );
      case _IconType.icon:
        return Icon(
          item.iconData ?? Icons.circle,
          size: iconSizes.md,
          color: color,
        );
    }
  }

  Widget _buildTopIndicator(BuildContext context, double containerWidth) {
    final theme = Theme.of(context);
    final selectedIndex = widget.navigationShell.currentIndex;
    final itemCount = _navItems.length;
    final itemWidth = containerWidth / itemCount;
    final indicatorWidth = 60.w;
    final indicatorLeft =
        selectedIndex * itemWidth + (itemWidth - indicatorWidth) / 2;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: 0,
      left: indicatorLeft,
      child: Container(
        width: indicatorWidth,
        height: 6.h,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
      ),
    );
  }
}

class _DriverNavItem {
  const _DriverNavItem({
    required this.assetPath,
    required this.label,
    required this.iconType,
    this.branchIndex,
    this.iconData,
  });

  final String assetPath;
  final String label;
  final _IconType iconType;
  final int? branchIndex;
  final IconData? iconData;
}

enum _IconType { svg, png, icon }

const List<_DriverNavItem> _navItems = [
  _DriverNavItem(
    assetPath: 'assets/home.svg',
    label: 'Home',
    iconType: _IconType.svg,
    branchIndex: 0,
  ),
  _DriverNavItem(
    assetPath: '',
    label: 'Food',
    iconType: _IconType.icon,
    branchIndex: 1,
    iconData: Icons.fastfood_outlined,
  ),
  _DriverNavItem(
    assetPath: 'assets/trip history.svg',
    label: 'Trip History',
    iconType: _IconType.svg,
    branchIndex: 2,
  ),
  _DriverNavItem(
    assetPath: 'assets/earning.svg',
    label: 'Earnings',
    iconType: _IconType.svg,
    branchIndex: 3,
  ),
  _DriverNavItem(
    assetPath: 'assets/message.svg',
    label: 'Message',
    iconType: _IconType.svg,
    branchIndex: 4,
  ),
];
