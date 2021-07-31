import 'package:untitled2/models/sliders_response.dart';
import 'package:untitled2/service/sliders/sliders_api_provider.dart';

class SlidersRepository {
  SlidersApiProvider _provider = SlidersApiProvider();

  Future<SlidersResponseModel> getList() => _provider.getList();
}
