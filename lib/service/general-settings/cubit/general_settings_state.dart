part of 'general_settings_cubit.dart';

@immutable
abstract class GeneralSettingsState {}

class GeneralSettingsInitial extends GeneralSettingsState {}

class GeneralSettingsLoadingState extends GeneralSettingsInitial {}

class GeneralSettingsLoadedState extends GeneralSettingsInitial {
  final GeneralSettingsResponseModel res;
  GeneralSettingsLoadedState({@required this.res}) : assert(res != null);
}

class GeneralSettingsErrorState extends GeneralSettingsInitial {}
