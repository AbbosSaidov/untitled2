part of 'shops_cubit.dart';

@immutable
abstract class ShopsState {}

class ShopsInitial extends ShopsState {}

class ShopsLoadingState extends ShopsState {}

class ShopsLoadedState extends ShopsState {
  final ShopsResponseModel res;
  ShopsLoadedState({@required this.res}) : assert(res != null);
}

class ShopsErrorState extends ShopsState {}
