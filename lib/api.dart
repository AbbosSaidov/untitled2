library api;

import 'dart:convert';
import 'dart:io';

import 'package:untitled2/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static Future<HttpResult> post(url, data) async {
    try {
      final dynamic headers = await _getReqHeader();
      var res = await http.post(Uri.parse(url), body: data, headers: headers);
      return _result(res);
    } catch (_) {
      return _result({});
    }
  }
  static Future<HttpResult> put(url, data) async {
    try {
      final dynamic headers = await _getReqHeader();
      var res = await http.put(Uri.parse(url), body: data, headers: headers);
      return _result(res);
    } catch (_) {
      return _result({});
    }
  }

  static Future<HttpResult> delete(url) async {
    try {
      final dynamic headers = await _getReqHeader();
      var  res = await http.delete(Uri.parse(url), headers: headers);
      return _result(res);
    } catch (_) {
      return _result({});
    }
  }

  static Future<HttpResult> get(url)async{
    try{
    //  print("re="+Uri.parse(url).toString());
    //   final dynamic headers = await _getReqHeader();
    //   print("Dres1="+headers.toString());
    //  // http.Response res = await http.get(url/*, headers: headers*/);
    //   http.Response res = await http.get(Uri.parse(url), headers: headers);
    //  print("Dres2="+res.body.toString());
      final response = await http.get(
        Uri.parse(url),
        // Send authorization headers to the backend.
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImEzZTU3NmM1MjYxMTFkYWM5NGI1MDhlOTU3MDhmMzNkYjZkYTU0ZTM3MDdlNThkMGFhZjdkYmMyYzlhMTQ0MzEwNzExNWViZjdmM2IzMzdiIn0.eyJhdWQiOiI3IiwianRpIjoiYTNlNTc2YzUyNjExMWRhYzk0YjUwOGU5NTcwOGYzM2RiNmRhNTRlMzcwN2U1OGQwYWFmN2RiYzJjOWExNDQzMTA3MTE1ZWJmN2YzYjMzN2IiLCJpYXQiOjE2MjQzOTgzOTAsIm5iZiI6MTYyNDM5ODM5MCwiZXhwIjoxNjU1OTM0MzkwLCJzdWIiOiI5Iiwic2NvcGVzIjpbXX0.hWg6F-34-REW3i8fwNiHWkBQWdnTk2H5AN4-0TdXwHzXLyYgmV3ydS4ModClRqtaM6s_5dV84xD7YxMvh1enQ2VYq2FZaqa5hOZvCNiRrbzBJsT9PTAzgwbQzbnKWnYNvvjF8YUmvWaAbc8M7zc96n8v2TWpt5HDjp_ROeH9EskTUvKNvFunqljyobJ0oTqj-yq0nKAHpPRewXqQRU0uzDYi-KICPeNZ7q74R8IWVwEnbeSQZe2GbTfrsk4sdiKEN7Gt6EY5RnCq1bsf1iv2qPOwZ253JSNtVdjB8fzOC9hOzR7vZNMu0b-6r5MokjZPVxP9XT7D14gfhHmvSeNXFn1sFzVyLvy2o5LQ9qa4A4beHMhxR-psPk3Wg2YJSI_HAJnhRr8sAe8yNrn0yYvpD0F0F4G2Zl9jQ79HlQSvrKiQBkE-tUVpeGZYOwC5KsFvpllwpCRPd9fTQRXHCBfGfm0jEeZ9mI7G9dheH2OdsDqvW3XnjyfBdkJIad5q9ls2XNEFJ0404pzpRRRNetvihqcELUAquf8UzRXdHnigwqCIuSmCwzXg9WPRCQK3DlNLePP20KmzRaXk5Q8_lyOX5G8ycBc6QWEwUgev03ZtKn5bNALFze_5fqNy461w_o9Um_Duw-lOaef8c1RV6lJnLGJ2zR9RHD-bqM6L1Ork1HU',
        },
      );
      //print("Dres2="+response.body.toString());
      return _result(response);
    }catch(e){
      print("Dres3="+e.toString());

      return _result({});
    }
  }

  static HttpResult _result(response){
    dynamic result;
    int status = response.statusCode ?? 404;

    if(response.statusCode >= 200 && response.statusCode <= 299){
      result = response.body;
      return HttpResult(true, result, status,result);
    }else{
      return HttpResult(false, "", status,result);
    }
  }

  static _getReqHeader()async{
    final prefs = await SharedPreferences.getInstance();
    final String tokenString = prefs.getString('token');
    String token="";
    if (tokenString != null){
      var userData = LoginResponseModel.fromJson(json.decode(tokenString));
      token = "bearer " + userData.accessToken.toString();
    }else{
      token = "bearer " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImEzZTU3NmM1Mj"
          "YxMTFkYWM5NGI1MDhlOTU3MDhmMzNkYjZkYTU0ZTM3MDdlNThkMGFhZjdkYmMyYzlhMTQ0"
          "MzEwNzExNWViZjdmM2IzMzdiIn0.eyJhdWQiOiI3IiwianRpIjoiYTNlNTc2YzUyNjExMWRhYzk0Y"
          "jUwOGU5NTcwOGYzM2RiNmRhNTRlMzcwN2U1OGQwYWFmN2RiYzJjOWExNDQzMTA3MTE1ZWJmN2YzYjMzN2Ii"
          "LCJpYXQiOjE2MjQzOTgzOTAsIm5iZiI6MTYyNDM5ODM5MCwiZXhwIjoxNjU1OTM0MzkwLCJzdWIiOiI5Iiwic2NvcGVz"
          "IjpbXX0.hWg6F-34-REW3i8fwNiHWkBQWdnTk2H5AN4-0TdXwHzXLyYgmV3ydS4ModClRqtaM6s_5dV84xD7YxMvh1e"
          "nQ2VYq2FZaqa5hOZvCNiRrbzBJsT9PTAzgwbQzbnKWnYNvvjF8YUmvWaAbc8M7zc96n8v2TWpt5HDjp_ROeH9EskTUvKNv"
          "FunqljyobJ0oTqj-yq0nKAHpPRewXqQRU0uzDYi-KICPeNZ7q74R8IWVwEnbeSQZe2GbTfrsk4sdiKEN7Gt6EY5RnCq1bs"
          "f1iv2qPOwZ253JSNtVdjB8fzOC9hOzR7vZNMu0b-6r5MokjZPVxP9XT7D14gfhHmvSeNXFn1sFzVyLvy2o5LQ9qa4A4beHMh"
          "xR-psPk3Wg2YJSI_HAJnhRr8sAe8yNrn0yYvpD0F0F4G2Zl9jQ79HlQSvrKiQBkE-tUVpeGZYOwC5KsFvpllwpCRPd9fTQRXH"
          "CBfGfm0jEeZ9mI7G9dheH2OdsDqvW3XnjyfBdkJIad5q9ls2XNEFJ0404pzpRRRNetvihqcELUAquf8UzRXdHnigwqCIuSmCwz"
          "Xg9WPRCQK3DlNLePP20KmzRaXk5Q8_lyOX5G8ycBc6QWEwUgev03ZtKn5bNALFze_5fqNy461w_o9Um_Duw-lOaef8c1RV6lJn"
          "LGJ2zR9RHD-bqM6L1Ork1HU";
    }
    final Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": token.toString()
    };
    return headers;
  }
}

class HttpResult {
  final bool isSuccess;
  final int status;
  final String result;
  final  body;

  HttpResult(this.isSuccess, this.result, this.status, this.body);
}
