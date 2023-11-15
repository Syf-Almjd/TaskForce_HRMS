import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_constants.dart';
import 'package:taskforce_hrms/src/data/local/localData_cubit/local_data_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Authentication/AuthPage.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Cubits/Theme_bloc/theme_bloc.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Cubits/appNavi_cubit/navi_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Cubits/tabsNavi_Bloc/tabsNavigation_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalDataCubit>(
          create: (context) => LocalDataCubit(),
        ),
        BlocProvider<UserRegisterBloc>(
          create: (context) => UserRegisterBloc(),
        ),
        BlocProvider<RegisterNavigationBloc>(
          create: (context) => RegisterNavigationBloc(),
        ),
        BlocProvider<NaviCubit>(
          create: (context) => NaviCubit(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return AdaptiveTheme(
            light: ThemeState.lightTheme.themeData,
            dark: ThemeState.darkTheme.themeData,
            debugShowFloatingThemeButton: false,
            initial: AdaptiveThemeMode.dark,
            builder: (theme, darkTheme) => MaterialApp(
                locale: DevicePreview.locale(context),
                builder: DevicePreview.appBuilder,
                debugShowCheckedModeBanner: false,
                title: AppConstants.appTitle,
                theme: state.themeData,
                home: const AuthPage()),
          );
        },
      ),
    );
  }
}
