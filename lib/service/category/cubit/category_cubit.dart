import 'package:bloc/bloc.dart';
import 'package:untitled2/models/category_response.dart';
import 'package:untitled2/service/category/category_api_provider.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository repository;
  CategoryCubit(this.repository) : super(CategoryInitial());

  Future<void> getAll() async {
    try {
      emit(CategoryInitial());

      final CategoryResponseModel res = await repository.getAll();
      emit(CategoryLoadedState(list: res));
    } catch (_) {
      emit(CategoryErrorState());
    }
  }
  Future<void> getPopularCategories() async {
    try {
      emit(CategoryInitial());

      final CategoryResponseModel res = await repository.getPopularCategories();
      emit(CategoryLoadedState(list: res));
    } catch (_) {
      emit(CategoryErrorState());
    }
  }

  Future<void> getTop() async {
    try {
      emit(CategoryInitial());

      final CategoryResponseModel res = await repository.getTop();

      emit(CategoryLoadedState(list: res));
    } catch (_) {
      emit(CategoryErrorState());
    }
  }

  Future<void> getHomeCategories() async {
    try {
      emit(CategoryInitial());

      final CategoryResponseModel res = await repository.getHomeCategories();

      emit(CategoryLoadedState(list: res));
    } catch (_) {
      emit(CategoryErrorState());
    }
  }

  Future<void> getSubCategories(int id) async {
    try {
      emit(CategoryInitial());

      final CategoryResponseModel res = await repository.getSubCategories(id);

      emit(CategoryLoadedState(list: res));
    } catch (_) {
      emit(CategoryErrorState());
    }
  }
}
