import 'package:untitled2/models/category_response.dart';
import 'package:untitled2/service/filter/filter_api_provider.dart';

class FilterRepository{
  FilterProvider _provider = FilterProvider();
  Future<CategoryResponseModel> getSubCategories(String subCategory)=>_provider.getSubcategory(subCategory);
  Future getFilter(String type,String subCategory)=>_provider.getFilter(type,subCategory);
  Future<CategoryResponseModel> getAll(String subCategory)=>_provider.getAll(subCategory);
  Future<CategoryResponseModel> getAllShop(String subCategory)=>_provider.getAllShop(subCategory);
}