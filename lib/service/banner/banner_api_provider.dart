library service;

import 'dart:async';
import 'dart:convert';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/banners_response_model.dart';

class BannerApiProvider{
  Future<BannersResponseModel> getBanners() async {
    //  print("res1=");
    final response = await Api.get("${Config.baseUrl}/banners");
 //   print("Dresssssssssss="+response.result.toString());

    if(response.isSuccess){
      try{
        print("There was no erro for banners");
        return BannersResponseModel.fromJson(response.result);
      }catch (e){
        print("There was an erro for banners="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future getBannersMain(String slug) async {
    final response = await Api.get("${Config.baseUrl}/shops/details/"+slug);
    print("Dres="+response.result.toString());
    print("Dresqw="+json.decode(response.body)['data'].toString());

    if(response.isSuccess){
      try{
        print("There was no erro for banners");
        return json.decode(response.body);
      }catch (e){
        print("There was an erro for banners");
        return null;
      }
    }else{
      return null;
    }
  }
}
