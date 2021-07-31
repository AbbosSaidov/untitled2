library service;

import 'dart:async';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/brands_response_model.dart';

class BrandsApiProvider {
  Future<BrandsResponseModel> getList() async {
    final response = await Api.get("${Config.baseUrl}/brands");

    if (response.isSuccess) {
      try {
        return BrandsResponseModel.fromJson(response.result);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
