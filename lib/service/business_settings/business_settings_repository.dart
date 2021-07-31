import 'package:untitled2/models/business_settings_response.dart';
import 'package:untitled2/service/business_settings/business_settings_api_provider.dart';

class BusinessSettingsRepository {
  BusinessSettingsApiProvider _provider = BusinessSettingsApiProvider();

  Future<BusinessSettingsResponseModel> getList() => _provider.getList();
}
