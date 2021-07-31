library service;

import 'dart:async';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/business_settings_response.dart';

class BusinessSettingsApiProvider {
  Future<BusinessSettingsResponseModel> getList() async {
    final response = await Api.get("${Config.baseUrl}/business-settings");

    if (response.isSuccess) {
      try {
        return BusinessSettingsResponseModel.fromJson(response.result);
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }
}
