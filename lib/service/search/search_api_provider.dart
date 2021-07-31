library service;

import 'dart:async';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/search_response_model.dart';

class SearchApiProvider {
  Future search(String searchText)async{
    print("Search="+"${Config.baseUrl}/ajax_search?search=$searchText");
    final url = "${Config.baseUrl}/ajax_search?search=$searchText";

    final response = await Api.get(url);
    print("Search="+response.result.toString());
    if (response.isSuccess){
      try{

        //return SearchResponseModel.fromJson(response.result);
        return response.result;
      }catch (e){
        print("errorSearch="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
}
