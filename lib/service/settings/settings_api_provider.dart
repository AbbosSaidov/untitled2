library service;

import 'dart:async';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/settings_response.dart';

class SettingsApiProvider {
  Future<SettingsResponseModel> getList() async {
    final response = await Api.get("${Config.baseUrl}/settings");

    if (response.isSuccess) {
      try {
        return SettingsResponseModel.fromJson(response.result);
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }
}
