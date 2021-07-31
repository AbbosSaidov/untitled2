import 'package:bloc/bloc.dart';
import 'package:untitled2/models/settings_response.dart';
import 'package:untitled2/service/settings/settings_repository.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository repository;
  SettingsCubit(this.repository) : super(SettingsInitial());

  Future<void> fetchBanners() async {
    try {
      emit(SettingsInitial());

      final SettingsResponseModel _bs = await repository.getList();

      emit(SettingsLoadedState(res: _bs));
    } catch (_) {
      emit(SettingsErrorState());
    }
  }
}
