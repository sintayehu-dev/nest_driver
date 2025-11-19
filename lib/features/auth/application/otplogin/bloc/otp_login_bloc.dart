import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/handlers/app_connectivity.dart';
import 'package:nest_driver/core/handlers/network_exceptions.dart';

import 'package:nest_driver/core/validation_pipe/value_validators.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nest_driver/features/auth/domain/entities/otplogin/otp_login_request.dart';
import 'package:nest_driver/features/auth/domain/repositories/auth_repository.dart';
import 'package:nest_driver/core/value_object/value_objects.dart';

part 'otp_login_bloc.freezed.dart';
part 'otp_login_event.dart';
part 'otp_login_state.dart';

@injectable
class OtpLoginBloc extends Bloc<OtpLoginEvent, OtpLoginState> {
  OtpLoginBloc(this._authRepository)
      : super(
          OtpLoginState(
            phoneNumber: PhoneNumber(''),
          ),
        ) {
    on<OtpPhoneChanged>(_onPhoneChanged);
    on<OtpLoginSubmitted>(_onSubmit);
  }

  final AuthRepository _authRepository;

  void _onPhoneChanged(OtpPhoneChanged event, Emitter<OtpLoginState> emit) {
    emit(
      state.copyWith(
        phoneNumber: PhoneNumber(event.phone.trim()),
        showErrorMessages: false,
        isError: false,
        errorMessage: '',
        isCodeSent: false,
      ),
    );
  }

  Future<void> _onSubmit(OtpLoginSubmitted event, Emitter<OtpLoginState> emit) async {
    final connected = await AppConnectivity.connectivity();
    if (!connected) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "No internet connection. Please check your network.",
      ));
      return;
    }

    // Validate using VO validator to surface helpful messages (avoid getOrCrash)
    final phoneRaw = state.phoneNumber.value.fold((_) => '', (v) => v);
    final phoneValidation = validatePhoneNumber(phoneRaw);
    if (phoneValidation.isLeft()) {
      final message = phoneValidation.fold((f) => f.failedValue.toString(), (_) => '');
      emit(state.copyWith(
        showErrorMessages: true,
        isError: true,
        errorMessage: message,
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, isError: false, errorMessage: ''));

    final request = OtpLoginRequest(phoneNumber: state.phoneNumber);
    final result = await _authRepository.requestOtpLogin(request);

    result.fold(
      (failure) {
        final errorMessage = NetworkExceptions.getRawErrorMessage(failure);
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            errorMessage: errorMessage,
            isCodeSent: false,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            isLoading: false,
            isError: false,
            errorMessage: '',
            isCodeSent: true,
            expiresIn: success.data.expiresIn,
            unit: success.data.unit,
            infoMessage: success.data.message,
          ),
        );
      },
    );
  }
}


