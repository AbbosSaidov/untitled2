part of 'recommended_product_cubit.dart';

@immutable
abstract class RecommendedProductState {}

class RecommendedProductInitial extends RecommendedProductState {}

class RecommendedProductLoadingState extends RecommendedProductState {}

class RecommendedProductLoadedState extends RecommendedProductState {
  final RecommendedProductsResponseModel list;
  RecommendedProductLoadedState({@required this.list}) : assert(list != null);
}
class SubCategoriesLoadedState extends RecommendedProductState {
  final CategoryResponseModel categories;
  SubCategoriesLoadedState({@required this.categories}) : assert(categories != null);
}
class SubBannerLoadedState extends RecommendedProductState {
  final SubCategoriesModel subCategories;
  SubBannerLoadedState({@required this.subCategories}) : assert(subCategories != null);
}


class RecommendedProductErrorState extends RecommendedProductState {}