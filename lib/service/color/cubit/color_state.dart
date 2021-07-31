part of 'color_cubit.dart';

@immutable
abstract class ColorState {}

class ColorInitial extends ColorState {}

class ColorLoadingState extends ColorInitial {}

class ColorLoadedState extends ColorInitial {
  final ColorsResponseModel res;
  ColorLoadedState({@required this.res}) : assert(res != null);
}

class ColorErrorState extends ColorInitial {}
