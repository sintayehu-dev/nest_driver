import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_verify_request.freezed.dart';
part 'otp_verify_request.g.dart';

@freezed
class OtpVerifyRequest with _$OtpVerifyRequest {
  const factory OtpVerifyRequest({
    required String otp,
  }) = _OtpVerifyRequest;

  const OtpVerifyRequest._();

  factory OtpVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyRequestFromJson(json);
}


