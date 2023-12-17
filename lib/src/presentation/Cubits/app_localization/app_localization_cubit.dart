import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_constants.dart';
import 'package:taskforce_hrms/src/config/utils/managers/app_enums.dart';
import 'package:taskforce_hrms/src/data/local/localData_cubit/local_data_cubit.dart';

part 'app_localization_state.dart';

class AppLocalizationCubit extends Cubit<AppLocalizationState> {
  AppLocalizationCubit() : super(AppLocalizationInitial(appLanguages.english));

  static AppLocalizationCubit get(context) => BlocProvider.of(context);

  changeAppLanguage(context, {required String setLanguage}) {
    LocalDataCubit.get(context)
        .saveSharedData(AppConstants.savedAppLanguage, setLanguage);
    emit(ChangeAppLanguageState(setLanguage));
  }

  getAppLanguage(context) async {
    String savedAppLanguage = await LocalDataCubit.get(context)
        .getSharedData(AppConstants.savedAppLanguage);
    emit(ChangeAppLanguageState(savedAppLanguage));
  }
}
