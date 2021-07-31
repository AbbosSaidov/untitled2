import 'package:untitled2/models/banners_response_model.dart';
import 'package:untitled2/service/banner/banner_api_provider.dart';

class BannersRepository {
  BannerApiProvider _provider = BannerApiProvider();

  Future<BannersResponseModel> getAllBanners() => _provider.getBanners();
  Future getBannersMain(String slug) => _provider.getBannersMain(slug);
}
