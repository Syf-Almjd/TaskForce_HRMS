import 'package:dart_secure/dart_secure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskforce_hrms/src/data/local/localData_cubit/local_data_cubit.dart';

import '../../../domain/entities/Authentication/AuthPage.dart';
import '../../Modules/Authentication/Login/BioDS.dart';
import '../../Modules/Authentication/Login/LoginUser.dart';

part 'navi_state.dart';

class NaviCubit extends Cubit<NaviState> {
  NaviCubit() : super(InitialNaviState());

  static NaviCubit get(context) => BlocProvider.of(context);

  void navigate(context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
    emit(PagePushed(pageName: widget.toString()));
  }

  void navigateOff(context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
    emit(PagePushedOff(pageName: widget.toString()));
  }

  void navigateToTempStopPage(context) {
    tempLockUser(context,
        afterCountNavigateTo: const Login(),
        lockedPageMessage: "You are Locked! Please wait:",
        time: 10);
    emit(HomeState());
  }

  void navigateToHome(context) {
    Navigator.popUntil(context, (route) => route.isFirst);
    emit(HomeState());
  }

  void navigateToAdmin(context) {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const LoginPage()));
    emit(AdminState());
  }

  void navigateToSliderLogout(context) {
    FirebaseAuth.instance.signOut();
    LocalDataCubit.get(context).clearSharedAll();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const AuthPage()));
    emit(IntoPageState());
  }

  void navigateToBiometricLogin(context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const BiometricLogin()));
    emit(BiometricLoginState());
  }

  void pop(context) {
    final currentRoute = ModalRoute.of(context);
    // Check if there is a previous route in the navigation stack
    if (currentRoute != null && currentRoute.canPop) {
      Navigator.pop(context);
    }
    emit(PagePopped(pageName: currentRoute.toString()));
  }
}
