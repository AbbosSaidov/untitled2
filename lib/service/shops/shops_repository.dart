import 'package:untitled2/models/shops_response.dart';
import 'package:untitled2/service/shops/shops_api_provider.dart';

class ShopsRepository {
  ShopsApiProvider _provider = ShopsApiProvider();

  Future<ShopsResponseModel> getList() => _provider.getList();
}
