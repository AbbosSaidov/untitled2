import 'package:bloc/bloc.dart';
import 'package:untitled2/models/sliders_response.dart';
import 'package:untitled2/service/sliders/sliders_repository.dart';
import 'package:meta/meta.dart';

part 'sliders_state.dart';

class SlidersCubit extends Cubit<SlidersState> {
  final SlidersRepository repository;
  SlidersCubit(this.repository) : super(SlidersInitial());

  Future<void> fetchBanners() async {
    try {
      emit(SlidersInitial());

      final SlidersResponseModel _bs = await repository.getList();

      emit(SlidersLoadedState(res: _bs));
    } catch (_) {
      emit(SlidersErrorState());
    }
  }
}
