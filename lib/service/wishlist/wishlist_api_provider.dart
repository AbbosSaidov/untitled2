library service;

import 'dart:async';
import 'dart:convert';
import 'package:untitled2/api.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/message_response.dart';
import 'package:untitled2/models/wishlist_request.dart';
import 'package:http/http.dart' as http;
//bjhffff
class WishlistApiProvider {
  Future<List<WishlistModel>> getList(int id) async {
    // final response = await Api.get("${Config.baseUrl}/wishlists/$id");
    final response = await Api.get("${Config.baseUrl}/wishlists/"+id.toString());
    print("rep8="+response.result.toString());
    if (response.isSuccess){
      try {
        List<WishlistModel> wishlistModel=List<WishlistModel>.from(
            json.decode(response.result)['data'].map((x) => x!=null ?WishlistModel.fromMap(x) : null));

      //  List<WishlistModel> wishlistModel = wishlistModelFromJson(response.body);
        return wishlistModel;
      }catch(e){
        print("reperror="+e.toString());
        return null;
      }
     }else {
      return null;
    }
  }

  Future<MessageResponse> save(WishlistModel param) async {
    final response = await Api.post("${Config.baseUrl}/wishlists", param);

    if (response.isSuccess) {
      try {
        return MessageResponse.fromJson(response.result);
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<MessageResponse> delete(int id) async {
    final response = await Api.delete("${Config.baseUrl}/wishlists/$id");

    if (response.isSuccess) {
      try {
        return MessageResponse.fromJson(response.result);
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }
}
