part of 'tabsNavigation_bloc.dart';

@immutable
abstract class RegisterNavigationState {
  final int defaultIndex;

  const RegisterNavigationState(this.defaultIndex);
}

@immutable
abstract class UserState {
  final UserModel user;

  const UserState(this.user);
}

class RegisterNavigation extends RegisterNavigationState {
  const RegisterNavigation(super.defaultIndex);
}

class UserRegisterState extends UserState {
  const UserRegisterState(super.user);
}

class LoginScreen extends RegisterNavigationState {
  const LoginScreen(super.defaultIndex);
}

class RegisterScreenOne extends RegisterNavigationState {
  const RegisterScreenOne(super.defaultIndex);
}

class RegisterScreenTwo extends RegisterNavigationState {
  const RegisterScreenTwo(super.defaultIndex);
}

class RegisterScreenThree extends RegisterNavigationState {
  const RegisterScreenThree(super.defaultIndex);
}
