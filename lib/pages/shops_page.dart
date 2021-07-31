import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/widgets/appbar_widget.dart';
import 'package:untitled2/widgets/product_cards_widget.dart';

import 'package:untitled2/models/category_response.dart';
import 'package:untitled2/widgets/recommended_deals.dart';
import 'package:untitled2/widgets/shops_widget.dart';

class ShopsPage extends StatefulWidget{
  ShopsPage({
    Key key,
  }) : super(key: key);


  @override
  _ShopsPageState createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage>{
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh(){
    return Future.delayed(Duration(milliseconds: 1000)).then((onValue) => null);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(backButton: true,),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ShopsWidget(title: "Все магазины",),

            Padding(padding: EdgeInsets.all(10)),
          ],
        ),
      ),
    );

  }
}
