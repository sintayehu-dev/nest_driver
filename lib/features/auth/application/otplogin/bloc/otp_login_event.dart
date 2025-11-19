part of 'otp_login_bloc.dart';

@freezed
class OtpLoginEvent with _$OtpLoginEvent {
  const factory OtpLoginEvent.phoneChanged(String phone) = OtpPhoneChanged;
  const factory OtpLoginEvent.submit() = OtpLoginSubmitted;
}


