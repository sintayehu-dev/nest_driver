// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OtpLoginRequestImpl _$$OtpLoginRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OtpLoginRequestImpl(
      phoneNumber:
          const PhoneNumberConverter().fromJson(json['phone_number'] as String),
    );

Map<String, dynamic> _$$OtpLoginRequestImplToJson(
        _$OtpLoginRequestImpl instance) =>
    <String, dynamic>{
      'phone_number': const PhoneNumberConverter().toJson(instance.phoneNumber),
    };
