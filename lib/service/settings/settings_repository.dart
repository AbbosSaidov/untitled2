import 'package:untitled2/models/settings_response.dart';
import 'package:untitled2/service/settings/settings_api_provider.dart';

class SettingsRepository {
  SettingsApiProvider _provider = SettingsApiProvider();

  Future<SettingsResponseModel> getList() => _provider.getList();
}
