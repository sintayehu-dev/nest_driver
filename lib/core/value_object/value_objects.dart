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

class FinNumber extends AbstractValueObject<String> {
  factory FinNumber(String input) {
    return FinNumber._(
      validateFinNumber(input),
    );
  }

  const FinNumber._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class CarMake extends AbstractValueObject<String> {
  factory CarMake(String input) {
    return CarMake._(
      validateCarMake(input),
    );
  }

  const CarMake._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class CarModel extends AbstractValueObject<String> {
  factory CarModel(String input) {
    return CarModel._(
      validateCarModel(input),
    );
  }

  const CarModel._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class PlateNumber extends AbstractValueObject<String> {
  factory PlateNumber(String input) {
    return PlateNumber._(
      validatePlateNumber(input),
    );
  }

  const PlateNumber._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class VehicleColor extends AbstractValueObject<String> {
  factory VehicleColor(String input) {
    return VehicleColor._(
      validateColor(input),
    );
  }

  const VehicleColor._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class VehicleType extends AbstractValueObject<String> {
  factory VehicleType(String input) {
    return VehicleType._(
      validateVehicleType(input),
    );
  }

  const VehicleType._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class YearOfManufacture {
  factory YearOfManufacture(int input) {
    return YearOfManufacture._(
      validateYearOfManufacture(input),
    );
  }

  const YearOfManufacture._(this.value);
  final Either<ValueFailure<String>, int> value;

  int getOrCrash() {
    return value.fold((f) => throw Exception(f.failedValue), (r) => r);
  }

  int getOrElse(int dflt) {
    return value.getOrElse(() => dflt);
  }

  bool isValid() {
    return value.isRight();
  }
}

class VehicleCapacity {
  factory VehicleCapacity(int input) {
    return VehicleCapacity._(
      validateCapacity(input),
    );
  }

  const VehicleCapacity._(this.value);
  final Either<ValueFailure<String>, int> value;

  int getOrCrash() {
    return value.fold((f) => throw Exception(f.failedValue), (r) => r);
  }

  int getOrElse(int dflt) {
    return value.getOrElse(() => dflt);
  }

  bool isValid() {
    return value.isRight();
  }
}
