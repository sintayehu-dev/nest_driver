import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nest_driver/core/application/app/bloc/app_bloc.dart';
import 'package:nest_driver/core/application/app/bloc/app_state.dart';
import 'package:nest_driver/core/application/app/bloc/app_event.dart';
import 'package:nest_driver/core/router/router.dart';
import 'package:nest_driver/core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return BlocProvider(
      create: (context) => AppBloc()..add(const AppEvent.getThemeMode()),
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Nest',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          themeMode: ThemeMode.light,
          routerConfig: router,
          builder: (context, child) {
            return BlocBuilder<AppBloc, AppState>(
              buildWhen: (previous, current) => 
                previous.isInitialized != current.isInitialized,
              builder: (context, state) {
                if (!state.isInitialized) {
                  context.read<AppBloc>().add(const AppEvent.appInitialized());
                }
                return child!;
              },
            );
          },
        );
      },
    );
  }
}
