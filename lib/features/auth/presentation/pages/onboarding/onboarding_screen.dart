import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/utils/local_storage.dart';

/// Onboarding page that shows after role registration for first-time users
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      imagePath: 'assets/onboarding1.png',
      title: 'Book your rides and track every trip',
      description: 'Schedule rides in seconds and follow every journey in real time � whether it\'s yours or your child\'s.',
      showSkip: true,
      buttonText: 'Next',
    ),
    OnboardingPageData(
      imagePath: 'assets/onboarding2.png',
      overlayImagePath: 'assets/overlay_on_onbording2.png',
      verifiedDriversImagePath: 'assets/Verified drivers.png',
      safeTravelsImagePath: 'assets/save_travel.png',
      title: 'Simple and Safe',
      description: 'Every driver is verified, every ride is monitored � giving you peace of mind from pickup to drop-off.',
      showSkip: true,
      buttonText: 'Next',
    ),
    OnboardingPageData(
      imagePath: 'assets/onboarding3.png',
      title: 'Pay Easily',
      description: 'Add your preferred payment method � Telebirr, Kacha or pay with cash � and enjoy smooth, secure payments after every ride.',
      showSkip: false,
      buttonText: 'Continue',
    ),
  ];

  Future<void> _onFinish(BuildContext context) async {
    await LocalStorage.ensureInitialized();
    await LocalStorage.instance.setIsDoneOnboarding(true);
    
    // Navigate to driver home
    if (context.mounted) {
      context.goNamed(RouteName.driverHome);
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onFinish(context);
    }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _OnboardingPage(
                    data: _pages[index],
                    pageIndex: index,
                  );
                },
              ),
            ),
            
            // Page Indicators
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _PageIndicator(
                    isActive: index == _currentPage,
                  ),
                ),
              ),
            ),
            
            // Navigation Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Row(
                children: [
                  if (_pages[_currentPage].showSkip)
                    Expanded(
                      child: _SkipButton(
                        onPressed: _currentPage == _pages.length - 1
                            ? () => _onFinish(context)
                            : _skipToEnd,
                      ),
                    ),
                  if (_pages[_currentPage].showSkip)
                    SizedBox(width: 16.w),
                  Expanded(
                    flex: _pages[_currentPage].showSkip ? 1 : 1,
                    child: _NextButton(
                      text: _pages[_currentPage].buttonText,
                      onPressed: _nextPage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPageData {
  final String imagePath;
  final String? overlayImagePath;
  final String? verifiedDriversImagePath;
  final String? safeTravelsImagePath;
  final String title;
  final String description;
  final bool showSkip;
  final String buttonText;

  OnboardingPageData({
    required this.imagePath,
    this.overlayImagePath,
    this.verifiedDriversImagePath,
    this.safeTravelsImagePath,
    required this.title,
    required this.description,
    required this.showSkip,
    required this.buttonText,
  });
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;
  final int pageIndex;

  const _OnboardingPage({
    required this.data,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        // Top Image Section
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
            ),
            child: Stack(
              children: [
                // Main Image as overlay
                Positioned.fill(
                  child: Image.asset(
                    data.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildImagePlaceholder(theme);
                    },
                  ),
                ),
                
                // Page-specific overlays
                if (pageIndex == 1) _buildDriverOverlays(theme),
                if (pageIndex == 2) _buildPaymentOverlays(theme),
              ],
            ),
          ),
        ),
        
        // Bottom Text Section with curved border
        Expanded(
          flex: 1,
          child: ClipPath(
            clipper: _CurvedClipper(),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          data.description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Curved pink border line
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: Size(double.infinity, 30.h),
                      painter: _CurvedBorderPainter(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePlaceholder(ThemeData theme) {
    // Placeholder with different content based on page
    if (pageIndex == 0) {
      // Page 1: Person holding phone with map
      return Container(
        color: theme.colorScheme.scrim,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.phone_android,
                size: 120.sp,
                color: theme.colorScheme.onPrimary.withOpacity(0.3),
              ),
              SizedBox(height: 16.h),
              Icon(
                Icons.map,
                size: 80.sp,
                color: theme.colorScheme.onPrimary.withOpacity(0.3),
              ),
              SizedBox(height: 16.h),
              Text(
                'Map View',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onPrimary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (pageIndex == 1) {
      // Page 2: Driver in car
      return Container(
        color: theme.colorScheme.scrim,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 120.sp,
                color: theme.colorScheme.onPrimary.withOpacity(0.3),
              ),
              SizedBox(height: 16.h),
              Icon(
                Icons.directions_car,
                size: 80.sp,
                color: theme.colorScheme.onPrimary.withOpacity(0.3),
              ),
              SizedBox(height: 16.h),
              Text(
                'Driver Profile',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onPrimary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Page 3: Person in back seat with payment icons
      return Container(
        color: theme.colorScheme.scrim,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_outline,
                size: 120.sp,
                color: theme.colorScheme.onPrimary.withOpacity(0.3),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.payment,
                    size: 40.sp,
                    color: theme.colorScheme.onPrimary.withOpacity(0.3),
                  ),
                  SizedBox(width: 16.w),
                  Icon(
                    Icons.account_balance_wallet,
                    size: 40.sp,
                    color: theme.colorScheme.onPrimary.withOpacity(0.3),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'Payment Methods',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onPrimary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildDriverOverlays(ThemeData theme) {
    return Stack(
      children: [
        // "Verified drivers" bubble - top left
        if (data.verifiedDriversImagePath != null)
          Positioned(
            top: 40.h,
            left: 24.w,
            child: Image.asset(
              data.verifiedDriversImagePath!,
              width: 150.w,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.scrim.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'Verified drivers',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        
        // Driver Profile Card Overlay - center
        if (data.overlayImagePath != null)
          Positioned(
            top: 120.h,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                data.overlayImagePath!,
                width: 320.w,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 320.w,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.shadow.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.colorScheme.primary,
                              width: 2,
                            ),
                            color: theme.colorScheme.surfaceContainerHighest,
                          ),
                          child: Icon(
                            Icons.person,
                            size: 30.sp,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified,
                                    size: 16.sp,
                                    color: theme.colorScheme.primary,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'verified',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Abebe Bikila',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Text(
                                    '3.5/5',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  ...List.generate(5, (index) {
                                    return Icon(
                                      index < 3
                                          ? Icons.star
                                          : Icons.star_border,
                                      size: 14.sp,
                                      color: index < 3
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurfaceVariant,
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.directions_car,
                              size: 32.sp,
                              color: theme.colorScheme.onSurface,
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onSurface,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'ABC-123',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.surface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        
        // "Safe travels" bubble - bottom right
        if (data.safeTravelsImagePath != null)
          Positioned(
            bottom: 100.h,
            right: 24.w,
            child: Image.asset(
              data.safeTravelsImagePath!,
              width: 120.w,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.scrim.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'Safe travels',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildPaymentOverlays(ThemeData theme) {
    return Stack(
      children: [
        // Payment method icons positioned around the image
        Positioned(
          top: 60.h,
          right: 40.w,
          child: _PaymentIcon(
            icon: Icons.account_balance_wallet,
            size: 60.w,
            theme: theme,
          ),
        ),
        Positioned(
          top: 180.h,
          left: 40.w,
          child: _PaymentIcon(
            icon: Icons.payment,
            size: 60.w,
            theme: theme,
          ),
        ),
        Positioned(
          bottom: 120.h,
          left: 60.w,
          child: _PaymentIcon(
            icon: Icons.money,
            size: 60.w,
            theme: theme,
          ),
        ),
        Positioned(
          bottom: 140.h,
          right: 50.w,
          child: _PaymentIcon(
            icon: Icons.credit_card,
            size: 60.w,
            theme: theme,
          ),
        ),
      ],
    );
  }
}

class _PaymentIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final ThemeData theme;

  const _PaymentIcon({
    required this.icon,
    required this.size,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: size * 0.5,
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final bool isActive;

  const _PageIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 24.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: isActive 
            ? theme.colorScheme.primary 
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SkipButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.surfaceVariant,
        foregroundColor: theme.colorScheme.onSurface,
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 14.h),
      ),
      child: Text(
        'Skip',
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _NextButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 14.h),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Start from top-left
    path.lineTo(0, 0);
    
    // Create a smooth upward curve at the top
    path.quadraticBezierTo(
      size.width * 0.25,
      -20, // Curve upward
      size.width * 0.5,
      0,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      20, // Curve downward
      size.width,
      0,
    );
    
    // Continue to other corners
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _CurvedBorderPainter extends CustomPainter {
  final Color color;

  _CurvedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final path = Path();
    
    // Create a smooth wavy curve from left to right
    final controlPoint1 = Offset(size.width * 0.25, -15);
    final controlPoint3 = Offset(size.width * 0.75, -10);
    
    path.moveTo(0, 0);
    path.quadraticBezierTo(
      controlPoint1.dx,
      controlPoint1.dy,
      size.width * 0.5,
      0,
    );
    path.quadraticBezierTo(
      controlPoint3.dx,
      controlPoint3.dy,
      size.width,
      0,
    );
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
