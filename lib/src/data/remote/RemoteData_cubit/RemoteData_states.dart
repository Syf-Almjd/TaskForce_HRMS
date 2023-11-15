part of 'RemoteData_cubit.dart';

class RemoteAppStates {}

//add abstract and check what happenns

// UI States
class InitialAppState extends RemoteAppStates {}

class StartLoadingState extends RemoteAppStates {}

class StopLoadingState extends RemoteAppStates {}

class SelectIt extends RemoteAppStates {}

class UnSelectIt extends RemoteAppStates {}

//Database Data States
class GetDataSuccessful extends RemoteAppStates {}

class GetDataError extends RemoteAppStates {}

class GettingData extends RemoteAppStates {}
