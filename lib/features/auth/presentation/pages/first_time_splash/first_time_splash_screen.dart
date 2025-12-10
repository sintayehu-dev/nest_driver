import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/utils/local_storage/local_storage.dart';
import 'package:nest_driver/core/theme/app_colors.dart';

/// First-time splash screen that shows only once when app is first opened
class FirstTimeSplashScreen extends StatefulWidget {
  const FirstTimeSplashScreen({super.key});

  @override
  State<FirstTimeSplashScreen> createState() => _FirstTimeSplashScreenState();
}

class _FirstTimeSplashScreenState extends State<FirstTimeSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _initialController;
  late AnimationController _swipeController;
  late AnimationController _revealController;
  late AnimationController _buttonsController;

  // Initial fade in for logo/tagline
  late Animation<double> _logoInitialFade;

  // Swipe animations (1s - 2s)
  late Animation<double> _topPolygonSwipe;
  late Animation<double> _bottomPolygonSwipe;

  // Reveal transition (2s - 2.5s)
  late Animation<double> _logoMoveUp;

  // Button animations (2.5s - 3s)
  late Animation<double> _loginButtonFade;
  late Animation<double> _loginButtonSlide;
  late Animation<double> _createButtonFade;
  late Animation<double> _createButtonSlide;

  @override
  void initState() {
    super.initState();

    // Initial state (0s - 1s)
    _initialController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Swipe animation (1s - 2s)
    _swipeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Reveal transition (2s - 2.5s)
    _revealController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Buttons fade-up (2.5s - 3s)
    _buttonsController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _setupAnimations();
    _startAnimationSequence();
  }

  void _setupAnimations() {
    // Initial logo fade (0s - 1s)
    _logoInitialFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _initialController,
        curve: Curves.easeIn,
      ),
    );

    // Polygon swipe animations (1s - 2s)
    _topPolygonSwipe = Tween<double>(begin: 0, end: -600).animate(
      CurvedAnimation(
        parent: _swipeController,
        curve: Curves.easeInOut,
      ),
    );

    _bottomPolygonSwipe = Tween<double>(begin: 0, end: -600).animate(
      CurvedAnimation(
        parent: _swipeController,
        curve: Curves.easeInOut,
      ),
    );

    // Logo move up (2s - 2.5s)
    _logoMoveUp = Tween<double>(begin: 0, end: -60).animate(
      CurvedAnimation(
        parent: _revealController,
        curve: Curves.easeInOut,
      ),
    );

    // Login button (2.5s - 3s)
    _loginButtonFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _buttonsController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _loginButtonSlide = Tween<double>(begin: 80, end: 0).animate(
      CurvedAnimation(
        parent: _buttonsController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Create Account button (slightly delayed)
    _createButtonFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _buttonsController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
      ),
    );

    _createButtonSlide = Tween<double>(begin: 80, end: 0).animate(
      CurvedAnimation(
        parent: _buttonsController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );
  }

  Future<void> _startAnimationSequence() async {
    // Initial State (0s - 1s): Logo fades in
    await _initialController.forward();

    // Swipe Animation (1s - 2s): Triangles swipe out
    await _swipeController.forward();

    // Reveal Transition (2s - 2.5s): Logo moves up
    await _revealController.forward();

    // Fade-Up Buttons (2.5s - 3s): Buttons appear
    await _buttonsController.forward();
  }

  Future<void> _handleContinue() async {
    // Mark as seen when user clicks a button
    await LocalStorage.instance.setHasSeenFirstTimeSplash(true);
  }

  @override
  void dispose() {
    _initialController.dispose();
    _swipeController.dispose();
    _revealController.dispose();
    _buttonsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _initialController,
          _swipeController,
          _revealController,
          _buttonsController,
        ]),
        builder: (context, child) {
          return Stack(
            children: [
              // Top Polygon - swipes left
              Positioned(
                top: 0,
                left: _topPolygonSwipe.value,
                child: SvgPicture.asset(
                  'assets/polygon_top_left.svg',
                  width: size.width * 1.2,
                  height: size.height * 0.45,
                  fit: BoxFit.fill,
                  alignment: Alignment.topLeft,
                ),
              ),

              // Bottom Polygon - swipes right
              Positioned(
                bottom: 0,
                right: _bottomPolygonSwipe.value,
                child: SvgPicture.asset(
                  'assets/polygon_bottom_right.svg',
                  width: size.width * 1.2,
                  height: size.height * 0.50,
                  fit: BoxFit.fill,
                  alignment: Alignment.bottomRight,
                ),
              ),

              // Main Content
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: Transform.translate(
                          offset: Offset(0, _logoMoveUp.value),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // NEST Logo
                              Opacity(
                                opacity: _logoInitialFade.value,
                                child: SvgPicture.asset(
                                  'assets/NEST.svg',
                                  width: 160.w,
                                  height: 46.h,
                                  fit: BoxFit.contain,
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // Slogan/Tagline
                              Opacity(
                                opacity: _logoInitialFade.value,
                                child: Text(
                                  'Your Journey, Protected.',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Auth Buttons
                      Column(
                        children: [
                          // Log in Button
                          Transform.translate(
                            offset: Offset(0, _loginButtonSlide.value),
                            child: Opacity(
                              opacity: _loginButtonFade.value,
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await _handleContinue();
                                    if (mounted) {
                                      context.goNamed(RouteName.login);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.r),
                                    ),
                                    elevation: 0,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 14.h),
                                  ),
                                  child: Text(
                                    'Log in',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 12.h),

                          // Create Account Button
                          Transform.translate(
                            offset: Offset(0, _createButtonSlide.value),
                            child: Opacity(
                              opacity: _createButtonFade.value,
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await _handleContinue();
                                    if (mounted) {
                                      context.goNamed(RouteName.registrationScreen);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.grey200,
                                    foregroundColor: AppColors.textPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.r),
                                    ),
                                    elevation: 0,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 14.h),
                                  ),
                                  child: Text(
                                    'Create Account',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
