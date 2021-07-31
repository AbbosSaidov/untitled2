part of 'sliders_cubit.dart';

@immutable
abstract class SlidersState {}

class SlidersInitial extends SlidersState {}

class SlidersLoadedState extends SlidersInitial {
  final SlidersResponseModel res;
  SlidersLoadedState({@required this.res}) : assert(res != null);
}

class SlidersErrorState extends SlidersInitial {}
