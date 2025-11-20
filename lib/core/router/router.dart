import 'package:go_router/go_router.dart';
import 'package:nest_driver/core/navigation/navigation_service.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/utils/local_storage.dart';
import 'package:nest_driver/features/auth/presentation/pages/login/login_screen.dart';
import 'package:nest_driver/features/auth/presentation/pages/onboarding/onboarding_screen.dart';
import 'package:nest_driver/features/auth/presentation/pages/auth_selection/auth_selection_screen.dart';
import 'package:nest_driver/features/auth/presentation/pages/first_time_splash/first_time_splash_screen.dart';
import 'package:nest_driver/features/auth/presentation/pages/registration/registration_screen.dart';
import 'package:nest_driver/features/auth/presentation/pages/verification/otp_verification_screen.dart';
import 'package:nest_driver/features/auth/presentation/pages/splash/splash_screen.dart';
import 'package:nest_driver/features/settings/presentation/pages/settings_screen.dart';
import 'package:nest_driver/core/presentation/main/main_screen.dart';
import 'package:nest_driver/core/presentation/main/driver_shell_page.dart';
import 'package:nest_driver/features/driver/trip_history/presentation/driver_trip_history_screen.dart';
import 'package:nest_driver/features/driver/earnings/presentation/driver_earnings_screen.dart';
import 'package:nest_driver/features/driver/message/presentation/driver_message_screen.dart';
import 'package:nest_driver/features/driver/registration/presentation/driver_registration_screen.dart';


final router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      // Check if this is the first time launching the app
      final hasSeenFirstTimeSplash =
          LocalStorage.instance.hasSeenFirstTimeSplash();
      final currentPath = state.uri.path;

      // If user hasn't seen first-time splash and not already on first-time splash route
      if (!hasSeenFirstTimeSplash &&
          currentPath != '/${RouteName.firstTimeSplash}') {
        return '/${RouteName.firstTimeSplash}';
      }

      // If user has seen first-time splash and trying to access root or first-time splash
      if (hasSeenFirstTimeSplash &&
          (currentPath == '/' ||
              currentPath == '/${RouteName.firstTimeSplash}')) {
        return '/${RouteName.splash}';
      }

      // No redirect needed
      return null;
    },
    routes: [
      // Root route (will be redirected)
      GoRoute(
        path: '/',
        redirect: (context, state) {
          final hasSeenFirstTimeSplash =
              LocalStorage.instance.hasSeenFirstTimeSplash();
          if (!hasSeenFirstTimeSplash) {
            return '/${RouteName.firstTimeSplash}';
          }
          return '/${RouteName.splash}';
        },
      ),

      // Splash (default splash for subsequent app opens)
      GoRoute(
        name: RouteName.splash,
        path: '/${RouteName.splash}',
        builder: (context, state) => const SplashPage(),
      ),

      // First-time splash (shows only once when app is first opened)
      GoRoute(
        name: RouteName.firstTimeSplash,
        path: '/${RouteName.firstTimeSplash}',
        builder: (context, state) => const FirstTimeSplashScreen(),
      ),

      // Auth Selection (login/create account choice)
      GoRoute(
        name: RouteName.authSelection,
        path: '/${RouteName.authSelection}',
        builder: (context, state) => const AuthSelectionScreen(),
      ),

      // Onboarding (shows after role registration for first-time users)
      GoRoute(
        name: RouteName.onboarding,
        path: '/${RouteName.onboarding}',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Registration
      GoRoute(
        name: RouteName.registrationScreen,
        path: '/${RouteName.registrationScreen}',
        builder: (context, state) => const RegistrationScreen(),
      ),

      // Login
      GoRoute(
        name: RouteName.login,
        path: '/${RouteName.login}',
        builder: (context, state) => const LoginScreen(),
      ),

      // OTP Verification
      GoRoute(
        name: RouteName.otpVerification,
        path: '/${RouteName.otpVerification}',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          if (extra != null) {
            return OTPVerificationScreen(
              phoneNumber: extra['phoneNumber'] as String? ?? '',
              expiresAt: extra['expiresAt'] as DateTime?,
              source: extra['source'] as String? ??
                  'login', // 'login' or 'registration'
            );
          }
          // Fallback if extra is null
          return const OTPVerificationScreen(
            phoneNumber: '',
            source: 'login',
          );
        },
      ),

      // Settings
      GoRoute(
        name: RouteName.settings,
        path: '/${RouteName.settings}',
        builder: (context, state) => const SettingsScreen(),
      ),

      // Driver Registration
      GoRoute(
        name: RouteName.driverRegistration,
        path: '/driver/registration',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final phoneNumber = extra?['phoneNumber'] as String?;
          return DriverRegistrationScreen(phoneNumber: phoneNumber);
        },
      ),

      // Driver Shell Route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DriverShellPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteName.driverHome,
                path: '/driver/home',
                builder: (context, state) => const MainScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/driver/trip-history',
                builder: (context, state) => const DriverTripHistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/driver/earnings',
                builder: (context, state) => const DriverEarningsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/driver/message',
                builder: (context, state) => const DriverMessageScreen(),
              ),
            ],
          ),
        ],
      ),
    ]);
