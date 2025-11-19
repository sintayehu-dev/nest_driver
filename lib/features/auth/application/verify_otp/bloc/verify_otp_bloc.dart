import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nest_driver/core/handlers/app_connectivity.dart';
import 'package:nest_driver/core/handlers/network_exceptions.dart';
import 'package:nest_driver/core/utils/local_storage.dart';
import 'package:nest_driver/features/auth/domain/entities/verifyotp/otp_verify_request.dart';
import 'package:nest_driver/features/auth/domain/entities/verifyotp/otp_verify_response.dart';
import 'package:nest_driver/features/auth/domain/repositories/auth_repository.dart';


part 'verify_otp_bloc.freezed.dart';
part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

@injectable
class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc(this._authRepository)
      : super(const VerifyOtpState(otp: '')) {
    on<VerifyOtpChanged>(_onOtpChanged);
    on<VerifyOtpSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  void _onOtpChanged(VerifyOtpChanged event, Emitter<VerifyOtpState> emit) {
    emit(state.copyWith(otp: event.otp.trim(), isError: false, errorMessage: ''));
  }

  Future<void> _onSubmitted(VerifyOtpSubmitted event, Emitter<VerifyOtpState> emit) async {
    final connected = await AppConnectivity.connectivity();
    if (!connected) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "No internet connection. Please check your network.",
      ));
      return;
    }

    if (state.otp.isEmpty) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Please enter the OTP code',
      ));
      return;
    }

 

    emit(state.copyWith(isLoading: true, isError: false, errorMessage: ''));

    final result = await _authRepository.verifyLoginOtp(
      OtpVerifyRequest(otp: state.otp),
    );

    await result.fold(
      (failure) async {
        final error = NetworkExceptions.getRawErrorMessage(failure);
    
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: error,
          isSuccess: false,
          sessionCreated: false,
        ));
      },
      (success) async {
        bool sessionCreated = false;
        final accessToken = success.data.accessToken;
        final refreshToken = success.data.refreshToken;
        if (accessToken != null && refreshToken != null) {
          await LocalStorage.instance.setAccessToken(accessToken);
          await LocalStorage.instance.setRefreshToken(refreshToken);
          // Persist user data if available
          final user = success.data.user;
          if (user != null) {
            await LocalStorage.instance.setUserData(user.toJson());
          }
          sessionCreated = true;
        }
        // ignore: avoid_print
        final roles = success.data.user?.roles.map((r) => r.name).toList();
        emit(state.copyWith(
          isLoading: false,
          isError: false,
          errorMessage: '',
          isSuccess: true,
          accessToken: accessToken,
          refreshToken: refreshToken,
          account: success.data.user,
          sessionCreated: sessionCreated,
        ));
      },
    );
  }
}


