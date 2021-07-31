import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled2/models/search_response_model.dart';
import 'package:untitled2/service/search/search_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repository;
  SearchCubit(this.repository) : super(SearchInitial());

  Future<void> search(String text) async {
    try {
      emit(SearchInitial());

      final res = await repository.search(text);

      emit(SearchLoadedState(res: res));
    } catch (_) {
      emit(SearchErrorState());
    }
  }

  void clear() {
    emit(SearchInitial());
  }
}
