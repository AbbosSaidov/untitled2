import 'package:bloc/bloc.dart';
import 'package:untitled2/models/shops_response.dart';
import 'package:untitled2/service/shops/shops_repository.dart';
import 'package:meta/meta.dart';

part 'shops_state.dart';

class ShopsCubit extends Cubit<ShopsState> {
  final ShopsRepository repository;
  ShopsCubit(this.repository) : super(ShopsInitial());

  Future<void> fetchBanners() async{
    try {
      emit(ShopsInitial());

      final ShopsResponseModel _bs = await repository.getList();

      if(_bs==null){
        emit(ShopsErrorState());
      }else{
        emit(ShopsLoadedState(res: _bs));
      }

    } catch (e) {
      print("shopError"+e.toString());
      emit(ShopsErrorState());
    }
  }
}
