// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileUpdateResponseImpl _$$ProfileUpdateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileUpdateResponseImpl(
      success: json['success'] as bool,
      data: ProfileUpdateData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ProfileUpdateResponseImplToJson(
        _$ProfileUpdateResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

_$ProfileUpdateDataImpl _$$ProfileUpdateDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileUpdateDataImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      password: json['password'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      status: json['status'] as String?,
      isVerified: json['is_verified'] as bool?,
      isVoid: json['is_void'] as bool?,
      otpCode: json['otp_code'] as String?,
      otpExpiresAt: json['otp_expires_at'] as String?,
      refreshToken: json['refresh_token'] as String?,
      lastLoginAt: json['last_login_at'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$$ProfileUpdateDataImplToJson(
        _$ProfileUpdateDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'status': instance.status,
      'is_verified': instance.isVerified,
      'is_void': instance.isVoid,
      'otp_code': instance.otpCode,
      'otp_expires_at': instance.otpExpiresAt,
      'refresh_token': instance.refreshToken,
      'last_login_at': instance.lastLoginAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
