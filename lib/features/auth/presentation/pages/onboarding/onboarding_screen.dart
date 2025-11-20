import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/utils/local_storage.dart';
import 'package:nest_driver/core/theme/app_colors.dart';

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
      description: 'Schedule rides in seconds and follow every journey in real time — whether it\'s yours or your child\'s.',
      showSkip: true,
      buttonText: 'Next',
    ),
    OnboardingPageData(
      imagePath: 'assets/onboarding2.png',
      overlayImagePath: 'assets/overlay_on_onbording2.png',
      verifiedDriversImagePath: 'assets/Verified drivers.png',
      safeTravelsImagePath: 'assets/save_travel.png',
      title: 'Simple and Safe',
      description: 'Every driver is verified, every ride is monitored — giving you peace of mind from pickup to drop-off.',
      showSkip: true,
      buttonText: 'Next',
    ),
    OnboardingPageData(
      imagePath: 'assets/onboarding3.png',
      title: 'Pay Easily',
      description: 'Add your preferred payment method — Telebirr, Kacha or pay with cash — and enjoy smooth, secure payments after every ride.',
      showSkip: false,
      buttonText: 'Continue',
    ),
  ];

  Future<void> _onFinish(BuildContext context) async {
    await LocalStorage.ensureInitialized();
    await LocalStorage.instance.setIsDoneOnboarding(true);
    
    // Navigate to driver home after onboarding
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
    // Skip all remaining pages and finish onboarding immediately
    _onFinish(context);
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
      backgroundColor: AppColors.white,
      body: Column(
          children: [
          // Page View with images at top - SafeArea on top
            Expanded(
            flex: 3,
            child: SafeArea(
              top: true,
              bottom: false,
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
            ),
            
          // White bottom section - SafeArea on bottom
          Expanded(
            flex: 1,
            child: SafeArea(
              top: false,
              bottom: true,
              child: Stack(
                children: [
                  // White background container
                  Container(
                    width: double.infinity,
                    color: AppColors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Title and Description Section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Title
                                Text(
                                  _pages[_currentPage].title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                // Description
                                Text(
                                  _pages[_currentPage].description,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textPrimary,
                                    height: 1.5,
                  ),
                ),
                              ],
              ),
            ),
                          // Navigation Buttons - Fixed at bottom with consistent padding
            Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
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
                  ),
                ],
              ),
            ),
          ),
        ],
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
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        // Image at top - stretch to touch left and right edges, keep original height
        // Allow overflow to show full image without bottom clipping for all pages
                Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                data.imagePath,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.grey200,
                    child: Center(
                          child: Icon(
                        Icons.image_outlined,
                        size: 80.sp,
                        color: AppColors.textSecondary,
                              ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
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
        backgroundColor: AppColors.grey200,
        foregroundColor: AppColors.textPrimary,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 14.h),
      ),
      child: Text(
        'Skip',
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
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
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
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
          color: AppColors.white,
        ),
      ),
    );
  }
}


