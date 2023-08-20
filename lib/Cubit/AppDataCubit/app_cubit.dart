import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:taskforce_hrms/Components/Components.dart';

import '../../Models/UserModel.dart';
import '../Navigation/navi_cubit.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  var userID = FirebaseAuth.instance.currentUser?.uid;

  // Loading loading = Loading(isLoading: false);
  // DidGetDataSuccessful GotIt = DidGetDataSuccessful(GotData: false);

  // int currentIndex => CurrentIndex.getCurrentIndex;

  void startLoading() => emit(StartLoadingState());

  void stopLoading() => emit(StopLoadingState());

  void startClick() => emit(StartClick());

  void stopClick() => emit(StopClick());

  void selectIt() => emit(SelectIt());

  void unSelectIt() => emit(UnSelectIt());

  bool isSelected(state) => state is SelectIt ? true : false;

  bool isLoading(state) => state is StartLoadingState ? true : false;

  bool gotData() => state is UpdateDataSuccessful ? true : false;

  //not sure about above method
  List<String> firebaseDocIDs(snapshot) {
    List<String> dataList = [];
    for (var element in snapshot.data!.docs) {
      dataList.add(element.id);
    }
    return dataList;
  }

  Future<UserModel> getUserData() async {
    emit(GettingData());
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .get();
      if (userSnapshot.exists) {
        emit(GetDataSuccessful());
        return UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
      } else {
        throw ("User Doesn't Exist");
      }
    } on FirebaseAuthException {
      emit(GetDataError());
      rethrow;
    }
  }

  Future<void> updateSharedUser() async {
    var updateData = UserModel.fromJson(getUserData() as Map<String, dynamic>);
    saveSharedMap(updateData.toJson());
  }

  Future<bool> userLogin(String mail, String pwd, context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pwd);
      IconSnackBar.show(
          context: context,
          snackBarType: SnackBarType.save,
          label: 'Successful Login');
      emit(GetDataSuccessful());
      NaviCubit.get(context).navigateToHome(context);

      return true;
    } on Error {
      emit(GetDataError());
      IconSnackBar.show(
          context: context,
          snackBarType: SnackBarType.fail,
          label: 'Try again!');
      return false;
    }
  }

  Future userRegister(UserModel userModel, context) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .set(userModel.toJson());
      IconSnackBar.show(
          context: context,
          snackBarType: SnackBarType.save,
          label: 'Successful Register');
      emit(GetDataSuccessful());
      return NaviCubit.get(context).navigateToHome(context);
    } on FirebaseAuthException catch (ex) {
      IconSnackBar.show(
          context: context,
          snackBarType: SnackBarType.fail,
          label: 'Try again!');
      emit(GetDataError());
      return "${ex.code}: ${ex.message}";
    }
  }
}
