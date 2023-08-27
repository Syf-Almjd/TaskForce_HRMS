part of 'app_bloc.dart';

@immutable
abstract class BaBState {
  final int defaultIndex;

  const BaBState(this.defaultIndex);
}

@immutable
abstract class UserState {
  final UserModel user;

  const UserState(this.user);
}

class BaBInitial extends BaBState {
  const BaBInitial(super.defaultIndex);
}

class UserRegisterDataState extends UserState {
  const UserRegisterDataState(super.user);
}

class LoginScreen extends BaBState {
  const LoginScreen(super.defaultIndex);
}

class RegisterScreenOne extends BaBState {
  const RegisterScreenOne(super.defaultIndex);
}

class RegisterScreenTwo extends BaBState {
  const RegisterScreenTwo(super.defaultIndex);
}

class RegisterScreenThree extends BaBState {
  const RegisterScreenThree(super.defaultIndex);
}
