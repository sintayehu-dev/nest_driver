part of 'verify_otp_bloc.dart';

@freezed
class VerifyOtpState with _$VerifyOtpState {
  const factory VerifyOtpState({
    required String otp,
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default(false) bool isSuccess,
    String? accessToken,
    String? refreshToken,
    OtpUser? account,
    @Default(false) bool sessionCreated,
  }) = _VerifyOtpState;

  const VerifyOtpState._();
}


