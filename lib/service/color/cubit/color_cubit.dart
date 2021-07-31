import 'package:bloc/bloc.dart';
import 'package:untitled2/models/colors_response.dart';
import 'package:untitled2/service/color/color_repository.dart';
import 'package:meta/meta.dart';

part 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  final ColorRepository repository;
  ColorCubit(this.repository) : super(ColorInitial());

  Future<void> getAll() async {
    try {
      emit(ColorInitial());

      final ColorsResponseModel res = await repository.getList();

      emit(ColorLoadedState(res: res));
    } catch (_) {
      emit(ColorErrorState());
    }
  }
}
