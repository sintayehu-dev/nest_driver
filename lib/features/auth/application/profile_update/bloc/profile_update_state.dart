part of 'profile_update_bloc.dart';

@freezed
class ProfileUpdateState with _$ProfileUpdateState {
  const factory ProfileUpdateState({
    required FullName fullName,
    required PhoneNumber phoneNumber,
    @Default(false) bool fullNameChanged,
    @Default(false) bool phoneNumberChanged,
    @Default(false) bool showValidation,
    @Default({}) Map<String, String> validationErrors,
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default('') String errorMessage,
    @Default(false) bool isSuccess,
    String? successMessage,
  }) = _ProfileUpdateState;

  const ProfileUpdateState._();

  /// Returns true if there are validation errors for fields that have been changed or validation is forced
  bool get hasActiveValidationErrors =>
      (validationErrors['fullName'] != null &&
          (fullNameChanged || showValidation)) ||
      (validationErrors['phoneNumber'] != null &&
          (phoneNumberChanged || showValidation));

  /// Returns the full name error if the field has been changed or validation is forced
  String? get activeFullNameError =>
      (fullNameChanged || showValidation) ? validationErrors['fullName'] : null;

  /// Returns the phone number error if the field has been changed or validation is forced
  String? get activePhoneNumberError => (phoneNumberChanged || showValidation)
      ? validationErrors['phoneNumber']
      : null;
}
