part of 'app_localization_cubit.dart';

@immutable
abstract class AppLocalizationState {
  final String locale;

  const AppLocalizationState(this.locale);
}

class AppLocalizationInitial extends AppLocalizationState {
  const AppLocalizationInitial(super.locale);
}

class ChangeAppLanguageState extends AppLocalizationState {
  const ChangeAppLanguageState(super.locale);
}
