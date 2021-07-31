import 'package:flutter/widgets.dart';
import 'package:untitled2/models/category_response.dart';

import 'models/cart_items_model.dart';
class NoomiKeys {
  static final navKey = new GlobalKey<NavigatorState>();
  static CategoryModel categoryModel = new CategoryModel();
  static String productSlug= "";
  static List<CartItem> cartSaves = [];
  static String categorySlug="";
  static String typeOpFilter="";

}