part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoadedState extends SettingsState {
  final SettingsResponseModel res;
  SettingsLoadedState({@required this.res}) : assert(res != null);
}

class SettingsErrorState extends SettingsState {}
