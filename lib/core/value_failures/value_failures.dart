import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;
  const factory ValueFailure.invalidEmail({
    required T failedValue,
  }) = InvalidEmail<T>;
  const factory ValueFailure.invalidFullName({
    required T failedValue,
  }) = InvalidFullName<T>;
  const factory ValueFailure.invalidPhoneNumber({
    required T failedValue,
  }) = InvalidPhoneNumber<T>;
  const factory ValueFailure.invalidFinNumber({
    required T failedValue,
  }) = InvalidFinNumber<T>;
  const factory ValueFailure.invalidCarMake({
    required T failedValue,
  }) = InvalidCarMake<T>;
  const factory ValueFailure.invalidCarModel({
    required T failedValue,
  }) = InvalidCarModel<T>;
  const factory ValueFailure.invalidPlateNumber({
    required T failedValue,
  }) = InvalidPlateNumber<T>;
  const factory ValueFailure.invalidColor({
    required T failedValue,
  }) = InvalidColor<T>;
  const factory ValueFailure.invalidVehicleType({
    required T failedValue,
  }) = InvalidVehicleType<T>;
  const factory ValueFailure.invalidYear({
    required T failedValue,
  }) = InvalidYear<T>;
  const factory ValueFailure.invalidCapacity({
    required T failedValue,
  }) = InvalidCapacity<T>;
}
