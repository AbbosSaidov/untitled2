part of 'wishlist_cubit.dart';

@immutable
abstract class WishlistState extends Equatable{

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoadingState extends WishlistState {}

class WishlistLoadedState extends WishlistState {
  final List<WishlistModel> list;
  WishlistLoadedState({@required this.list}) : assert(list != null);
}

class WishlistEndState extends WishlistState {
  final MessageResponse res;
  WishlistEndState({@required this.res}) : assert(res != null);
}

class WishlistErrorState extends WishlistState {}
