import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/pages/cart_page_search.dart';

class CartProvider extends ChangeNotifier{

    openSearchScreen(BuildContext context){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartSearch()),
      );
    }


}