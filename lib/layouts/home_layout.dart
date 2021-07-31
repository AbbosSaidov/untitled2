import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/models/cart_items_model.dart';
import 'package:untitled2/pages/brand_page.dart';
import 'package:untitled2/pages/in_catalog_page.dart';
import 'package:untitled2/pages/product_filter_page.dart';
import 'package:untitled2/pages/product_page.dart';
import 'package:untitled2/pages/shops_main_page.dart';
import 'package:untitled2/pages/shops_page.dart';
import 'package:untitled2/pages/stock_page.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/pages/cabinet_page.dart';
import 'package:untitled2/pages/cart_page.dart';
import 'package:untitled2/pages/catalog_page.dart';
import 'package:untitled2/pages/favorite_page.dart';
import 'package:untitled2/pages/home_page.dart';
import 'package:untitled2/provider/cabinet_provider.dart';
import 'package:untitled2/provider/cart_provider.dart';
import 'package:untitled2/utils/sharedPref.dart';
import 'package:provider/provider.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../noomi_keys.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>{
  final _navigatorKey = NoomiKeys.navKey;

  String resultText = "";
  SharedPref prefs=SharedPref();
  List<CartItem> cartItem;
  int _curentIndex = 0;
  int _curentIndexForBottom = 0;
  int _curentCartNumbers = 0;

  @override
  void initState(){
    _changeSysBar();
    getCarts().then((value){

    });
    super.initState();
  }
  Future<void> getCarts()async{
    cartItem= await prefs.read();
    NoomiKeys.cartSaves=cartItem;
    if(cartItem.length>0){
      _curentCartNumbers=cartItem.length;
      print(cartItem.length);
    }else{
      _curentCartNumbers=0;
      print("null");
    }
    setState(() {
    });
    //  super.initState();
  }
  @override
  void dispose(){
    super.dispose();
  }
  void _changeSysBar(){
    Color color = _curentIndex > 1 ? MyColors.white : MyColors.bigStone;
    FlutterStatusbarcolor.setStatusBarColor(color).then(
      (value){
        bool isWhite = useWhiteForeground(color);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(isWhite);
      },
    );
  }
  void _updateCarts(){
    print("updated");
    print("leng3="+NoomiKeys.cartSaves.length.toString());
    _curentCartNumbers=NoomiKeys.cartSaves.length;
    setState(() {});
  }
  // _speechTotext() {
  //   print(_isAvailable.toString() + ' ' + _isListening.toString());
  //   if (_isListening)
  //     _speechRecognition.stop().then(
  //           (result) => setState(() {
  //             _isListening = result;
  //             resultText = "";
  //           }),
  //         );
  //   if (_isAvailable && !_isListening) {
  //     _speechRecognition.listen(locale: "ru_RU").then((result) {
  //       setState(() {
  //         resultText = result;
  //         print(resultText + " ok Google");
  //       });
  //     });
  //   } else {}
  // }
  @override
  Widget build(BuildContext context){
    return Scaffold(
     backgroundColor: MyColors.white,
     /*appBar: AppBar(
        toolbarHeight: _curentIndex > 1 ? 0 : 56,
        titleSpacing: 0,
        elevation: _curentIndex > 2 ? 0 : 1,
        backgroundColor: _curentIndex > 1 ? MyColors.white : MyColors.bigStone,
        title: Container(
          height: 42,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(),
              ),
              // Container(
              //   width: 40,
              //   margin: EdgeInsets.only(left: 7, right: 8),
              //   child: InkWell(
              //     borderRadius: BorderRadius.circular(50),
              //     onTap: () => {
              //       // Get.toNamed("/search")
              //     },
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
              //       child: Text(""),
              //       // Text(
              //       //   "anti virus".toUpperCase(),
              //       //   style: TextStyle(color: MyColors.white, fontSize: 9),
              //       //   overflow: TextOverflow.ellipsis,
              //       //   maxLines: 2,
              //       //   softWrap: false,
              //       //   textAlign: TextAlign.center,
              //       // ),
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 92,
                child: InkWell(
                  onTap: () => {Get.toNamed("/search")},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: MyColors.white,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => {Get.toNamed("/search")},
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          icon: Icon(Icons.search, color: Colors.black45),
                        ),
                        Expanded(
                          child: Text(
                            "Искать...",
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                        // SizedBox(
                        //   width: 35,
                        //   child: IconButton(
                        //     padding: EdgeInsets.all(0),
                        //     onPressed: () => {
                        //       _speechTotext(),
                        //     },
                        //     icon: Icon(
                        //       Icons.mic_none_outlined,
                        //       color: MyColors.bigStone,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 35,
                        //   child: IconButton(
                        //     padding: EdgeInsets.all(0),
                        //     onPressed: () => {},
                        //     icon: Icon(
                        //       Icons.camera_alt_outlined,
                        //       color: MyColors.bigStone,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(width: 10)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(),
              ),
            ],
          ),
        ),
      ),*/
     body: Navigator(
        key: _navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings){
          switch (settings.name){
            case '/':
              return MaterialPageRoute(
                builder: (BuildContext context) => HomePage(updateCarts: _updateCarts,),
                settings: settings,
              );
            case '/catalog':
              return MaterialPageRoute(
                builder: (BuildContext context) => CatalogPage(updateCarts: _updateCarts,),
                settings: settings,
              );
            case '/cart':
              return MaterialPageRoute(
                builder: (BuildContext context) => ChangeNotifierProvider(
                  create: (context) => CartProvider(),
                  child: CartPage(updateCarts: _updateCarts,),
                ),
                settings: settings,
              );
            case '/fovarite':
              return MaterialPageRoute(
                    builder: (context) =>  FavoritePage(),
                settings: settings,
              );
            case '/cabinet':
              return MaterialPageRoute(
                builder: (BuildContext context) => ChangeNotifierProvider(
                    create: (context) => CabinetProvider(),
                    child: CabinetPage()),
                settings: settings,
              );
             case '/shops':
                _curentIndex=5;
                return  MaterialPageRoute(
                  builder: (context) => ShopsPage(),
                  settings: settings,
                );
                case '/shopsCat':
                _curentIndex=6;
                return  MaterialPageRoute(
                  builder: (context) => InCatalogPage(
                    updateCarts: _updateCarts,
                          category: NoomiKeys.categoryModel,),
                  settings: settings,
                );
                case '/stocks':
                _curentIndex=7;
                return  MaterialPageRoute(
                  builder: (context) => StockPage(),
                  settings: settings,
                );
                case '/brands':
                _curentIndex=8;
                return  MaterialPageRoute(
                  builder: (context) => BrandPage(),
                  settings: settings,
                );
                case '/product':
                _curentIndex=9;
                return  MaterialPageRoute(
                  builder: (context) => ProductPage(productSlug: NoomiKeys.productSlug,updateCarts: _updateCarts,),
                  settings: settings,
                );
                case '/FilterPage':
                _curentIndex=10;
                return  MaterialPageRoute(
                  builder: (context) => ProductFilterPage(
                    updateCarts: _updateCarts,
                    categorySlug:NoomiKeys.categorySlug,
                    typeOpFilter: NoomiKeys.typeOpFilter,
                  ),
                  settings: settings,
                );
                case '/shopsWidget':
                _curentIndex=11;
                return  MaterialPageRoute(
                  builder: (context) => ShopsMainPage(
                    slug:NoomiKeys.categorySlug,
                  ),
                  settings: settings,
                );

            default:
              return null;
          }
        },
      ),
     bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyColors.customBlue,
        selectedIconTheme: IconThemeData(size: 26),
        unselectedItemColor: MyColors.dustyGray,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        currentIndex: _curentIndexForBottom,
        onTap: (index){
          if (index == _curentIndex) return;

          String page = '';

          switch (index){
            case 1:
              page = 'catalog';
              break;
            case 2:
              page = 'cart';
              break;
            case 3:
              page = 'favourite';
              break;
            case 4:
              page = 'cabinet';
              break;
          }
          _navigatorKey.currentState.pushNamed("/$page");
          setState((){
            _curentIndex = index;
            _curentIndexForBottom = index;
            _changeSysBar();
          });
        },
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Главная",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers_outlined),
            label: "Каталог",
          ),
          BottomNavigationBarItem(
            icon: _curentCartNumbers==0 ? Icon(Icons.shopping_cart_outlined) : Badge(
              badgeContent: Text(_curentCartNumbers.toString(),style: TextStyle(color: Colors.white),),
              child: Icon(Icons.shopping_cart_outlined),
            ),
            label: "Корзина",
          ),
          BottomNavigationBarItem(
            icon: Badge(
              badgeContent: Text('2',style: TextStyle(color: Colors.white),),
              child: Icon(Icons.favorite_outline),
            ),
            label: "Избранное",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Кабинет",
          ),
        ],
      ),
    );
  }
}
