part of 'navi_cubit.dart';

abstract class NaviState {}

class InitialNaviState extends NaviState {}

class PagePushedOff extends NaviState {
  String pageName;

  PagePushedOff({
    required this.pageName,
  });
}

class PagePushed extends NaviState {
  String pageName;

  PagePushed({
    required this.pageName,
  });
}

class PagePopped extends NaviState {
  String pageName;

  PagePopped({
    required this.pageName,
  });
}

class HomeState extends NaviState {}

class BiometricLoginState extends NaviState {}

class AdminState extends NaviState {}

class IntoPageState extends NaviState {}
