import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:taskforce_hrms/src/config/themes/theme_manager.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_constants.dart';
import 'package:taskforce_hrms/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Cubits/app_localization/app_localization_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Cubits/tabsNavi_Bloc/tabsNavigation_bloc.dart';

import 'data/local/localData_cubit/local_data_cubit.dart';
import 'domain/entities/Authentication/AuthenticationLayout.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LocalDataCubit>(
            create: (context) => LocalDataCubit()..updateSharedUser(context),
          ),
          BlocProvider<AppLocalizationCubit>(
              create: (context) =>
                  AppLocalizationCubit()..getAppLanguage(context)),
          BlocProvider<RemoteDataCubit>(
            create: (context) => RemoteDataCubit(),
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
        child: BlocBuilder<AppLocalizationCubit, AppLocalizationState>(
          builder: (context, localeState) {
            return MaterialApp(
                locale: Locale(localeState.locale),
                // DevicePreview.locale(context)
                builder: DevicePreview.appBuilder,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                title: AppConstants.appTitle,
                theme: getApplicationTheme(),
                // darkTheme: getDarkApplicationTheme(),
                home: const SignLayout());
          },
        ));
  }
}
