import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_constants.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:taskforce_hrms/src/presentation/Modules/Home/home_page.dart';

import '../../../../data/local/localData_cubit/local_data_cubit.dart';
import '../../../Cubits/navigation_cubit/navi_cubit.dart';
import '../../../Shared/Components.dart';

class BiometricLogin extends StatelessWidget {
  const BiometricLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<bool>(
              future: LocalDataCubit.get(context).getBioAuthentication(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingAnimation();
                } else if (snapshot.hasError || snapshot.data == false) {
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(top: 30, right: 20),
                        child: IconButton(
                            onPressed: () {
                              showToast("Please contact: +601154225092",
                                  AppColors.primaryColor, context);
                            },
                            icon: const Icon(Icons.support_agent_rounded)),
                      ),
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
                          onPressed: () {
                            NaviCubit.get(context)
                                .navigateToSliderLogout(context);
                          },
                          child: const Text("Logout")),
                      const Spacer(),
                      OutlinedButton(
                          onPressed: () {
                            if (Platform.isAndroid) {
                              SystemNavigator.pop();
                            } else if (Platform.isIOS) {
                              exit(0);
                            }
                          },
                          child: const Text("Exit")),
                      getCube(2, context),
                    ],
                  );
                } else {
                  // Future.delayed(Duration.zero, () {
                  LocalDataCubit.get(context).updateSharedUser(context);
                  RemoteDataCubit.get(context).updateMemberField(
                      AppConstants.lastLoginUSER, DateTime.now().toString());
                  return const HomePage();
                }
                // );
              })),
    );
  }
}
