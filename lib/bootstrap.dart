import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:nest_driver/core/utils/local_storage/local_storage.dart';
import 'package:nest_driver/core/di/dependancy_manager.dart';
import 'package:nest_driver/core/config/app_config.dart';
import 'package:nest_driver/core/config/environment.dart';
import 'package:nest_driver/core/utils/local_storage/local_db_hive/hive_storage.dart';
import 'package:nest_driver/features/driver/location/offline/location_queue_service.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  AppEnvironment? environment,
}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.instance.init();

  // Initialize environment configuration
  if (environment != null) {
    AppConfig.initialize(environment);
  } else {
    // Default to development if not specified
    AppConfig.initialize(AppEnvironment.development);
  }

  Bloc.observer = const AppBlocObserver();

  // Initialize LocalStorage
  await LocalStorage.ensureInitialized();

  // Initialize offline location queue
  await LocationQueueService.instance.init();

  // Add cross-flavor configuration here
  configureDependencies();

  runApp(await builder());
}
