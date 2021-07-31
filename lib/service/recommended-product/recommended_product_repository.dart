import 'package:untitled2/models/category_response.dart';
import 'package:untitled2/models/product_detail_response.dart';
import 'package:untitled2/models/products_response.dart';
import 'package:untitled2/models/recommended_products_model.dart';
import 'package:untitled2/models/sub_categories_model.dart';
import 'package:untitled2/service/recommended-product/recommended_product_api_provider.dart';

class RecommendedProductRepository {
  RecommendedProductApiProvider _pro = RecommendedProductApiProvider();

  Future<RecommendedProductsResponseModel> getOfFlashDeals() => _pro.getOfFlashDeals();
  Future<RecommendedProductsResponseModel> getOfFeaturedFlashDeals() => _pro.getOfFeaturedFlashDeals();
  Future<CategoryResponseModel> getOfSubCategories(String categoryId,) => _pro.getOfSubCategories(categoryId);
  Future<CategoryResponseModel> getOfPopularCategories() => _pro.getOfPopularCategories();
  Future<SubCategoriesModel> getOfSubBanners(String categoryId,) => _pro.getOfSubBanners(categoryId);

}
