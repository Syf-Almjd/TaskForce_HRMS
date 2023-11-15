import 'package:dart_secure/dart_secure.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../data/local/inAppData.dart';
import '../Cubits/appNavi_cubit/navi_cubit.dart';
import 'AuthenticationLayout.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return userAuthMonitor(
        authenticatedUserPage: const SignLayout(),
        unAuthenticatedUserPage: IntroductionScreen(
          globalBackgroundColor: Colors.white,
          pages: listPagesViewModel(context),
          showSkipButton: false,
          skip: const Text("Skip"),
          next: const Text("Next"),
          done: const Icon(
            Icons.navigate_next,
            size: 50,
          ),
          onDone: () {
            NaviCubit.get(context).navigate(context, const SignLayout());
          },
          onSkip: () {
            NaviCubit.get(context).navigate(context, const SignLayout());
          },
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Colors.orangeAccent,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
        ));
  }
}
