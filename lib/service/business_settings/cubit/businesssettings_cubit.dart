import 'package:bloc/bloc.dart';
import 'package:untitled2/models/business_settings_response.dart';
import 'package:untitled2/service/business_settings/business_settings_repository.dart';
import 'package:meta/meta.dart';

part 'businesssettings_state.dart';

class BusinesssettingsCubit extends Cubit<BusinesssettingsState> {
  final BusinessSettingsRepository repository;
  BusinesssettingsCubit(this.repository) : super(BusinesssettingsInitial());

  Future<void> getList() async {
    try {
      emit(BusinesssettingsInitial());

      final BusinessSettingsResponseModel res = await repository.getList();

      emit(BusinesssettingsLoadedState(res: res));
    } catch (_) {
      emit(BusinessSettingsErrorState());
    }
  }
}
