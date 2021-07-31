import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled2/models/message_response.dart';
import 'package:untitled2/models/wishlist_request.dart';
import 'package:untitled2/service/wishlist/wishlist_repository.dart';
import 'package:meta/meta.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepository repository;
  WishlistCubit(this.repository) : super(WishlistInitial());

   Future<void> getAll(int id) async {
     try {
       emit(WishlistInitial());

       final List<WishlistModel> res = await repository.getList(id);

       emit(WishlistLoadedState(list: res));
     } catch (_) {
       emit(WishlistErrorState());
     }
   }

  Future<void> save(WishlistModel param) async {
    try {
      emit(WishlistInitial());

      final MessageResponse res = await repository.save(param);

      emit(WishlistEndState(res: res));
    } catch (_) {
      emit(WishlistErrorState());
    }
  }

  Future<void> delete(int id) async {
    try {
      emit(WishlistInitial());

      final MessageResponse res = await repository.delete(id);

      emit(WishlistEndState(res: res));
    } catch (_) {
      emit(WishlistErrorState());
    }
  }
}
