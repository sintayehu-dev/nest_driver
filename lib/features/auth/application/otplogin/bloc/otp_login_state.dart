
part of 'otp_login_bloc.dart';

@freezed
class OtpLoginState with _$OtpLoginState {
  const factory OtpLoginState({
    required PhoneNumber phoneNumber,
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default(false) bool isCodeSent,
    @Default(0) int expiresIn,
    @Default('') String unit,
    @Default('') String infoMessage,
    @Default(false) bool showErrorMessages,
  }) = _OtpLoginState;

  const OtpLoginState._();

  Map<String, String> get firstInvalidField {
    if (!phoneNumber.isValid()) {
      return {
        'key': 'phone_number',
        'error': phoneNumber.value.fold((f) => f.failedValue, (_) => ''),
      };
    }
    return {};
  }
}


