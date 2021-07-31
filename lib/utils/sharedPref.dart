import 'package:untitled2/models/cart_items_model.dart';
import 'package:untitled2/noomi_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  read()async {
    final prefs = await SharedPreferences.getInstance();

    if(!prefs.containsKey("CartItems")){
      List<CartItem> allCarts=[];
      prefs.setString("CartItems", json.encode(allCarts));
      return allCarts;
      print("not Exist");
    }
    print("pr="+prefs.getString("CartItems"));

    return List<CartItem>.from(json.decode(prefs.getString("CartItems")).map((x) => x!=null ?CartItem.fromJson(x) : null));
    //return prefs.getString("CartItems");
  }

  save(value,updateCarts) async {
    print("saved to carts");
    print("val="+value.slug);
    List<CartItem> allCarts=[];

    final prefs = await SharedPreferences.getInstance();
    //  prefs.clear();

    if(prefs.containsKey("CartItems")){
     //    print("read="+ prefs.getString("CartItems").toString());
      allCarts=NoomiKeys.cartSaves;//List<CartItem>.from(json.decode(prefs.getString("CartItems")).map((x) => CartItem.fromJson(x)));
    }
    bool jh=true;
    for(int i=0;i<allCarts.length;i++){
      if(allCarts[i].slug==value.slug){
        allCarts[i]=value;
        jh=false;
      }
    }
    if(jh){allCarts.add(value);}
    print("leng="+allCarts.length.toString());
    NoomiKeys.cartSaves=allCarts;
    print("leng2="+NoomiKeys.cartSaves.length.toString());
    print(json.encode(allCarts));
    prefs.setString("CartItems", json.encode(allCarts));
    updateCarts();
   // List<CartItem> allCarts2=List<CartItem>.from(await read().map((x) => CartItem.fromJson(x)));
   //  print("val2="+allCarts2[0].slug);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}