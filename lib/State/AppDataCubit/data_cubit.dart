import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_secure/dart_secure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskforce_hrms/State/NavigationCubit/navi_cubit.dart';

import '../../Models/UserModel.dart';

part 'data_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  ///FIREBASE DATA

// Imports all docs in Collection snapshot
  List<String> firebaseDocIDs(snapshot) {
    List<String> dataList = [];

    for (var element in snapshot.data!.docs) {
      dataList.add(element.id);
    }

    return dataList;
  }

  //Firebase get current user data
  Future<UserModel> getUserData() async {
    emit(GettingData());

    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userSnapshot.exists) {
        final userData = UserModel.fromJson(userSnapshot.data()!);
        emit(GetDataSuccessful());
        return userData;
      } else {
        emit(GetDataError());
        throw ("User Doesn't Exist");
      }
    } on FirebaseAuthException {
      emit(GetDataError());
      rethrow;
    }
  }

  //Firebase Login with current user data

  Future<void> userLogin(String mail, String pwd, context) async {
    emit(GettingData());

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pwd)
          .then((value) => AppCubit.get(context).updateSharedUser());

      IconSnackBar.show(
          context: context,
          snackBarType: SnackBarType.save,
          label: 'Successful Login');

      emit(GetDataSuccessful());

      NaviCubit.get(context).navigateToHome(context);
    } on FirebaseAuthException {
      IconSnackBar.show(
          context: context,
          snackBarType: SnackBarType.fail,
          label: 'Login Error!');

      emit(GetDataError());
    }
  }

  //Firebase Register with current user data
  Future<void> userRegister(UserModel userModel, context) async {
    emit(GettingData());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email, password: userModel.password)
          .then((value) =>
              userModel.userID = FirebaseAuth.instance.currentUser!.uid);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.userID)
          .set(userModel.toJson())
          .whenComplete(() => AppCubit.get(context).updateSharedUser());

      IconSnackBar.show(
          context: context,
          snackBarType: SnackBarType.save,
          label: 'Successful Register');

      NaviCubit.get(context).navigateToHome(context);

      emit(GetDataSuccessful());
    } catch (error) {
      IconSnackBar.show(
          context: context,
          snackBarType: SnackBarType.fail,
          label: 'Try again!');

      emit(GetDataError());
    }
  }

  ///LOCAL DATA

  //Update Shared Local Data of current user
  Future<void> updateSharedUser() async {
    emit(UpdatingLocalData());
    try {
      var getData = await getUserData();
      saveSharedMap(getData.toJson());
      emit(LocalDataSuccessful());
    } catch (e) {
      emit(LocalDataFailed());
    }
  }

  Future<void> saveSharedMap(Map mapData) async {
    emit(UpdatingLocalData());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      mapData.forEach((key, value) {
        prefs.setString(key, value);
      });
      emit(LocalDataSuccessful());
    } catch (e) {
      emit(LocalDataFailed());
    }
  }

  //Save Shared Local Data of current user
  Future<void> saveSharedData(Map data) async {
    emit(UpdatingLocalData());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      data.forEach((key, value) {
        prefs.setString(key, value);
      });
      emit(LocalDataSuccessful());
    } catch (e) {
      emit(LocalDataFailed());
    }
  }

  //Get Shared Local Data of current user as list of values
  Future<List?> getSharedList(List keys) async {
    emit(UpdatingLocalData());
    List data = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      for (var element in keys) {
        data.add(prefs.getString(element));
      }
      emit(LocalDataSuccessful());
      return data;
    } catch (e) {
      emit(LocalDataFailed());
    }
    return data;
  }

  //Get Shared Local Data of current user of one value
  Future<String?> getSharedData(String key) async {
    emit(UpdatingLocalData());
    String? value;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      value = prefs.getString(key);
      emit(LocalDataSuccessful());
      return value;
    } catch (e) {
      emit(LocalDataFailed());
    }
    return value;
  }

  /// BIOMETRIC AUTHENTICATION

  //Get the biometric auth from current user
  Future<bool> getBioAuthentication() async {
    emit(GettingData());

    var authStatus = await biometricAuth(
        stickyAuth: true,
        biometricOnly: false,
        sensitiveTransaction: true,
        userErrorDialogs: true,
        message: "Please verify your identity to continue!");

    if (authStatus == AuthenticationStatus.successful) {
      emit(GetDataSuccessful());
      return true;
    } else {
      emit(GetDataError());
      return false;
    }
  }
}
