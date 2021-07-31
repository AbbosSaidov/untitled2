import 'package:untitled2/models/search_response_model.dart';
import 'package:untitled2/service/search/search_api_provider.dart';

class SearchRepository {
  SearchApiProvider _pro = SearchApiProvider();

  Future search(String text) => _pro.search(text);
}
