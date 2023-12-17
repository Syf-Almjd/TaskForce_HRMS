import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/presentation/Shared/Singleton.dart';

import '../../../presentation/Cubits/tabsNavi_Bloc/tabsNavigation_bloc.dart';
import '../../../presentation/Modules/Authentication/Login/LoginUser.dart';
import '../../../presentation/Modules/Authentication/Registration/RegisterFirstPage.dart';
import '../../../presentation/Modules/Authentication/Registration/RegisterSecondPage.dart';
import '../../../presentation/Modules/Authentication/Registration/RegisterThirdPage.dart';
import '../../../presentation/Shared/Components.dart';

class SignLayout extends StatefulWidget {
  const SignLayout({super.key});

  @override
  State<SignLayout> createState() => _SignLayoutState();
}

class _SignLayoutState extends State<SignLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppColors.scaffoldColor),
        child: Column(
          children: [
            logoContainer(context),
            Expanded(
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                  child: BlocBuilder<RegisterNavigationBloc,
                      RegisterNavigationState>(builder: (context, state) {
                    if (state is LoginScreen) {
                      return const Login();
                    }
                    if (state is RegisterScreenOne) {
                      return const RegisterFirstPage();
                    }
                    if (state is RegisterScreenTwo) {
                      return RegisterSecondPage(
                          previousUserData: Singleton().userDataToBeUploaded);
                    }
                    if (state is RegisterScreenThree) {
                      return RegisterThirdPage(
                          previousUserData: Singleton().userDataToBeUploaded);
                    } else {
                      return const Login();
                    }
                  })),
            )
          ],
        ),
      ),
    );
  }
}
