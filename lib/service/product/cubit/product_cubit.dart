import 'package:bloc/bloc.dart';
import 'package:untitled2/models/product_detail_response.dart';
import 'package:untitled2/models/products_response.dart';
import 'package:untitled2/service/product/product_repository.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {

  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  Future<void> getAll(int page) async {
    print("pr1");
    try {
      print("pr2");
      emit(ProductInitial());

      print("pr3");
      final ProductsResponseModel res = await repository.getAll(page);

      emit(ProductLoadedState(list: res));
    } catch (_) {
      emit(ProductErrorState());
    }
  }

  Future<void> getOfAdmin(int page) async {
    try {
      emit(ProductInitial());

      final ProductsResponseModel res = await repository.getOfAdmin(page);

      emit(ProductLoadedState(list: res));
    } catch (_) {
      emit(ProductErrorState());
    }
  }

  Future<void> getOfSeller(int page) async {
    try {
      emit(ProductInitial());

      final ProductsResponseModel res = await repository.getOfSeller(page);

      emit(ProductLoadedState(list: res));
    } catch (_) {
      emit(ProductErrorState());
    }
  }

  Future<void> getOfCategory(String categoryId, int page) async {
    try {
      emit(ProductInitial());

      final ProductsResponseModel res =
          await repository.getOfCategory(categoryId, page);

      emit(ProductLoadedState(list: res));
    } catch (_) {
      emit(ProductErrorState());
    }
  }

  Future<void> getOfSubCategory(int subCategoryId, int page) async {
    try {
      emit(ProductInitial());

      final ProductsResponseModel res =
          await repository.getOfSubCategory(subCategoryId, page);

      emit(ProductLoadedState(list: res));
    } catch (_) {
      emit(ProductErrorState());
    }
  }

  Future<void> getOfBrand(int brandId, int page) async {
    try {
      emit(ProductInitial());

      final ProductsResponseModel res =
          await repository.getOfBrand(brandId, page);

      emit(ProductLoadedState(list: res));
    } catch (_) {
      emit(ProductErrorState());
    }
  }

  Future<void> getOfTodaysDeal()async{
    try{
      emit(ProductInitial());

      final ProductsResponseModel res = await repository.getOfTodaysDeal();

      emit(ProductLoadedState(list: res));
    }catch(_){
      emit(ProductErrorState());
    }
  }

  Future<void> getOfFeatured()async{
    try{
      //print("stateinital1");
      emit(ProductInitial());
      //print("stateinital2");
      final ProductsResponseModel res = await repository.getOfFeatured();
      //print("stateinital3"+res.toJson().toString());
      emit(ProductLoadedState(list: res));
    }catch(e){
      //print("stateinital4="+e.toString());
      emit(ProductErrorState());
    }
  }

  Future<void> getOfFreeFeatured()async{
    try{
     // print("stateinital1");
      emit(ProductInitial());
     // print("stateinital2");
      final ProductsResponseModel res = await repository.getOfFreeFeatured();
    //  print("stateinital8883"+res.toJson().toString());
      emit(ProductLoadedState(list: res));
    }catch(e){
      //print("stateinital4="+e.toString());
      emit(ProductErrorState());
    }
  }
  Future<void> getOfRecomendedAlso(String url)async{
    try{
     // print("stateinital1");
      emit(ProductInitial());
     // print("stateinital2");
      final ProductsResponseModel res = await repository.getOfRecomendedAlso(url);
    //  print("stateinital8883"+res.toJson().toString());
      emit(ProductLoadedState(list: res));
    }catch(e){
      //print("stateinital4="+e.toString());
      emit(ProductErrorState());
    }
  }

  Future<void> getOfAll(String categoryId)async{
    try{
      //print("stateinital1");
      emit(ProductInitial());
      //print("stateinital2");
      final ProductsResponseModel res = await repository.getOfAll(categoryId);
      //print("stateinital3"+res.toJson().toString());
      emit(ProductLoadedState(list: res));
    }catch(e){
      //print("stateinital4="+e.toString());
      emit(ProductErrorState());
    }
  }
  Future<void> getOfShops(String categoryId)async{
    try{
      //print("stateinital1");
      emit(ProductInitial());
      //print("stateinital2");
      final ProductsResponseModel res = await repository.getOfShops(categoryId);
      //print("stateinital3"+res.toJson().toString());
      emit(ProductLoadedState(list: res));
    }catch(e){
      //print("stateinital4="+e.toString());
      emit(ProductErrorState());
    }
  }
  Future<void> getOfAllShops(String categoryId)async{
    try{
      //print("stateinital1");
      emit(ProductInitial());
      //print("stateinital2");
      final ProductsResponseModel res = await repository.getOfAllShops(categoryId);
      //print("stateinital3"+res.toJson().toString());
      emit(ProductLoadedState(list: res));
    }catch(e){
      //print("stateinital4="+e.toString());
      emit(ProductErrorState());
    }
  }

  Future<void> getOfPopular(String categoryId)async{
    try{
     // print("stateinital1");
      emit(ProductInitial());
     // print("stateinital2");
      final ProductsResponseModel res = await repository.getOfPopular(categoryId);
    //  print("stateinital8883"+res.toJson().toString());
      emit(ProductLoadedState(list: res));
    }catch(e){
      //print("stateinital4="+e.toString());
      emit(ProductErrorState());
    }
  }

  Future<void> getSubCategories(String categoryId)async{
    try{
     // print("stateinital1");
      emit(ProductInitial());
     // print("stateinital2");
      final ProductsResponseModel res = await repository.getSubCategories(categoryId);
    //  print("stateinital8883"+res.toJson().toString());
      emit(ProductLoadedState(list: res));
    }catch(e){
      //print("stateinital4="+e.toString());
      emit(ProductErrorState());
    }
  }

  Future<void> getFilterCategories(String categoryId,String typeOfFilter)async{
    try{
     // print("stateinital1");
      emit(ProductInitial());
     // print("stateinital2");
      final ProductsResponseModel res = await repository.getFilterCategories(categoryId,typeOfFilter);
    //  print("stateinital8883"+res.toJson().toString());
      emit(ProductLoadedState(list: res));
    }catch(e){
      //print("stateinital4="+e.toString());
      emit(ProductErrorState());
    }
  }

  Future<void> getOfRelated(int page)async{
    try {
      emit(ProductInitial());

      final ProductsResponseModel res = await repository.getOfRelated(page);

      emit(ProductLoadedState(list: res));
    } catch (_) {
      emit(ProductErrorState());
    }
  }

  Future<void> getOfBestSeller() async {
    try {
      print("type2=");
      emit(ProductInitial());

      final ProductsResponseModel res = await repository.getOfBestSeller();

      emit(ProductLoadedState(list: res));
    } catch (_) {
      emit(ProductErrorState());
    }
  }

  Future<void> getById(String slug) async {
    try {
      emit(ProductInitial());

      final ProductDetailResponse res = await repository.getById(slug);

      emit(ProductDetailLoadedState(response: res));
    } catch (_) {
      emit(ProductErrorState());
    }
  }

}
