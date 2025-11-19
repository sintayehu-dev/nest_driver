import 'package:dartz/dartz.dart';
import 'package:nest_driver/core/validation_pipe/value_validators.dart';
import 'package:nest_driver/core/value_failures/value_failures.dart';
import 'package:nest_driver/core/value_object/abstract_value_objects.dart';

class EmailAddress extends AbstractValueObject<String> {
  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class PhoneNumber extends AbstractValueObject<String> {
  factory PhoneNumber(String input) {
    return PhoneNumber._(
      validatePhoneNumber(input),
    );
  }

  const PhoneNumber._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class FullName extends AbstractValueObject<String> {
  factory FullName(String input) {
    return FullName._(
      validateFullName(input),
    );
  }

  const FullName._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}
