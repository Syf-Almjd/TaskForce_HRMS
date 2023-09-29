import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskforce_hrms/State/AppDataCubit/data_cubit.dart';
import 'package:taskforce_hrms/State/AppEventsBloC/app_bloc.dart';
import 'package:taskforce_hrms/State/Observer.dart';

import 'Data/firebase_options.dart';
import 'Modules/Authentication/AuthPage.dart';
import 'State/NavigationCubit/navi_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => AppCubit(),
        ),
        BlocProvider<UserRegisterBloc>(
          create: (context) => UserRegisterBloc(),
        ),
        BlocProvider<BaBBloc>(
          create: (context) => BaBBloc(),
        ),
        BlocProvider<NaviCubit>(
          create: (context) => NaviCubit(),
        ),
      ],

      child: MaterialApp(
        title: "TaskForce HRMS",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        ).copyWith(
          colorScheme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            }),
          ).colorScheme.copyWith(
                primary: Colors.blueGrey.shade300,
              ),
        ),
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: const AuthPage(),
      ),
    );
  }
}
