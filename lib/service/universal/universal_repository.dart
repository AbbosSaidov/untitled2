

import 'package:untitled2/service/universal/universal_api_provider.dart';

class UniversalRepository{
  UniversalApiProvider _pro = UniversalApiProvider();
  Future getById(String slug) => _pro.getById(slug);
}