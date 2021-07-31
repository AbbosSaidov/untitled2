import 'package:bloc/bloc.dart';
import 'package:untitled2/models/category_response.dart';
import 'package:untitled2/models/product_detail_response.dart';
import 'package:untitled2/models/products_response.dart';
import 'package:untitled2/models/recommended_products_model.dart';
import 'package:untitled2/models/sub_categories_model.dart';
import 'package:untitled2/service/product/product_repository.dart';
import 'package:meta/meta.dart';

import '../recommended_product_repository.dart';

part 'recommended_product_state.dart';

class RecommendedProductCubit extends Cubit<RecommendedProductState>{
  final RecommendedProductRepository repository;
  RecommendedProductCubit(this.repository) : super(RecommendedProductInitial());

  Future<void> getAll()async{
    try{
      emit(RecommendedProductInitial());

      final RecommendedProductsResponseModel res = await repository.getOfFlashDeals();

      emit(RecommendedProductLoadedState(list: res));
    }catch(_){
      emit(RecommendedProductErrorState());
    }
  }
  Future<void> getAllFeatured()async{
    try{
      emit(RecommendedProductInitial());

      final RecommendedProductsResponseModel res = await repository.getOfFeaturedFlashDeals();

      emit(RecommendedProductLoadedState(list: res));
    }catch(_){
      emit(RecommendedProductErrorState());
    }
  }
  Future<void> getAllSubCategories(String categoryId)async{
    try {
      emit(RecommendedProductInitial());

      final CategoryResponseModel res = await repository.getOfSubCategories(categoryId);

      emit(SubCategoriesLoadedState(categories: res));
    }catch (_) {
      emit(RecommendedProductErrorState());
    }
  }
  Future<void> getOfPopularCategories()async{
    try {
      emit(RecommendedProductInitial());

      final CategoryResponseModel res = await repository.getOfPopularCategories();

      emit(SubCategoriesLoadedState(categories: res));
    }catch (_) {
      emit(RecommendedProductErrorState());
    }
  }
  Future<void> getSubBanner(String categoryId)async{
    try {
      emit(RecommendedProductInitial());

      final SubCategoriesModel res = await repository.getOfSubBanners(categoryId);

      emit(SubBannerLoadedState(subCategories: res));
    }catch(_){
      emit(RecommendedProductErrorState());
    }
  }
}
