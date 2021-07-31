library service;

import 'dart:async';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/sliders_response.dart';

class SlidersApiProvider {
  Future<SlidersResponseModel> getList() async {
    final response = await Api.get("${Config.baseUrl}/sliders");

    if (response.isSuccess) {
      try {
        return SlidersResponseModel.fromJson(response.result);
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }
}
