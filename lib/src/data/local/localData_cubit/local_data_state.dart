part of 'local_data_cubit.dart';

@immutable
abstract class LocalDataState {}

class LocalDataInitial extends LocalDataState {}

//Local Data States
class GettingLocalData extends LocalDataState {}

class UpdatingLocalData extends LocalDataState {}

class DeleteLocalData extends LocalDataState {}

class LocalDataFailed extends LocalDataState {}

class LocalDataSuccessful extends LocalDataState {}
