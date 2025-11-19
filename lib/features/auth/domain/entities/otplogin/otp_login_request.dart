import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nest_driver/core/value_object/value_objects.dart';

part 'otp_login_request.freezed.dart';
part 'otp_login_request.g.dart';

class PhoneNumberConverter implements JsonConverter<PhoneNumber, String> {
  const PhoneNumberConverter();

  @override
  PhoneNumber fromJson(String json) => PhoneNumber(json);

  @override
  String toJson(PhoneNumber object) => object.getOrCrash();
}

@freezed
class OtpLoginRequest with _$OtpLoginRequest {
  const factory OtpLoginRequest({
    @PhoneNumberConverter()
    @JsonKey(name: 'phone_number')
    required PhoneNumber phoneNumber,
  }) = _OtpLoginRequest;

  const OtpLoginRequest._();

  factory OtpLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpLoginRequestFromJson(json);
}
