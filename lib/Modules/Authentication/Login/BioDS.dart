import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskforce_hrms/Shared/Components.dart';
import 'package:taskforce_hrms/State/AppDataCubit/data_cubit.dart';
import 'package:taskforce_hrms/State/NavigationCubit/navi_cubit.dart';

class BiometricLogin extends StatelessWidget {
  const BiometricLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<bool>(
              future: AppCubit.get(context).getBioAuthentication(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingAnimation();
                } else if (snapshot.hasError || snapshot.data == false) {
                  return Column(
                    children: [
                      logoContainer(context),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          NaviCubit.get(context)
                              .navigateToBiometricLogin(context);
                        },
                        child: (Platform.isIOS)
                            ? Icon(
                                Icons.face_outlined,
                                size: getWidth(35, context),
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.fingerprint_outlined,
                                size: getWidth(35, context),
                                color: Colors.grey,
                              ),
                      ),
                      const Spacer(),
                      OutlinedButton(
                          onPressed: () {},
                          child: const Text("Contact Administrator")),
                      OutlinedButton(
                          onPressed: () {
                            NaviCubit.get(context)
                                .navigateToSliderLogout(context);
                          },
                          child: const Text("Logout")),
                      OutlinedButton(
                          onPressed: () {
                            if (Platform.isAndroid) {
                              SystemNavigator.pop();
                            } else if (Platform.isIOS) {
                              exit(0);
                            }
                          },
                          child: const Text("Exit")),
                      getCube(10, context),
                    ],
                  );
                } else {
                  Future.delayed(Duration.zero, () {
                    NaviCubit.get(context).navigateToHome(context);
                  });
                  return const Text("Success!");
                }
              })),
    );
  }
}
