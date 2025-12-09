part of 'profile_update_bloc.dart';

@freezed
class ProfileUpdateEvent with _$ProfileUpdateEvent {
  const factory ProfileUpdateEvent.loadInitialData() =
      ProfileUpdateLoadInitialData;
  const factory ProfileUpdateEvent.fullNameChanged(String fullName) =
      ProfileUpdateFullNameChanged;
  const factory ProfileUpdateEvent.phoneNumberChanged(String phoneNumber) =
      ProfileUpdatePhoneNumberChanged;
  const factory ProfileUpdateEvent.submitted({
    String? fullName,
    String? phoneNumber,
  }) = ProfileUpdateSubmitted;
}
