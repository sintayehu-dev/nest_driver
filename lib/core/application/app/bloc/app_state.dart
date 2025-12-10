import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool isDarkMode,
    @Default(false) bool isConnected,
    @Default(false) bool isInitialized,
    @Default(false) bool isDriverAvailable,
  }) = _AppState;

  const AppState._();
} 