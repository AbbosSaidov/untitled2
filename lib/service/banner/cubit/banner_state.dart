part of 'banner_cubit.dart';

@immutable
abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerLoadingState extends BannerState {}

class BannerLoadedState extends BannerState {
  final BannersResponseModel banner;
  BannerLoadedState({@required this.banner}) : assert(banner != null);
}
class BannerMainState extends BannerState {
  final  banner;
  BannerMainState({@required this.banner}) : assert(banner != null);
}

class BannerErrorState extends BannerState {}
