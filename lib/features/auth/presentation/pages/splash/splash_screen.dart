import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nest_driver/features/auth/application/splash/bloc/splash_bloc.dart';
import 'package:nest_driver/features/auth/application/splash/bloc/splash_event.dart';
import 'package:nest_driver/features/auth/application/splash/bloc/splash_state.dart';
import 'package:nest_driver/core/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _topPolygonSwipe;
  late Animation<double> _bottomPolygonSwipe;
  late Animation<double> _logoFade;
  late Animation<double> _logoSlideUp;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2800),
      vsync: this,
    );

    // Logo fades out and slides up to disappear
    _logoFade = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    _logoSlideUp = Tween<double>(begin: 0, end: -60).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Polygons swipe out synced with logo fade
    _topPolygonSwipe = Tween<double>(begin: 0, end: -700).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    _bottomPolygonSwipe = Tween<double>(begin: 0, end: -700).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final splashBloc = SplashBloc();
        Future.delayed(
          const Duration(seconds: 3),
          () => splashBloc.add(const SplashEvent.checkUserStatus()),
        );
        return splashBloc;
      },
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (!state.isLoading && !state.isError && state.routeName != null) {
            context.goNamed(state.routeName!);
          }

          if (state.isError) {
            // Handle error state
            // Show error message or retry option
          }
        },
        child: Builder(
          builder: (context) {
            final size = MediaQuery.of(context).size;
            return Scaffold(
              backgroundColor: AppColors.white,
              body: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Stack(
                    children: [
                      // Top Polygon - swipes left
                      Positioned(
                        top: 0,
                        left: _topPolygonSwipe.value,
                        child: SvgPicture.asset(
                          'assets/polygon_top_left.svg',
                          width: size.width * 1.3,
                          height: size.height * 0.50,
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
                          width: size.width * 1.3,
                          height: size.height * 0.55,
                          fit: BoxFit.fill,
                          alignment: Alignment.bottomRight,
                        ),
                      ),

                      // Logo - fades in and slides up
                      Center(
                        child: Transform.translate(
                          offset: Offset(0, _logoSlideUp.value),
                          child: Opacity(
                            opacity: _logoFade.value,
                            child: SvgPicture.asset(
                              'assets/NEST.svg',
                              width: 160.w,
                              height: 46.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
