import 'package:dart_secure/dart_secure.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:taskforce_hrms/Modules/Authentication/LoginUser.dart';
import 'package:taskforce_hrms/Modules/Authentication/RegisterUser.dart';
import 'package:taskforce_hrms/Modules/Home/HomePage.dart';

import '../../API/Data/inAppData.dart';
import '../../Cubit/Navigation/navi_cubit.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return userAuthMonitor(
        authenticatedUserPage: const Login(),
        unAuthenticatedUserPage: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: listPagesViewModel(context),
          showSkipButton: false,
          skip: const Text("Skip"),
          next: const Text("Next"),
          done: const Icon(
            Icons.not_started_outlined,
            size: 50,
          ),
          onDone: () {
            NaviCubit.get(context).navigate(context, const Register());
          },
          onSkip: () {
            NaviCubit.get(context).navigate(context, const Register());
          },
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.amberAccent,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
        ));
  }
}
