import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nest_driver/core/handlers/app_connectivity.dart';
import 'package:nest_driver/core/handlers/network_exceptions.dart';
import 'package:nest_driver/core/utils/local_storage.dart';
import 'package:nest_driver/features/driver/registration/domain/entities/driver_registration_request.dart';
import 'package:nest_driver/features/driver/registration/domain/entities/driver_registration_response.dart';
import 'package:nest_driver/features/driver/registration/domain/repositories/driver_registration_repository.dart';

part 'driver_registration_bloc.freezed.dart';
part 'driver_registration_event.dart';
part 'driver_registration_state.dart';

@injectable
class DriverRegistrationBloc
    extends Bloc<DriverRegistrationEvent, DriverRegistrationState> {
  DriverRegistrationBloc(this._repository)
      : super(const DriverRegistrationState()) {
    on<DriverRegistrationSubmitted>(_onSubmitted);
  }

  final DriverRegistrationRepository _repository;

  Future<void> _onSubmitted(
    DriverRegistrationSubmitted event,
    Emitter<DriverRegistrationState> emit,
  ) async {
    final connected = await AppConnectivity.connectivity();
    if (!connected) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: "No internet connection. Please check your network.",
      ));
      return;
    }

    // Validate required fields
    if (event.driverData.fullName.isEmpty) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Please enter your full name',
      ));
      return;
    }

    if (event.driverData.email.isEmpty) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Please enter your email',
      ));
      return;
    }

    if (event.vehicleData.carMake.isEmpty) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Please enter car make',
      ));
      return;
    }

    if (event.vehicleData.carModel.isEmpty) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Please enter car model',
      ));
      return;
    }

    if (event.vehicleData.plateNumber.isEmpty) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Please enter plate number',
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, isError: false, errorMessage: ''));

    // Build request
    final request = DriverRegistrationRequest(
      driver: event.driverData,
      vehicle: event.vehicleData,
      driverDocuments: event.driverDocuments,
      vehicleDocuments: event.vehicleDocuments,
    );

    final result = await _repository.registerDriver(request);

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
        final accessToken = success.data.token.accessToken;
        final refreshToken = success.data.token.refreshToken;
        
        if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
          await LocalStorage.instance.setAccessToken(accessToken);
          await LocalStorage.instance.setRefreshToken(refreshToken);
          sessionCreated = true;
        }

        emit(state.copyWith(
          isLoading: false,
          isError: false,
          errorMessage: '',
          isSuccess: true,
          response: success,
          sessionCreated: sessionCreated,
        ));
      },
    );
  }
}

