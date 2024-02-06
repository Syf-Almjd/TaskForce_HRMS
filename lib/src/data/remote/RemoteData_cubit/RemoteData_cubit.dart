import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_secure/dart_secure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_constants.dart';
import 'package:taskforce_hrms/src/config/utils/styles/app_colors.dart';
import 'package:taskforce_hrms/src/domain/Models/attendanceModel.dart';
import 'package:taskforce_hrms/src/domain/Models/eLeaveModel.dart';
import 'package:taskforce_hrms/src/domain/Models/eventModel.dart';
import 'package:taskforce_hrms/src/domain/entities/Authentication/AuthPage.dart';

import '../../../domain/Models/UserModel.dart';
import '../../../domain/Models/announcementModel.dart';
import '../../../presentation/Cubits/navigation_cubit/navi_cubit.dart';
import '../../../presentation/Cubits/tabsNavi_Bloc/tabsNavigation_bloc.dart';
import '../../../presentation/Shared/Components.dart';
import '../../local/localData_cubit/local_data_cubit.dart';

part 'RemoteData_states.dart';

class RemoteDataCubit extends Cubit<RemoteAppStates> {
  RemoteDataCubit() : super(InitialAppState());

  static RemoteDataCubit get(context) => BlocProvider.of(context);

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
          .collection(AppConstants.staffMembersCollection)
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

  Future<void> getRegistrationKey(keyInput, context) async {
    emit(GettingData());
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.usersCollection)
          .doc(AppConstants.PPKstaff)
          .get();

      if (userSnapshot.exists) {
        if (keyInput == userSnapshot.data()![AppConstants.staffKey]) {
          NaviCubit.get(context).pop(context);
          BlocProvider.of<RegisterNavigationBloc>(context).add(TabChange(1));
          emit(GetDataSuccessful());
        } else {
          showToast("Wrong Key, Please contact PPK Admin", AppColors.redColor,
              context);
          tempLockUser(context, afterCountNavigateTo: const AuthPage());
          emit(GetDataError());
        }
      } else {
        showToast(
            "Error, Please check your internet", AppColors.redColor, context);
      }
    } on FirebaseAuthException catch (error) {
      showToast("error $error", AppColors.redColor, context);
      emit(GetDataError());
    }
  }

  Future<bool> checkUserAccount(context) async {
    emit(GettingData());
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.staffMembersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (userSnapshot.exists) {
        emit(GetDataSuccessful());
        return true;
      } else {
        showToast(
            "You account data is inaccessible", AppColors.redColor, context);
        NaviCubit.get(context).navigateToSliderLogout(context);
        emit(GetDataError());
        return false;
      }
    } on FirebaseAuthException catch (error) {
      showToast("error $error", AppColors.redColor, context);

      emit(GetDataError());
      return false;
    }
  }

  Future<void> updateUserData(UserModel userModel, context) async {
    emit(GettingData());
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.staffMembersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userModel.toJson());
      NaviCubit.get(context).navigateToBiometricLogin(context);
      emit(GetDataSuccessful());
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
          .then(
              (value) => LocalDataCubit.get(context).updateSharedUser(context));
      showToast("Successful Login", Colors.blue, context);
      emit(GetDataSuccessful());
      NaviCubit.get(context).navigateToHome(context);
    } on FirebaseAuthException {
      showToast("Successful Error", Colors.red, context);
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
          .collection(AppConstants.staffMembersCollection)
          .doc(userModel.userID)
          .set(userModel.toJson());

      NaviCubit.get(context).navigateToHome(context);
      emit(GetDataSuccessful());
    } catch (error) {
      FirebaseAuth.instance.currentUser!.delete();
      showToast("Error in RegisterMethod $error", Colors.red, context);
      emit(GetDataError());
    }
  }

  Future<List<Object>> getEventPostsData() async {
    emit(GettingData());
    List<Object> data = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.eventsCollection)
          .get();

      for (var element in querySnapshot.docs) {
        final documentSnapshot = await FirebaseFirestore.instance
            .collection(AppConstants.eventsCollection)
            .doc(element.id)
            .get();
        if (documentSnapshot.data() != null) {
          data.add(EventModel.fromJson(documentSnapshot.data()!));
        }
      }
      emit(GetDataSuccessful());
      return data;
    } on FirebaseException {
      emit(GetDataError());
      rethrow;
    }
  }

  Future<List<Object>> getAnnouncementPostsData() async {
    emit(GettingData());
    List<Object> data = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.announcementCollection)
          .get();

      for (var element in querySnapshot.docs) {
        final documentSnapshot = await FirebaseFirestore.instance
            .collection(AppConstants.announcementCollection)
            .doc(element.id)
            .get();
        if (documentSnapshot.data() != null) {
          data.add(AnnouncementModel.fromJson(documentSnapshot.data()!));
        }
      }
      emit(GetDataSuccessful());
      return data;
    } on FirebaseException {
      emit(GetDataError());
      rethrow;
    }
  }

  Future<void> recordTodayAttendance(
      AttendanceModel attendanceModel, context) async {
    emit(GettingData());

    try {
      attendanceModel.userCity = await getLocationName(
          latitude: attendanceModel.userLocationLatitude,
          longitude: attendanceModel.userLocationLongitude);

      await FirebaseFirestore.instance
          .collection(AppConstants.attendanceStaffCollection)
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection(AppConstants.attendanceRecordCollection)
          .doc(attendanceModel.dateTime)
          .set(attendanceModel.toJson());
      updateMemberField(AppConstants.lastAttendUSER);
      await LocalDataCubit.get(context).saveSharedData(
          AppConstants.userLocalAttendance, DateTime.now().toString());
      emit(GetDataSuccessful());
      return;
    } on FirebaseException catch (error) {
      //reset time saved
      LocalDataCubit.get(context).saveSharedData(
          AppConstants.userLocalAttendance, "0000-00-00 11:11:11.111111");

      debugPrint(error.toString());
      emit(GetDataError());
    }
  }

  changePassword(String prevPass, String newPassword) async {
    emit(GettingData());
    try {
      await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: FirebaseAuth.instance.currentUser!.email.toString(),
              password: prevPass));

      await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
      emit(GetDataSuccessful());
    } catch (e) {
      debugPrint(e.toString());
      emit(GetDataError());
    }
  }

  Future<List<AttendanceModel>> getUserAttendanceHistory(context) async {
    emit(GettingData());

    String collectionPath = getCurrentUserAttendance();
    List<Object> data = [];

    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection(collectionPath).get();

      for (var element in querySnapshot.docs) {
        final documentSnapshot = await FirebaseFirestore.instance
            .collection(collectionPath)
            .doc(element.id)
            .get();
        if (documentSnapshot.data() != null) {
          data.add(AttendanceModel.fromJson(documentSnapshot.data()!));
        }
      }
      emit(GetDataSuccessful());
      return data.cast<AttendanceModel>().reversed.toList();
    } on FirebaseException {
      emit(GetDataError());
      rethrow;
    }
  }

  Future<void> recordEleaveRequest(EleaveModel eleaveModel, context) async {
    emit(GettingData());

    try {
      eleaveModel.userCity = await getLocationName(
          latitude: eleaveModel.userLocationLatitude,
          longitude: eleaveModel.userLocationLongitude);

      await FirebaseFirestore.instance
          .collection(AppConstants.eLeaveStaffCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(AppConstants.eLeaveRecordCollection)
          .doc(eleaveModel.dateTime)
          .set(eleaveModel.toJson());

      updateMemberField(AppConstants.lastEleaveUSER);
      await LocalDataCubit.get(context).saveSharedData(
          AppConstants.userLocalEleave, DateTime.now().toString());
      emit(GetDataSuccessful());
      return;
    } on FirebaseException catch (error) {
      LocalDataCubit.get(context).saveSharedData(
          AppConstants.userLocalEleave, "0000-00-00 11:11:11.111111");

      debugPrint(error.toString());
      showToast("Please try again!", AppColors.darkColor, context);
      emit(GetDataError());
      return;
    }
  }

  Future<void> updateMemberField(String memberField) async {
    emit(GettingData());
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.staffMembersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({memberField: DateTime.now().toString()});

      if (memberField == AppConstants.lastAttendUSER) {
        await FirebaseFirestore.instance
            .collection(AppConstants.attendanceStaffCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({memberField: DateTime.now().toString()});
      }
      if (memberField == AppConstants.lastEleaveUSER) {
        await FirebaseFirestore.instance
            .collection(AppConstants.eLeaveStaffCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({memberField: DateTime.now().toString()});
      }
      emit(GetDataSuccessful());
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
      emit(GetDataError());
    }
  }

  Future<List<Object>> getUserEleaveHistory(context) async {
    emit(GettingData());
    String collectionPath = getCurrentUserEleave();
    List<Object> data = [];

    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection(collectionPath).get();

      for (var element in querySnapshot.docs) {
        final documentSnapshot = await FirebaseFirestore.instance
            .collection(collectionPath)
            .doc(element.id)
            .get();
        if (documentSnapshot.data() != null) {
          data.add(EleaveModel.fromJson(documentSnapshot.data()!));
        }
      }
      emit(GetDataSuccessful());
      return data;
    } on FirebaseException {
      emit(GetDataError());
      rethrow;
    }
  }
}
