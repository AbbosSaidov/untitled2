import 'package:untitled2/models/colors_response.dart';
import 'package:untitled2/service/color/color_api_provider.dart';

class ColorRepository {
  ColorProvider _provider = ColorProvider();

  Future<ColorsResponseModel> getList() => _provider.getList();
}
