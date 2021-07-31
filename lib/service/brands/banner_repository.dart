import 'package:untitled2/models/brands_response_model.dart';
import 'package:untitled2/service/brands/banner_api_provider.dart';

class BrandsRepository {
  BrandsApiProvider _provider = BrandsApiProvider();

  Future<BrandsResponseModel> getList() => _provider.getList();
}
