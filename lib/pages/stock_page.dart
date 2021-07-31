import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/widgets/appbar_widget.dart';

import 'package:untitled2/widgets/recommended_deals.dart';

class StockPage extends StatefulWidget{
  StockPage({
    Key key,
  }) : super(key: key);


  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage>{
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
              RecommendedWidget(
                type: "getOfAllFeatured",
                title: "Горячие предложения",),

              Padding(padding: EdgeInsets.all(10)),
            ],
          ),
        )
    );
  }
}
