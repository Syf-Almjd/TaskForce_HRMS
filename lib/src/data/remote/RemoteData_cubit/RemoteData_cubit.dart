import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

import '../../../domain/Models/UserModel.dart';
import '../../../presentation/Modules/Cubits/appNavi_cubit/navi_cubit.dart';
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
          .then(
              (value) => LocalDataCubit.get(context).updateSharedUser(context));
      showToast("Successful Login", SnackBarType.save, context);

      emit(GetDataSuccessful());

      NaviCubit.get(context).navigateToHome(context);
    } on FirebaseAuthException {
      showToast("Successful Error", SnackBarType.fail, context);
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
          .whenComplete(
              () => LocalDataCubit.get(context).updateSharedUser(context));
      showToast("Successful Login", SnackBarType.save, context);

      NaviCubit.get(context).navigateToHome(context);

      emit(GetDataSuccessful());
    } catch (error) {
      showToast("Successful Error", SnackBarType.fail, context);

      emit(GetDataError());
    }
  }
}
