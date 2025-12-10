import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nest_driver/core/application/app/bloc/app_event.dart';
import 'package:nest_driver/core/application/app/bloc/app_state.dart';
import 'package:nest_driver/core/utils/local_storage/local_storage.dart';
import 'package:nest_driver/core/handlers/app_connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  AppBloc() : super(const AppState()) {
    on<GetThemeMode>(_onGetThemeMode);
    on<ChangeTheme>(_onChangeTheme);
    on<ConnectivityChanged>(_onConnectivityChanged);
    on<AppInitialized>(_onAppInitialized);
    on<GetDriverAvailability>(_onGetDriverAvailability);
    on<SetDriverAvailability>(_onSetDriverAvailability);
    _setupConnectivity();
  }

  Future<void> _setupConnectivity() async {
    // Initial connectivity check
    final isConnected = await AppConnectivity.connectivity();
    add(AppEvent.connectivityChanged(isConnected: isConnected));

    // Listen to connectivity changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((results) async {
      final isConnected = await AppConnectivity.connectivity();
      add(AppEvent.connectivityChanged(isConnected: isConnected));
    });
  }

  Future<void> _onGetThemeMode(GetThemeMode event, Emitter<AppState> emit) async {
    final isDarkMode = LocalStorage.instance.getAppThemeMode();
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  Future<void> _onChangeTheme(ChangeTheme event, Emitter<AppState> emit) async {
    await LocalStorage.instance.setAppThemeMode(event.isDarkMode);
    emit(state.copyWith(isDarkMode: event.isDarkMode));
  }

  void _onConnectivityChanged(ConnectivityChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(isConnected: event.isConnected));
  }

  void _onAppInitialized(AppInitialized event, Emitter<AppState> emit) {
    emit(state.copyWith(isInitialized: true));
  }

  Future<void> _onGetDriverAvailability(
    GetDriverAvailability event,
    Emitter<AppState> emit,
  ) async {
    final isAvailable = LocalStorage.instance.getDriverAvailability();
    emit(state.copyWith(isDriverAvailable: isAvailable));
  }

  Future<void> _onSetDriverAvailability(
    SetDriverAvailability event,
    Emitter<AppState> emit,
  ) async {
    await LocalStorage.instance.setDriverAvailability(event.isAvailable);
    emit(state.copyWith(isDriverAvailable: event.isAvailable));
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
} 