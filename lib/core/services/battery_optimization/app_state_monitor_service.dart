import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/services/battery_optimization/models/adaptive_settings.dart';

/// Service for monitoring app lifecycle state changes
@lazySingleton
class AppStateMonitorService with WidgetsBindingObserver {
  AppStateMonitorService() {
    _init();
  }

  final _controller = StreamController<AppStateData>.broadcast();
  AppState _currentState = AppState.foreground;

  /// Stream of app state changes
  Stream<AppStateData> get appStateStream => _controller.stream;

  /// Current app state
  AppState get currentState => _currentState;

  void _init() {
    WidgetsBinding.instance.addObserver(this);
    log('📱 App State Monitor: Started monitoring');

    // Emit initial state
    _controller.add(AppStateData(state: _currentState));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final appState = _mapLifecycleState(state);

    if (appState != _currentState) {
      _currentState = appState;
      log('📱 App State Monitor: State changed to $appState (lifecycle: $state)');

      _controller.add(AppStateData(state: appState));
    }
  }

  AppState _mapLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        return AppState.foreground;
      case AppLifecycleState.inactive:
        // Inactive is a transition state, keep current state
        return _currentState;
      case AppLifecycleState.paused:
        return AppState.background;
      case AppLifecycleState.detached:
        return AppState.background;
      case AppLifecycleState.hidden:
        return AppState.screenOff;
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.close();
  }
}

/// App state data class
class AppStateData {
  const AppStateData({required this.state});

  final AppState state;

  @override
  String toString() => 'AppStateData(state: $state)';
}
