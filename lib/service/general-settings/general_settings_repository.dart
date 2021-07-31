import 'package:untitled2/models/general_settings_response.dart';
import 'package:untitled2/service/general-settings/general_settings_api_provider.dart';

class GeneralSettingsRepository {
  GeneralSettingsProvider _provider = GeneralSettingsProvider();

  Future<GeneralSettingsResponseModel> getList() => _provider.getList();
}
