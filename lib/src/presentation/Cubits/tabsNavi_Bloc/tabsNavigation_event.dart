part of 'tabsNavigation_bloc.dart';

@immutable
abstract class TabEvent {}

@immutable
abstract class UserEvent {}

class TabChange extends TabEvent {
  final int currentIndex;

  TabChange(this.currentIndex);
}

class UpdateUserEvent extends UserEvent {
  final UserModel newUser;

  UpdateUserEvent(this.newUser);
}
