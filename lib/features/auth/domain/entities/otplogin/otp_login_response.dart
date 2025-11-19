import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_login_response.freezed.dart';
part 'otp_login_response.g.dart';

@freezed
class OtpLoginResponse with _$OtpLoginResponse {
  const factory OtpLoginResponse({
    required int code,
    required String message,
    required OtpLoginData data,
  }) = _OtpLoginResponse;

  const OtpLoginResponse._();

  factory OtpLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpLoginResponseFromJson(json);
}

@freezed
class OtpLoginData with _$OtpLoginData {
  const factory OtpLoginData({
    required String message,
    required int expiresIn,
    required String unit,
  }) = _OtpLoginData;

  const OtpLoginData._();

  factory OtpLoginData.fromJson(Map<String, dynamic> json) =>
      _$OtpLoginDataFromJson(json);
}


