import 'package:untitled2/models/product_detail_response.dart';
import 'package:untitled2/models/products_response.dart';
import 'package:untitled2/service/product/product_api_provider.dart';
class ProductRepository{
  ProductApiProvider _pro = ProductApiProvider();
  Future<ProductsResponseModel> getAll(int page) => _pro.getAll(page);
  Future<ProductsResponseModel> getOfAdmin(int page) => _pro.getOfAdmin(page);
  Future<ProductsResponseModel> getOfSeller(int page) => _pro.getOfSeller(page);
  Future<ProductsResponseModel> getOfCategory(String categoryId, int page) => _pro.getOfCategory(categoryId, page);
  Future<ProductsResponseModel> getOfSubCategory(int subCategoryId, int page) => _pro.getOfSubCategory(subCategoryId, page);
  Future<ProductsResponseModel> getOfBrand(int brandId, int page) => _pro.getOfBrand(brandId, page);
  Future<ProductsResponseModel> getOfTodaysDeal() => _pro.getOfTodaysDeal();
  Future<ProductsResponseModel> getOfFeatured() => _pro.getOfFeatured();
  Future<ProductsResponseModel> getOfFreeFeatured() => _pro.getOfFreeFeatured();
  Future<ProductsResponseModel> getOfRecomendedAlso(String url) => _pro.getOfRecomendedAlso(url);
  Future<ProductsResponseModel> getOfAll(String categoryId) => _pro.getOfAll(categoryId);
  Future<ProductsResponseModel> getOfShops(String categoryId) => _pro.getOfShops(categoryId);
  Future<ProductsResponseModel> getOfAllShops(String categoryId) => _pro.getOfAllShops(categoryId);
  Future<ProductsResponseModel> getOfPopular(String categoryId) => _pro.getOfPopular(categoryId);
  Future<ProductsResponseModel> getSubCategories(String categoryId) => _pro.getSubCategories(categoryId);
  Future<ProductsResponseModel> getFilterCategories(String categoryId,String typeOfFilter) => _pro.getFilterCategories(categoryId,typeOfFilter);
  Future<ProductsResponseModel> getOfRelated(int page) => _pro.getOfRelated(page);
  Future<ProductsResponseModel> getOfBestSeller() => _pro.getOfBestSeller();
  Future<ProductDetailResponse> getById(String slug) => _pro.getById(slug);
}
