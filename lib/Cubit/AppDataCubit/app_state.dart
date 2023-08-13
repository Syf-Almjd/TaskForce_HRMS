part of 'app_cubit.dart';

class AppStates {}

class InitialAppState extends AppStates {}

class StartLoadingState extends AppStates {}

class StopLoadingState extends AppStates {}

// class Loading extends AppStates {
//   static bool isLoading=false;
// }

// class DidGetDataSuccessful extends AppStates {
//   bool GotData;
//   DidGetDataSuccessful({
//     required this.GotData,
//   });
// }
class UpdateDataSuccessful extends AppStates {}

class GetDataSuccessful extends AppStates {}

class GetDataError extends AppStates {}

class GettingData extends AppStates {}

class StartClick extends AppStates {}

class StopClick extends AppStates {}

class SelectIt extends AppStates {}

class UnSelectIt extends AppStates {}

//add abstract and check what happenns
