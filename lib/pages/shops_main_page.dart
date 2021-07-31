


import 'package:flutter/material.dart';
import 'package:untitled2/pages/product_filter_page.dart';
import 'package:untitled2/widgets/appbar_widget.dart';
import 'package:untitled2/widgets/product_cards_widget.dart';
import 'package:untitled2/widgets/shop_banners_widget.dart';

class ShopsMainPage extends StatefulWidget{
  ShopsMainPage({Key key, this.slug, this.updateCarts }) : super(key: key);
  final updateCarts;
  final String slug;
  @override
  _ShopsMainPageState createState() => _ShopsMainPageState();
}

class _ShopsMainPageState extends State<ShopsMainPage>{

  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }
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
          cacheExtent: 999999999999999,
          addAutomaticKeepAlives: true,
          children:[
            ShopBannersWidget(type: "fetchBannersMain",slug: widget.slug,),
            SizedBox(
              height: MediaQuery.of(context).size.width/0.65,
              child:DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar:TabBar(
                    tabs: [
                      Tab(text: 'Главная'.toUpperCase()),
                      Tab(text: 'Все товары'.toUpperCase()),
                      Tab(text: 'Популярные'.toUpperCase()),
                    ],
                    labelColor: Colors.black,
                  ),
                  body:SizedBox(
                    height: MediaQuery.of(context).size.width/0.7,
                    child:Container(
                      //padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                      child: TabBarView(
                          children:<Widget>[
                            mainWidget(),
                            ProductFilterPage(
                              updateCarts: widget.updateCarts,
                              typeOpFilter: "seller",
                              categorySlug: widget.slug,
                              isAppbar: false,
                            ),
                            ProductFilterPage(
                              updateCarts: widget.updateCarts,
                              typeOpFilter: "seller",
                              categorySlug: widget.slug,
                              isAppbar: false,
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
          ],
        ),
      ),
    );
  }

  Widget mainWidget(){
    return ListView(
      children:[
        ProductCardsWidget(
          updateCarts: widget.updateCarts,
          categorySlug: widget.slug,
          title:"Популярные товары",
          perCol: 3,
          type: 'getOfShops',
        ),
        ProductCardsWidget(
          updateCarts: widget.updateCarts,
          categorySlug:widget.slug,
          title:"Все товары",
          perCol: 3,
          type: 'getOfAllShops',
        ),
        ]
    );
  }
}
