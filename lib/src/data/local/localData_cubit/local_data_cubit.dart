import 'dart:convert';

import 'package:dart_secure/dart_secure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_enums.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/domain/Models/UserModel.dart';

import '../../../config/utils/managers/app_constants.dart';
import '../../../presentation/Cubits/navigation_cubit/navi_cubit.dart';
import '../../../presentation/Shared/Components.dart';
import '../../remote/RemoteData_cubit/RemoteData_cubit.dart';

part 'local_data_state.dart';

class LocalDataCubit extends Cubit<LocalDataState> {
  LocalDataCubit() : super(LocalDataInitial());

  static LocalDataCubit get(context) => BlocProvider.of(context);

  ///LOCAL DATA

  //Update Shared Local Data of current user
  Future<void> updateSharedUser(context) async {
    emit(UpdatingLocalData());
    try {
      var getData = await RemoteDataCubit.get(context).getUserData();
      saveSharedMap(AppConstants.savedUser, getData);
      emit(LocalDataSuccessful());
    } catch (e) {
      emit(LocalDataFailed());
    }
  }

  Future<void> saveSharedMap(String mapName, UserModel mapData) async {
    var passwordLessUserData = mapData.toJson();
    passwordLessUserData['password'] = "PasswordLess";
    emit(UpdatingLocalData());
    try {
      String jsonString = jsonEncode(passwordLessUserData);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(mapName, jsonString);
      emit(LocalDataSuccessful());
    } catch (e) {
      emit(LocalDataFailed());
    }
  }

  Future<Map<String, dynamic>> getSharedMap(String mapName) async {
    emit(GettingLocalData());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonString = prefs.getString(mapName);
      Map<String, dynamic> savedData = jsonDecode(jsonString!);
      emit(LocalDataSuccessful());
      return savedData;
    } catch (e) {
      emit(LocalDataFailed());
      return Future.error("LocalDataFailed");
    }
  }

  //Save Shared Local Data of current user
  Future<void> saveSharedData(String key, String data) async {
    emit(UpdatingLocalData());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, data);
      emit(LocalDataSuccessful());
    } catch (e) {
      emit(LocalDataFailed());
    }
  }

  Future<String> getSharedData(String key) async {
    emit(GettingLocalData());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String savedData = prefs.getString(key) ?? appLanguages.english;
      emit(LocalDataSuccessful());
      return savedData;
    } catch (e) {
      emit(LocalDataFailed());
      return appLanguages.english;
    }
  }

  Future<void> clearSharedAll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
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

  //Get the biometric auth from current user
  Future<bool> getBioAuthentication(context) async {
    emit(GettingLocalData());
    try {
      String bioStatus = await getSharedData(AppConstants.userSkipLocalBio);
      if (bool.parse(bioStatus)) {
        return true;
      }
    } catch (e) {
      //Data was not true (not an issue)
    }
    var authStatus = await biometricAuth(
        stickyAuth: true,
        biometricOnly: false,
        sensitiveTransaction: false,
        userErrorDialogs: true,
        message: "Please verify your identity to continue!");

    if (authStatus == AuthenticationStatus.successful) {
      emit(LocalDataSuccessful());
      return true;
    } else {
      showToast("Biometric not captured, try again!", AppColors.primaryColor,
          context);
      emit(LocalDataFailed());
      return false;
    }
  }

  void getAttendanceStatus(context) {
    emit(GettingLocalData());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var date = DateTime.now();

      if ((date.hour >= 6 && date.hour <= 8) ||
          (date.hour >= 18 && date.hour <= 20)) {
      } else {
        showToast("Sorry... you are not allowed to record attendance now!",
            AppColors.primaryColor, context);
        NaviCubit.get(context).pop(context);
      }
    });
  }

  Future<void> getCheckOutStatus(context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var date = DateTime.now();
      if ((date.hour >= 6 && date.hour <= 8) ||
          (date.hour >= 18 && date.hour <= 20)) {
      } else {
        showToast("Sorry... you are not allowed to checkout now!",
            AppColors.primaryColor, context);
        NaviCubit.get(context).pop(context);
      }
    });
  }

  Future<UserModel> getCurrentUser(context) async {
    emit(GettingLocalData());
    UserModel userModel = UserModel.loadingUser();
    try {
      UserModel userModel = UserModel.fromJson(await LocalDataCubit.get(context)
          .getSharedMap(AppConstants.savedUser));
      emit(LocalDataSuccessful());
      return userModel;
    } catch (e) {
      emit(LocalDataFailed());
      return userModel;
    }
  }

  Future<void> getEleaveStatus(context) async {
    emit(GettingLocalData());
    try {
      String userName = await LocalDataCubit.get(context)
          .getSharedData(AppConstants.userLocalEleave);
      if (DateTime.now().toUtc().day ==
          DateTime.parse(userName).toLocal().toUtc().day) {
        showToast(
            "Thank you! Eleave was recorded previously.", Colors.blue, context);
        NaviCubit.get(context).pop(context);
      }
      emit(LocalDataSuccessful());
    } catch (e) {
      //No Saved Attendance
      return;
    }
  }
}
