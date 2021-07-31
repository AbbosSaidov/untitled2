import 'package:untitled2/models/category_response.dart';

class CategoryRepository {
  CategoryRepository ps = CategoryRepository();

  Future<CategoryResponseModel> getAll() => ps.getAll();
  Future<CategoryResponseModel> getTop() => ps.getTop();
  Future<CategoryResponseModel> getHomecategories() => ps.getHomecategories();
  Future<CategoryResponseModel> getSubCategories(int id) =>
      ps.getSubCategories(id);
}
