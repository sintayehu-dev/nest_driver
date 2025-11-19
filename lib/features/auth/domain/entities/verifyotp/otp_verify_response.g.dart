// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OtpVerifyResponseImpl _$$OtpVerifyResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$OtpVerifyResponseImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: OtpVerifyData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OtpVerifyResponseImplToJson(
        _$OtpVerifyResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

_$OtpVerifyDataImpl _$$OtpVerifyDataImplFromJson(Map<String, dynamic> json) =>
    _$OtpVerifyDataImpl(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : OtpUser.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$$OtpVerifyDataImplToJson(_$OtpVerifyDataImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

_$OtpUserImpl _$$OtpUserImplFromJson(Map<String, dynamic> json) =>
    _$OtpUserImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => OtpUserRole.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <OtpUserRole>[],
      status: json['status'] as String?,
      isVerified: json['is_verified'] as bool?,
    );

Map<String, dynamic> _$$OtpUserImplToJson(_$OtpUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'roles': instance.roles,
      'status': instance.status,
      'is_verified': instance.isVerified,
    };

_$OtpUserRoleImpl _$$OtpUserRoleImplFromJson(Map<String, dynamic> json) =>
    _$OtpUserRoleImpl(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$OtpUserRoleImplToJson(_$OtpUserRoleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
