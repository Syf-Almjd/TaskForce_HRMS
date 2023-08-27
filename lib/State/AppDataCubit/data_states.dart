part of 'data_cubit.dart';

class AppStates {}

//add abstract and check what happenns

// UI States
class InitialAppState extends AppStates {}

class StartLoadingState extends AppStates {}

class StopLoadingState extends AppStates {}

class SelectIt extends AppStates {}

class UnSelectIt extends AppStates {}

//Database Data States
class GetDataSuccessful extends AppStates {}

class GetDataError extends AppStates {}

class GettingData extends AppStates {}

//Local Data States
class GettingLocalData extends AppStates {}

class UpdatingLocalData extends AppStates {}

class DeleteLocalData extends AppStates {}

class LocalDataFailed extends AppStates {}

class LocalDataSuccessful extends AppStates {}
