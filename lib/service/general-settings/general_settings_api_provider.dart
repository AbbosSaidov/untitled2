library service;

import 'dart:async';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/general_settings_response.dart';

class GeneralSettingsProvider {
  Future<GeneralSettingsResponseModel> getList() async {
    final response = await Api.get("${Config.baseUrl}/general-settings");

    if (response.isSuccess) {
      try {
        return GeneralSettingsResponseModel.fromJson(response.result);
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }
}
