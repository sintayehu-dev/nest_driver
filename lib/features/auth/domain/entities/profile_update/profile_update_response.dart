import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_update_response.freezed.dart';
part 'profile_update_response.g.dart';

@freezed
class ProfileUpdateResponse with _$ProfileUpdateResponse {
  const factory ProfileUpdateResponse({
    required bool success,
    required ProfileUpdateData data,
    String? message,
  }) = _ProfileUpdateResponse;

  const ProfileUpdateResponse._();

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateResponseFromJson(json);
}

@freezed
class ProfileUpdateData with _$ProfileUpdateData {
  const factory ProfileUpdateData({
    required String id,
    required String username,
    String? password,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    String? email,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? status,
    @JsonKey(name: 'is_verified') bool? isVerified,
    @JsonKey(name: 'is_void') bool? isVoid,
    @JsonKey(name: 'otp_code') String? otpCode,
    @JsonKey(name: 'otp_expires_at') String? otpExpiresAt,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    @JsonKey(name: 'last_login_at') String? lastLoginAt,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _ProfileUpdateData;

  const ProfileUpdateData._();

  factory ProfileUpdateData.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateDataFromJson(json);
}

