library service;

import 'dart:async';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/category_response.dart';

class FilterProvider{
  Future<CategoryResponseModel> getSubcategory(String subCategory)async{
    final response = await Api.get("${Config.baseUrl}/sub-categories/$subCategory");
     print("respgetSubcategory="+response.result);
     print("respgetSubcategoryurl="+"${Config.baseUrl}/sub-categories/$subCategory");
    if(response.isSuccess){
      try{
        return CategoryResponseModel.fromJson(response.result);
      }catch(e){
        print("filterError="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future getFilter(String type,String subCategory)async{
    final response = await Api.get("${Config.baseUrl}/filter/all/$type/$subCategory");
    print("getFilter="+response.result);
    if(response.isSuccess){
      try{
        final res=response.result;

        return res;
      }catch(e){
        print("filterError="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<CategoryResponseModel> getAll(String subCategory)async{
    final response = await Api.get("${Config.baseUrl}/filter/all/brand/$subCategory");
     print("respgetSubcategory="+response.result);
     print("respgetSubcategoryurl="+"${Config.baseUrl}/filter/all/brand/$subCategory");
    if(response.isSuccess){
      try{
        return CategoryResponseModel.fromJson(response.result);
      }catch(e){
        print("filterError="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<CategoryResponseModel> getAllShop(String subCategory)async{
    final response = await Api.get("${Config.baseUrl}/shops/products/all/$subCategory");
     print("respgetSubcategory="+response.result);
     print("respgetSubcategoryurl="+"${Config.baseUrl}/shops/products/all/$subCategory");
    if(response.isSuccess){
      try{
        return CategoryResponseModel.fromJson(response.result);
      }catch(e){
        print("filterError="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
}