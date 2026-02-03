import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nest_driver/core/di/dependancy_manager.config.dart';
import 'package:nest_driver/core/services/image_picker_service.dart';
import 'package:nest_driver/features/auth/application/otplogin/bloc/otp_login_bloc.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  getIt.init();

  if (!getIt.isRegistered<ImagePickerService>()) {
    getIt.registerLazySingleton<ImagePickerService>(() => ImagePickerService());
  }
  if (!getIt.isRegistered<OtpLoginBloc>()) {
    getIt.registerLazySingleton<OtpLoginBloc>(() => getIt<OtpLoginBloc>());
  }
}
