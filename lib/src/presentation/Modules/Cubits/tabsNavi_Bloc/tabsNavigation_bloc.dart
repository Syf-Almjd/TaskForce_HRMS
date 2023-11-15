import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/Models/UserModel.dart';
import '../../../Shared/Singleton.dart';

part 'tabsNavigation_event.dart';
part 'tabsNavigation_state.dart';

class UserRegisterBloc extends Bloc<UserEvent, UserState> {
  UserRegisterBloc() : super(UserRegisterState(UserModel.empty())) {
    on<UpdateUserEvent>((event, emit) {
      Singleton().userDataToBeUploaded = event.newUser;
      emit(UserRegisterState(event.newUser));
    });
  }
}

class RegisterNavigationBloc extends Bloc<TabEvent, RegisterNavigationState> {
  RegisterNavigationBloc() : super(const RegisterNavigation(0)) {
    on<TabEvent>((event, emit) {
      if (event is TabChange) {
        switch (event.currentIndex) {
          case (0):
            emit(LoginScreen(event.currentIndex));
            break;
          case (1):
            emit(RegisterScreenOne(event.currentIndex));
            break;
          case (2):
            emit(RegisterScreenTwo(event.currentIndex));
            break;
          case (3):
            emit(RegisterScreenThree(event.currentIndex));
        }
      }
    });
  }
}
