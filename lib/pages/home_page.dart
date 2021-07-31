import 'package:flutter/material.dart';
import 'package:untitled2/pages/shops_page.dart';
import 'package:untitled2/widgets/appbar_widget.dart';
import 'package:untitled2/widgets/bottom_navigation_bar.dart';
import 'package:untitled2/widgets/popular_categories.dart';
import 'package:untitled2/widgets/product_cards_widget.dart';
import 'package:untitled2/widgets/recommended_deals.dart';
import 'package:untitled2/widgets/shop_banners_widget.dart';
import 'package:untitled2/widgets/horizontal_banners_widget.dart';
import 'package:untitled2/widgets/shops_widget.dart';
import 'package:untitled2/widgets/square_banners_widget.dart';
import 'package:untitled2/service/category/category_api_provider.dart';
import 'package:untitled2/widgets/catalog_widgets.dart';

class HomePage extends StatefulWidget{
  HomePage({Key key, this.updateCarts }) : super(key: key);

  final updateCarts;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final categoryRepository = CategoryRepository();

  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState(){
    super.initState();
  }

  Future<Null> _refresh(){
    return Future.delayed(Duration(milliseconds: 1000)).then((onValue) => null);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(backButton: false,),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView(
          physics: BouncingScrollPhysics(),
          cacheExtent: 999999999999999,
          addAutomaticKeepAlives: true,
          children:[
            ShopBannersWidget(type: "fetchBanners",),
            CatalogWidget(),
            HorizontalBannersWidget(),
            ProductCardsWidget(
              updateCarts: widget.updateCarts,
              title: "Новые поступления",
              categorySlug: "list",
              perCol: 3,
              //type: 'getOfTodaysDeal',
              type: 'new-products',
            ),
            ProductCardsWidget(
              updateCarts: widget.updateCarts,
              categorySlug: "list",
              title:"Популярные товары",
              perCol: 3,
              //type: 'getOfBestSeller',
              type: 'featured',
            ),
            ProductCardsWidget(
              categorySlug: "list",
              updateCarts: widget.updateCarts,
              title: "Рекомендуемые товары",
              perCol: 3,
             // type: "getOfFeatured",
              type: "best-seller",
            ),
            //  ProductCardsWidget(
            //    title: "Популярные категории",
            //    perCol: 3,
            //    type: "getOfCategory",
            //  ),
            // SquareBannersWidget(title: "Это выгодно! Успей купить!"),
            // ProductCardsWidget(
            //   title: "Рекомендуемые предложения",
            //   perCol: 3,
            //   type: "getOfFlashDeals",
            // ),
            RecommendedWidget(
              type: "flashdeals",
              title: "Горячие предложения",),
            HorizontalBannersWidget(),
            RecommendedWidget(
              type: "flashdeals",
              title: "Популярные предложения",),
            ShopsWidget(title: "Все магазины",),
            ProductCardsWidget(
              categorySlug: "list",
              updateCarts: widget.updateCarts,
              title: "Бесплатная доставка",
              perCol: 3,
              type: "getOfFreeFeatured",
            ),
            HorizontalBannersWidget(),
            RecommendedWidget(
              title: "Популярные категории",
              type: "category1",
                // title: category.name,
            ),
           // PopularCategoriesWidget(title: "Популярные категории",),
            Padding(padding: EdgeInsets.all(10)),
          ],
        ),
      ),
    );
  }
}
