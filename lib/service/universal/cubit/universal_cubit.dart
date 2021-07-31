import 'package:meta/meta.dart'
;import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/service/universal/universal_repository.dart';
part 'universal_state.dart';

class UniversalCubit extends Cubit<UniversalState> {

  final UniversalRepository repository;

  UniversalCubit(this.repository) : super(UniversalInitial());
  Future<void> getById(String slug) async {
    try {
      emit(UniversalInitial());

      final  res = await repository.getById(slug);

      emit(UniversalLoadedState(list: res));
    } catch (_) {
      emit(UniversalErrorState());
    }
  }


}