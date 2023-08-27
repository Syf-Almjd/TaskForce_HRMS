part of 'app_bloc.dart';

@immutable
abstract class BaBEvent {}

@immutable
abstract class UserEvent {}

class TabChange extends BaBEvent {
  final int currentIndex;

  TabChange(this.currentIndex);
}

class UpdateUserEvent extends UserEvent {
  final UserModel newUser;

  UpdateUserEvent(this.newUser);
}
