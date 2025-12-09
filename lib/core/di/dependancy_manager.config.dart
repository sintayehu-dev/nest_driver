// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/application/otplogin/bloc/otp_login_bloc.dart'
    as _i187;
import '../../features/auth/application/profile_update/bloc/profile_update_bloc.dart'
    as _i724;
import '../../features/auth/application/verify_otp/bloc/verify_otp_bloc.dart'
    as _i961;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/user/user_service.dart' as _i516;
import '../../features/auth/infrastructure/auth/datasources/auth_remote_data_source.dart'
    as _i1046;
import '../../features/auth/infrastructure/auth/repositories/auth_repository_impl.dart'
    as _i446;
import '../../features/driver/registration/application/bloc/driver_registration_bloc.dart'
    as _i894;
import '../../features/driver/registration/domain/repositories/driver_registration_repository.dart'
    as _i958;
import '../../features/driver/registration/infrastructure/datasources/driver_registration_remote_data_source.dart'
    as _i462;
import '../../features/driver/registration/infrastructure/repositories/driver_registration_repository_impl.dart'
    as _i829;
import '../handlers/http_service.dart' as _i350;
import '../handlers/websocket_service.dart' as _i958;
import '../services/file_picker_service.dart' as _i108;
import '../services/image_picker_service.dart' as _i644;
import '../services/token_refresh_service.dart' as _i785;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i108.FilePickerService>(() => _i108.FilePickerService());
    gh.factory<_i644.ImagePickerService>(() => _i644.ImagePickerService());
    gh.lazySingleton<_i350.HttpService>(() => _i350.HttpService());
    gh.lazySingleton<_i958.WebSocketService>(() => _i958.WebSocketService());
    gh.lazySingleton<_i785.TokenRefreshService>(
        () => _i785.TokenRefreshService());
    gh.factory<_i1046.AuthRemoteDataSource>(
        () => _i1046.AuthRemoteDataSourceImpl());
    gh.factory<_i516.UserService>(() => _i516.UserServiceImpl());
    gh.factory<_i462.DriverRegistrationRemoteDataSource>(
        () => _i462.DriverRegistrationRemoteDataSourceImpl());
    gh.factory<_i787.AuthRepository>(
        () => _i446.AuthRepositoryImpl(gh<_i1046.AuthRemoteDataSource>()));
    gh.factory<_i958.DriverRegistrationRepository>(() =>
        _i829.DriverRegistrationRepositoryImpl(
            gh<_i462.DriverRegistrationRemoteDataSource>()));
    gh.factory<_i187.OtpLoginBloc>(
        () => _i187.OtpLoginBloc(gh<_i787.AuthRepository>()));
    gh.factory<_i724.ProfileUpdateBloc>(
        () => _i724.ProfileUpdateBloc(gh<_i787.AuthRepository>()));
    gh.factory<_i961.VerifyOtpBloc>(
        () => _i961.VerifyOtpBloc(gh<_i787.AuthRepository>()));
    gh.factory<_i894.DriverRegistrationBloc>(() =>
        _i894.DriverRegistrationBloc(gh<_i958.DriverRegistrationRepository>()));
    return this;
  }
}
