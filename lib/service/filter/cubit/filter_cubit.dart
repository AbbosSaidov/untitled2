import 'package:bloc/bloc.dart';
import 'package:untitled2/models/category_response.dart';
import 'package:untitled2/service/filter/filter_repository.dart';
import 'package:meta/meta.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState>{
  final FilterRepository repository;
  FilterCubit(this.repository) : super(FilterInitial());

  Future<void> getSubCategories(String subCategory) async {
    try{
      emit(FilterInitial());

      final CategoryResponseModel res = await repository.getSubCategories(subCategory);

      emit(FilterLoadedState(res: res));
    }catch(e){
      emit(FilterErrorState());
    }
  }
  Future<void> getFilter(String type,String subCategory) async {
    try{
      emit(FilterInitial());

      final res = await repository.getFilter(type,subCategory);

      emit(FilterLoadedMainState(res: res));
    }catch(e){
      emit(FilterErrorState());
    }
  }
  Future<void> getAllShop(String subCategory) async {
    try{
      emit(FilterInitial());

      final CategoryResponseModel res = await repository.getAllShop(subCategory);

      emit(FilterLoadedState(res: res));
    }catch(e){
      emit(FilterErrorState());
    }
  }
  Future<void> getAll(String subCategory) async {
    try{
      emit(FilterInitial());

      final CategoryResponseModel res = await repository.getAll(subCategory);

      emit(FilterLoadedState(res: res));
    }catch(e){
      emit(FilterErrorState());
    }
  }

}