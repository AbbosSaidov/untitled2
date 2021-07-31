library service;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/product_detail_response.dart';
import 'package:untitled2/models/products_response.dart';

class ProductApiProvider {
  Future<ProductsResponseModel> getAll(int page)async{
    //print("rep10=$page");
    final response = await Api.get("${Config.baseUrl}/products?page=$page");
    //print("rep10="+response.result.toString());

    if (response.isSuccess){
      try {
        return ProductsResponseModel.fromJson(response.result);
      } catch (e) {
        print("Err10s="+response.isSuccess.toString());
        print("Err10s="+e.toString());
        return null;
      }
    } else {
      return null;
    }
  }
  Future<ProductsResponseModel> getOfAdmin(int page) async {
    //print("rep9=");
    final response =
        await Api.get("${Config.baseUrl}/products/admin?page=$page");
    //print("rep9="+response.result.toString());

    if (response.isSuccess) {
      try {
        return ProductsResponseModel.fromJson(response.result);
      } catch (e) {
        print("Err9s="+response.isSuccess.toString());
        print("Err9s="+e.toString());
        return null;
      }
    } else {
      return null;
    }
  }
  Future<ProductsResponseModel> getOfSeller(int page) async {
    //print("rep8=");
    final response =
        await Api.get("${Config.baseUrl}/products/seller?page=$page");
    //print("rep8="+response.result.toString());

    if (response.isSuccess) {
      try {
        return ProductsResponseModel.fromJson(response.result);
      } catch (e) {
        print("Err8s="+response.isSuccess.toString());
        print("Err8s="+e.toString());
        return null;
      }
    } else {
      return null;
    }
  }
  Future<ProductsResponseModel> getOfCategory(String categoryId, int page) async {
 //  print("rep7="+categoryId.toString());
 //  print("rep7ssd=${Config.baseUrl}/category/sub-categories/$categoryId");
 //  final url = "${Config.baseUrl}/category/sub-categories/$categoryId";
 //  final response = await Api.get(url);
 //  print("rep7s="+response.result.toString());

 //  if (response.isSuccess) {
 //    try {
 //      return ProductsResponseModel.fromJson(response.result);
 //    } catch (e) {
 //      print("Err7s="+response.isSuccess.toString());
 //      print("Err7s="+e.toString());
 //      return null;
 //    }
 //  } else {
 //    return null;
 //  }
  }
  Future<ProductsResponseModel> getOfSubCategory(int subCategoryId, int page) async {
    //print("rep6=");
    final response = await Api.get(
        "${Config.baseUrl}/products/sub-catego$subCategoryId?page=$page");
    //print("rep6="+response.result.toString());

    if (response.isSuccess) {
      try {
        return ProductsResponseModel.fromJson(response.result);
      } catch (e) {
        print("Err6s="+response.isSuccess.toString());
        print("Err6s="+e.toString());
        return null;
      }
    } else {
      return null;
    }
  }
  Future<ProductsResponseModel> getOfBrand(int brandId, int page) async {
    //print("rep5=");
    final response =
        await Api.get("${Config.baseUrl}/products/brand$brandId?page=$page");
    //print("rep5="+response.result.toString());

    if (response.isSuccess) {
      try {
        return ProductsResponseModel.fromJson(response.result);
      } catch (e) {
        print("Err5s="+response.isSuccess.toString());
        print("Err5s="+e.toString());
        return null;
      }
    } else {
      return null;
    }
  }
  Future<ProductsResponseModel> getOfTodaysDeal() async {
    //print("rep4=");
    final response = await Api.get("${Config.baseUrl}/products/new-products");
    //print("rep4="+response.result.toString());

    if (response.isSuccess) {
      try {
        print("rep4s=");
        return ProductsResponseModel.fromJson(response.result);
      } catch (e) {
        print("rep4sEr="+e.toString());
        return null;
      }
    } else {
      return null;
    }
  }
  Future<ProductsResponseModel> getOfFeatured()async{
    //print("rep3=");
    final response = await Api.get("${Config.baseUrl}/products/best-seller");
    //print("reep3="+response.result.toString());
    //print("rep3s="+response.isSuccess.toString());

    if(response.isSuccess){
      try{
        // print("rep3ss="+response.isSuccess.toString());
        // log("rep3ss1="+response.result.toString());
        return ProductsResponseModel.fromJson(response.result);
      }catch(e){
       // print("Err3s="+response.isSuccess.toString());
       //print("Err3s="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<ProductsResponseModel> getOfFreeFeatured()async{

    final response = await Api.get("${Config.baseUrl}/free/shipping/products");

    if (response.isSuccess){
      try{
     //  print("rep3ss="+response.isSuccess.toString());
     //  log("rep3ss1="+response.result.toString());
     //    final res=List<ProductModel>.from(json.decode(response.result)['products']['data'].map((x) => ProductModel.fromMap(x)));
     //   return ProductsResponseModel(
     //     data: res,
     //     success: true,
     //     status:200,
     //   );
     //  return res;
         return ProductsResponseModel.fromJson(
             response.result
         );
      }catch(e){
        print("Err3s="+response.isSuccess.toString());
        print("Err3s="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<ProductsResponseModel> getOfRecomendedAlso(String url)async{

    final response = await Api.get(url);


    if (response.isSuccess){
      try{
       //  print("rep3ss="+response.isSuccess.toString());
         //log("rep3ss1="+json.decode(response.result)['products'].toString());
        return ProductsResponseModel.fromJson(
            response.result
        );
      //  return res;
      }catch(e){

        return null;
      }
    }else{
      return null;
    }
  }
  Future<ProductsResponseModel> getOfAll(String categoryId)async{
    print("rep3ss="+categoryId.toString());
    final response = await Api.get("${Config.baseUrl}/products/category/$categoryId");
    if (response.isSuccess){
      try{
         //print("rep3ss="+response.isSuccess.toString());
         //log("rep3ss1="+json.decode(response.result)['products'].toString());
      //   final res=List<ProductModel>.from(json.decode(response.result)['products']['data'].map((x) => ProductModel.fromMap(x)));
        return ProductsResponseModel.fromJson(
          response.result
        );
      //  return res;
      }catch(e){
        print("Err3s="+response.isSuccess.toString());
        print("Err3s="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<ProductsResponseModel> getOfShops(String categoryId)async{
   // print("getOfShops="+"${Config.baseUrl}/shops/products/featured/$categoryId");
    final response = await Api.get("${Config.baseUrl}/shops/products/featured/$categoryId");
    if (response.isSuccess){
      try{
      //log("rep3ss1="+json.decode(response.result)['products'].toString());
      //   final res=List<ProductModel>.from(json.decode(response.result)['products']['data'].map((x) => ProductModel.fromMap(x)));
        return ProductsResponseModel.fromJson(
          response.result
        );
      //  return res;
      }catch(e){
        print("Err3s="+response.isSuccess.toString());
        print("Err3s="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<ProductsResponseModel> getOfAllShops(String categoryId)async{
    print("getOfAllShops="+"${Config.baseUrl}/shops/products/featured/$categoryId");
    final response = await Api.get("${Config.baseUrl}/shops/products/all/$categoryId");
    if (response.isSuccess){
      try{
      log("getOfAllShops2="+json.decode(response.result)['products'].toString());
      //   final res=List<ProductModel>.from(json.decode(response.result)['products']['data'].map((x) => ProductModel.fromMap(x)));
        final res=List<ProductModel>.from(json.decode(response.result)['products']['data'].map((x) => ProductModel.fromMap(x)));
        return ProductsResponseModel(
          data: res,
          success: true,
          status:200,
        );
      //  return res;
      }catch(e){
        print("Err3s="+response.isSuccess.toString());
        print("Err3s="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<ProductsResponseModel> getSubCategories(String categoryId)async{
   // print("reasdasd="+"${Config.baseUrl}/products/featured/category/$categoryId");
    final response = await Api.get("${Config.baseUrl}/products/featured/category/$categoryId");
    if (response.isSuccess){
      try{
      //print("rep3ss="+response.isSuccess.toString());
      //  log("getSubCategories="+response.result);
      //   final res=List<ProductModel>.from(json.decode(response.result)['products']['data'].map((x) => ProductModel.fromMap(x)));
        return ProductsResponseModel.fromJson(
          response.result
        );
      //  return res;
      }catch(e){
        print("ErrgetSubCategoriess="+response.isSuccess.toString());
        print("ErgetSubCategoriess="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<ProductsResponseModel> getFilterCategories(String categoryId,String typeOfFilter)async{
    print("reasdasd="+"${Config.baseUrl}/filter/all/$typeOfFilter/$categoryId");
    final response = await Api.get("${Config.baseUrl}/filter/all/$typeOfFilter/$categoryId");
    if (response.isSuccess){
      try{
         //print("rep3ss="+response.isSuccess.toString());
      //  log("getSubCategories="+response.result);
        final res=List<ProductModel>.from(json.decode(response.result)['products']['data'].map((x) => ProductModel.fromMap(x)));
        return ProductsResponseModel(
          data: res,
          success: true,
          status:200,
        );
      //  return res;
      }catch(e){
        print("ErrgetSubCategoriess="+response.isSuccess.toString());
        print("ErgetSubCategoriess="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<ProductsResponseModel> getOfPopular(String categoryId)async{

    final response = await Api.get("${Config.baseUrl}/products/category/$categoryId");

    if (response.isSuccess){
      try{
        // print("rep33ss="+response.isSuccess.toString());
         //log("rep33ss1="+response.result);
        return ProductsResponseModel.fromJson(
            response.result
        );
      //  return res;
      }catch(e){
        print("Err33s="+response.isSuccess.toString());
        print("Err33s="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<ProductsResponseModel> getOfRelated(int page) async {
    //print("rep2=");
    final response = await Api.get("${Config.baseUrl}/products/related/$page");
    //print("rep2="+response.result.toString());

    if (response.isSuccess) {
      try {
        //print("rep2s="+response.result.toString());
        return ProductsResponseModel.fromJson(response.result);
      }catch(e){
        print("ERRrep2="+e.toString());

        return null;
      }
    }else{
      return null;
    }
  }
  Future<ProductsResponseModel> getOfBestSeller() async {
    //print("rep1="+"${Config.baseUrl}/products/best-seller");
    final response = await Api.get("${Config.baseUrl}/products/featured");
    //print("rep1="+response.result.toString());
    if (response.isSuccess){
      try {
        return ProductsResponseModel.fromJson(response.result);
      }catch (e){
        print("Err1s="+response.isSuccess.toString());
        print("Err1s="+e.toString());
        return null;
      }
    }else{
      return null;
    }
  }
  Future<ProductDetailResponse> getById(String slug) async{
    //print("rep=");
    final response = await Api.get("${Config.baseUrl}/products/detail/$slug");
    //print("rep="+response.result.toString());

    if (response.isSuccess){
      try{
        print("getById="+response.isSuccess.toString());
        print("getById="+json.decode(response.result)['product'].toString());
        //  final res=List<ProductDetailModel>.from(json.decode(response.result)['product'].map((x) => ProductDetailModel.fromMap(x)));
        final res=response.result;

        return ProductDetailResponse(
          data: ProductDetailModel.fromMap(json.decode(res)['product']),
          success: true,
          status:200,
        );
        return ProductDetailResponse.fromJson(response.result);
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
