import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_verify_response.freezed.dart';
part 'otp_verify_response.g.dart';

@freezed
class OtpVerifyResponse with _$OtpVerifyResponse {
  const factory OtpVerifyResponse({
    required int code,
    required String message,
    required OtpVerifyData data,
  }) = _OtpVerifyResponse;

  const OtpVerifyResponse._();

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyResponseFromJson(json);
}

@freezed
class OtpVerifyData with _$OtpVerifyData {
  const factory OtpVerifyData({
    String? message,
    // actual API returns `user` when registered
    OtpUser? user,
    // and tokens at the same level
    String? accessToken,
    String? refreshToken,
  }) = _OtpVerifyData;

  const OtpVerifyData._();

  factory OtpVerifyData.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyDataFromJson(json);
}

@freezed
class OtpUser with _$OtpUser {
  const factory OtpUser({
    required String id,
    required String username,
    @Default(<OtpUserRole>[]) List<OtpUserRole> roles,
    String? status,
    @JsonKey(name: 'is_verified') bool? isVerified,
  }) = _OtpUser;

  const OtpUser._();

  factory OtpUser.fromJson(Map<String, dynamic> json) => _$OtpUserFromJson(json);
}

@freezed
class OtpUserRole with _$OtpUserRole {
  const factory OtpUserRole({
    required String id,
    required String name,
  }) = _OtpUserRole;

  const OtpUserRole._();

  factory OtpUserRole.fromJson(Map<String, dynamic> json) =>
      _$OtpUserRoleFromJson(json);
}


