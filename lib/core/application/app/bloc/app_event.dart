import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_event.freezed.dart';

@freezed
abstract class AppEvent with _$AppEvent {
  const factory AppEvent.getThemeMode() = GetThemeMode;
  const factory AppEvent.changeTheme({required bool isDarkMode}) = ChangeTheme;
  const factory AppEvent.connectivityChanged({required bool isConnected}) = ConnectivityChanged;
  const factory AppEvent.appInitialized() = AppInitialized;
  const factory AppEvent.getDriverAvailability() = GetDriverAvailability;
  const factory AppEvent.setDriverAvailability({required bool isAvailable}) =
      SetDriverAvailability;
} 