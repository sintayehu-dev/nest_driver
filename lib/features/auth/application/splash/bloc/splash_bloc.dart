import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/core/router/route_name.dart';
import 'package:nest_driver/core/utils/local_storage/local_storage.dart';
import 'package:nest_driver/features/auth/application/splash/bloc/splash_event.dart';
import 'package:nest_driver/features/auth/application/splash/bloc/splash_state.dart';
import 'package:nest_driver/features/auth/domain/user/user_service.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<CheckUserStatus>(_onCheckUserStatus);
  }

  Future<void> _onCheckUserStatus(
    CheckUserStatus event, 
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final userService = getIt<UserService>();
      final isLoggedIn = userService.isLoggedIn();
      
      log('isLoggedIn: $isLoggedIn');
      
      // If logged in, check user role and route accordingly
      if (isLoggedIn) {
        final user = userService.getCurrentUser();
        
        log('SplashBloc: Current user: ${user?.username ?? "null"}');
        if (user?.roles != null && user!.roles.isNotEmpty) {
          log('SplashBloc: User roles:');
          for (var role in user.roles) {
            log('  - ${role.name}');
          }
        }
        
        // Check if user has driver role
        final hasDriverRole = user?.roles.any(
          (role) => role.name.toLowerCase() == 'driver',
        ) ?? false;
        
        log('SplashBloc: Has driver role: $hasDriverRole');
        
        if (hasDriverRole) {
          // User is a driver, check onboarding status
        final isDoneOnboarding = LocalStorage.instance.getIsDoneOnboarding();
          log('SplashBloc: Onboarding done: $isDoneOnboarding');
        if (!isDoneOnboarding) {
          emit(state.copyWith(isLoading: false, isError: false, routeName: RouteName.onboarding));
        } else {
          emit(state.copyWith(isLoading: false, isError: false, routeName: RouteName.driverHome));
          }
        } else {
          // User is not a driver, route to login (they need to register as driver)
          log('SplashBloc: User is not a driver, routing to login');
          emit(state.copyWith(isLoading: false, isError: false, routeName: RouteName.login));
        }
        return;
      }
      
      // If not logged in, navigate to auth selection page
      if (!isLoggedIn) {
        emit(state.copyWith(isLoading: false, isError: false, routeName: RouteName.login));
      }
    } catch (e) {
      log('SplashBloc: Error - $e');
      emit(state.copyWith(isLoading: false, isError: true));
    }
      
    // Uncomment this when you want to implement the actual token check logic
    // try {
    //   final token = LocalStorage.instance.getAccessToken();
    //   log('token: $token');
    //   
    //   if (token != null) {
    //     log('token is not null');
    //     // Token exists, user is logged in
    //     emit(state.copyWith(isLoading: false));
    //   } else {
    //     log('token is null');
    //     // No token, user needs to log in
    //     emit(state.copyWith(isLoading: false));
    //   }
    // } catch (e) {
      //   emit(state.copyWith(isError: true, isLoading: false));
      // }
  }
}