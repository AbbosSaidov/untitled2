part of 'brands_cubit.dart';

@immutable
abstract class BrandsState {}

class BrandsInitial extends BrandsState {}

class BrandLoadingState extends BrandsState {}

class BrandLoadedState extends BrandsState {
  final BrandsResponseModel list;
  BrandLoadedState({@required this.list}) : assert(list != null);
}

class BrandErrorState extends BrandsState {}
