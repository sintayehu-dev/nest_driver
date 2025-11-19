// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OtpLoginResponseImpl _$$OtpLoginResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$OtpLoginResponseImpl(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: OtpLoginData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OtpLoginResponseImplToJson(
        _$OtpLoginResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

_$OtpLoginDataImpl _$$OtpLoginDataImplFromJson(Map<String, dynamic> json) =>
    _$OtpLoginDataImpl(
      message: json['message'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$$OtpLoginDataImplToJson(_$OtpLoginDataImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'expiresIn': instance.expiresIn,
      'unit': instance.unit,
    };
