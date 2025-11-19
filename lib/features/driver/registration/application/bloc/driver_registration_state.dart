part of 'driver_registration_bloc.dart';

@freezed
class DriverRegistrationState with _$DriverRegistrationState {
  const factory DriverRegistrationState({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default(false) bool isSuccess,
    DriverRegistrationResponse? response,
    @Default(false) bool sessionCreated,
  }) = _DriverRegistrationState;

  const DriverRegistrationState._();
}

