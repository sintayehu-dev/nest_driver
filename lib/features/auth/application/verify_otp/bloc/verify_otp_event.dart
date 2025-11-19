part of 'verify_otp_bloc.dart';

@freezed
class VerifyOtpEvent with _$VerifyOtpEvent {
  const factory VerifyOtpEvent.otpChanged(String otp) = VerifyOtpChanged;
  const factory VerifyOtpEvent.submitted() = VerifyOtpSubmitted;
}


