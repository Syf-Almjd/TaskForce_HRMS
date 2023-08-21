import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:taskforce_hrms/Modules/Authentication/AuthPage.dart';
import 'API/firebase_options.dart';
import 'Cubit/AppDataCubit/app_cubit.dart';
import 'Cubit/BaB BloC/ba_b_bloc.dart';
import 'Cubit/Navigation/navi_cubit.dart';
import 'Cubit/Observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
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
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: Colors.blueGrey,
          ),
        ),
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: const AuthPage(),
      ),
    );

  }
}
