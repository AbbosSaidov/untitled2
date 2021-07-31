library service;

import 'dart:async';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/colors_response.dart';

class ColorProvider {
  Future<ColorsResponseModel> getList() async {
    final response = await Api.get("${Config.baseUrl}/colors");

    if (response.isSuccess) {
      try {
        return ColorsResponseModel.fromJson(response.result);
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }
}
