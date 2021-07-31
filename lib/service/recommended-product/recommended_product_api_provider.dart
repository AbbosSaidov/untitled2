library service;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/category_response.dart';
import 'package:untitled2/models/product_detail_response.dart';
import 'package:untitled2/models/products_response.dart';
import 'package:untitled2/models/recommended_products_model.dart';
import 'package:untitled2/models/sub_categories_model.dart';

class RecommendedProductApiProvider {

  Future<RecommendedProductsResponseModel> getOfFlashDeals()async{
    //print("rep3=");
    final response = await Api.get("${Config.baseUrl}/products/flash-deals");
    //print("reep3="+response.result.toString());
    //print("rep3s="+response.isSuccess.toString());

    if (response.isSuccess){
      try{
       //  print("rep3ss="+response.isSuccess.toString());
       //  log("rep3ss1="+response.result.toString());
        return RecommendedProductsResponseModel.fromJson(response.result);
      }catch(e){
        // print("Err3s="+response.isSuccess.toString());
        //print("Err3s="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<RecommendedProductsResponseModel> getOfFeaturedFlashDeals()async{
    //print("rep3=");
    final response = await Api.get("${Config.baseUrl}/products/featured-flash-deals");
    //print("reep3="+response.result.toString());
    //print("rep3s="+response.isSuccess.toString());

    if (response.isSuccess){

      try{
        // print("rep3ss="+response.isSuccess.toString());
        // log("rep3ss1="+response.result.toString());
        return RecommendedProductsResponseModel.fromJson(response.result);
      }catch(e){
         print("Err3s="+response.isSuccess.toString());
        print("Err3s="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<CategoryResponseModel> getOfSubCategories(String categoryId,)async{
    //print("rep7="+categoryId.toString());
  //  print("rep7ssd=${Config.baseUrl}/category/sub-categories/$categoryId");
    final url = "${Config.baseUrl}/category/sub-categories/$categoryId";
    final response = await Api.get(url);
   // print("rep7s="+response.result.toString());

    if (response.isSuccess) {
      try {
        return CategoryResponseModel.fromJson(response.result);
      } catch (e) {
        print("Err7s="+response.isSuccess.toString());
        print("Err7s="+e.toString());
        return null;
      }
    } else {
      return null;
    }
  }
  Future<CategoryResponseModel> getOfPopularCategories()async{
    //  print("rep7="+categoryId.toString());
    //  print("rep7ssd=${Config.baseUrl}/category/sub-categories/$categoryId");
    final url = "${Config.baseUrl}/categories/featured";
    final response = await Api.get(url);
    //  print("rep7s="+response.result.toString());
    if (response.isSuccess){
      try{
        return CategoryResponseModel.fromJson(response.result);
      }catch (e){
        print("Err7s="+response.isSuccess.toString());
        print("Err7s="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<SubCategoriesModel> getOfSubBanners(String categoryId,)async{
    //print("rep7="+categoryId.toString());
    print("rep7ssd=${Config.baseUrl}/category/sub-categories/$categoryId");
    final url = "${Config.baseUrl}/sub-categories/$categoryId";
    final response = await Api.get(url);
    print("rep7s="+response.result.toString());

    if(response.isSuccess){
      try{
        return SubCategoriesModel.fromJson(response.result);
      }catch(e){
        // log("Err7s="+response.isSuccess.toString());
        log("Err7s="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }

}
