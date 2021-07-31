import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/widgets/appbar_widget.dart';
import 'package:untitled2/widgets/product_cards_widget.dart';

import 'package:untitled2/models/category_response.dart';
import 'package:untitled2/widgets/recommended_deals.dart';

class InCatalogPage extends StatefulWidget{
  InCatalogPage({
    Key key,
    @required this.category, this.updateCarts,
  }) : super(key: key);

  final CategoryModel category;
  final updateCarts;
  @override
  _InCatalogPageState createState() => _InCatalogPageState();
}

class _InCatalogPageState extends State<InCatalogPage>{
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh(){
    return Future.delayed(Duration(milliseconds: 1000)).then((onValue) => null);
  }

  @override
  Widget build(BuildContext context){
    final category = widget.category;
    return Scaffold(
        appBar: CustomAppBar(backButton: true,),
    body: RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView(
        cacheExtent: 999999999999999,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        children:[
          Container(
            padding: EdgeInsets.only(top: 8, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Text(
                          category.name,
                          style: TextStyle(
                            color: MyColors.blueCharcoal,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   child: Text(
                      //     "10 497 товаров",
                      //     style: TextStyle(
                      //       color: MyColors.gunsmoke,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // IconButton(
                //   onPressed: () => {},
                //   icon: Icon(Icons.share_outlined),
                // )
              ],
            ),
          ),
          RecommendedWidget(
              type: "getSubBanners",
              // title: category.name,
              categoryName:category.slug
          ),
          RecommendedWidget(
            type: "category",
            // title: category.name,
            categoryName:category.slug
          ),
          ProductCardsWidget(
            updateCarts: widget.updateCarts,
            title: "Популярные товары",
            perCol: 3,
            type: "getOfAll",
            categorySlug: category.slug,
          ),
          ProductCardsWidget(
            updateCarts: widget.updateCarts,
            title: "Все товары",
            perCol: 3,
            type: "getOfPopular",
            categorySlug: category.slug,
          ),
          Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    ));
  }
}
