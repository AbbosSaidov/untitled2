library service;

import 'dart:async';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/shops_response.dart';

class ShopsApiProvider {
  Future<ShopsResponseModel> getList() async {
    final response = await Api.get("${Config.baseUrl}/shops");

    if (response.isSuccess) {
      try {
        return ShopsResponseModel.fromJson(response.result);
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }
}
