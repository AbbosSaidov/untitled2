import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/widgets/appbar_widget.dart';
import 'package:untitled2/widgets/brand_widget.dart';
import 'package:untitled2/widgets/product_cards_widget.dart';

import 'package:untitled2/models/category_response.dart';
import 'package:untitled2/widgets/recommended_deals.dart';
import 'package:untitled2/widgets/shops_widget.dart';

class BrandPage extends StatefulWidget{
  BrandPage({
    Key key,
  }) : super(key: key);


  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage>{
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh(){
    return Future.delayed(Duration(milliseconds: 1000)).then((onValue) => null);
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
        appBar: CustomAppBar(backButton: true,),
        body:RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 19,right: 19,top: 19),
                child: Text("Бренды",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),),
              ),
              BrandsWidget(type: "getOfAllBrands"),

              Padding(padding: EdgeInsets.all(10)),
            ],
          ),
        ));
  }
}
