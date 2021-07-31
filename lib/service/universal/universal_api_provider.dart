library service;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';


class UniversalApiProvider {

  Future getById(String slug) async{
    //print("rep=");
    final response = await Api.get("${Config.baseUrl}/get/page?slug=$slug");
    //print("rep="+response.result.toString());

    if (response.isSuccess){
      try{
        //  final res=List<ProductDetailModel>.from(json.decode(response.result)['product'].map((x) => ProductDetailModel.fromMap(x)));
        final res=response.result;

        return res;
      }catch(e){
        print("Errs="+response.isSuccess.toString());
        print("Errs="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
}