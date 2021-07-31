part of 'businesssettings_cubit.dart';

@immutable
abstract class BusinesssettingsState {}

class BusinesssettingsInitial extends BusinesssettingsState {}

class BusinesssettingsLoadingState extends BusinesssettingsState {}

class BusinesssettingsLoadedState extends BusinesssettingsState {
  final BusinessSettingsResponseModel res;
  BusinesssettingsLoadedState({@required this.res}) : assert(res != null);
}

class BusinessSettingsErrorState extends BusinesssettingsState {}
