import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nest_driver/core/handlers/app_connectivity.dart';
import 'package:nest_driver/core/handlers/network_exceptions.dart';
import 'package:nest_driver/core/utils/local_storage/local_storage.dart';
import 'package:nest_driver/core/value_object/value_objects.dart';
import 'package:nest_driver/features/auth/domain/entities/profile_update/profile_update_request.dart';
import 'package:nest_driver/features/auth/domain/repositories/auth_repository.dart';

part 'profile_update_bloc.freezed.dart';
part 'profile_update_event.dart';
part 'profile_update_state.dart';

@injectable
class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  ProfileUpdateBloc(this._authRepository)
      : super(ProfileUpdateState(
          fullName: FullName(''),
          phoneNumber: PhoneNumber(''),
          showValidation: false,
        )) {
    on<ProfileUpdateFullNameChanged>(_onFullNameChanged);
    on<ProfileUpdatePhoneNumberChanged>(_onPhoneNumberChanged);
    on<ProfileUpdateSubmitted>(_onSubmitted);
    on<ProfileUpdateLoadInitialData>(_onLoadInitialData);
  }

  final AuthRepository _authRepository;

  void _onLoadInitialData(
    ProfileUpdateLoadInitialData event,
    Emitter<ProfileUpdateState> emit,
  ) {
    final userData = LocalStorage.instance.getUserData();
    if (userData != null) {
      final firstName = userData['first_name'] as String? ?? '';
      final lastName = userData['last_name'] as String? ?? '';
      final phoneNumber = userData['phone_number'] as String? ?? '';

      // Combine first and last name
      final fullName = '$firstName $lastName'.trim();

      emit(state.copyWith(
        fullName: FullName(fullName),
        phoneNumber: PhoneNumber(phoneNumber),
        fullNameChanged: false,
        phoneNumberChanged: false,
        showValidation: false,
        isError: false,
        errorMessage: '',
        validationErrors: {},
      ));
    }
  }

  void _onFullNameChanged(
    ProfileUpdateFullNameChanged event,
    Emitter<ProfileUpdateState> emit,
  ) {
    final fullNameVO = FullName(event.fullName.trim());
    final validationErrors = Map<String, String>.from(state.validationErrors);

    // Update validation errors
    fullNameVO.value.fold(
      (failure) => validationErrors['fullName'] = failure.failedValue,
      (_) => validationErrors.remove('fullName'),
    );

    emit(state.copyWith(
      fullName: fullNameVO,
      fullNameChanged: true,
      validationErrors: validationErrors,
      isError: false,
      errorMessage: '',
    ));
  }

  void _onPhoneNumberChanged(
    ProfileUpdatePhoneNumberChanged event,
    Emitter<ProfileUpdateState> emit,
  ) {
    final phoneNumberVO = PhoneNumber(event.phoneNumber.trim());
    final validationErrors = Map<String, String>.from(state.validationErrors);

    // Update validation errors
    phoneNumberVO.value.fold(
      (failure) => validationErrors['phoneNumber'] = failure.failedValue,
      (_) => validationErrors.remove('phoneNumber'),
    );

    emit(state.copyWith(
      phoneNumber: phoneNumberVO,
      phoneNumberChanged: true,
      validationErrors: validationErrors,
      isError: false,
      errorMessage: '',
    ));
  }

  Future<void> _onSubmitted(
    ProfileUpdateSubmitted event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    // Get current values or use provided values
    final fullNameValue =
        event.fullName?.trim() ?? state.fullName.getOrElse('');
    final phoneNumberValue =
        event.phoneNumber?.trim() ?? state.phoneNumber.getOrElse('');

    // Create value objects for validation
    final fullNameVO = FullName(fullNameValue);
    final phoneNumberVO = PhoneNumber(phoneNumberValue);

    // Validate all fields
    final validationErrors = <String, String>{};

    fullNameVO.value.fold(
      (failure) => validationErrors['fullName'] = failure.failedValue,
      (_) {},
    );

    phoneNumberVO.value.fold(
      (failure) => validationErrors['phoneNumber'] = failure.failedValue,
      (_) {},
    );

    // If there are validation errors, emit them and return
    if (validationErrors.isNotEmpty) {
      emit(state.copyWith(
        fullName: fullNameVO,
        phoneNumber: phoneNumberVO,
        validationErrors: validationErrors,
        showValidation: true, // Force validation messages to show
        isError: false,
        errorMessage: '',
      ));
      return;
    }

    final connected = await AppConnectivity.connectivity();
    if (!connected) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "No internet connection. Please check your network.",
      ));
      return;
    }

    // Update state with validated values
    emit(state.copyWith(
      fullName: fullNameVO,
      phoneNumber: phoneNumberVO,
      validationErrors: {},
      showValidation: false, // Reset validation flag when form is valid
    ));

    emit(state.copyWith(isLoading: true, isError: false, errorMessage: ''));

    // Split full name into first and last name for API
    final nameParts = fullNameValue.split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    // Create update request
    final request = ProfileUpdateRequest(
      firstName: firstName,
      lastName: lastName.isNotEmpty ? lastName : null,
      phoneNumber: phoneNumberValue,
    );

    final result = await _authRepository.updateProfile(request);

    await result.fold(
      (failure) async {
        final errorMessage = NetworkExceptions.getRawErrorMessage(failure);
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: errorMessage,
          isSuccess: false,
        ));
      },
      (success) async {
        // Get existing user data to preserve all fields
        final existingUserData = LocalStorage.instance.getUserData() ?? {};

        // Update local storage with merged user data (preserve existing, update changed)
        final updatedUserData = {
          ...existingUserData, // Preserve all existing fields
          'id': success.data.id,
          'username': success.data.username,
          'phone_number':
              success.data.phoneNumber ?? existingUserData['phone_number'],
          'email': success.data.email ?? existingUserData['email'],
          'first_name':
              success.data.firstName ?? existingUserData['first_name'],
          'last_name': success.data.lastName ?? existingUserData['last_name'],
          'status': success.data.status ?? existingUserData['status'],
          'is_verified':
              success.data.isVerified ?? existingUserData['is_verified'],
          'updated_at': success.data.updatedAt, // Update timestamp
        };
        await LocalStorage.instance.setUserData(updatedUserData);

        emit(state.copyWith(
          isLoading: false,
          isError: false,
          errorMessage: '',
          isSuccess: true,
          successMessage: success.message ?? 'Profile updated successfully',
        ));
      },
    );
  }
}
