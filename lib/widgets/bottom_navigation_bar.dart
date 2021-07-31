import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/noomi_keys.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class CustomBottomNavigationBar extends StatefulWidget implements PreferredSizeWidget {
  CustomBottomNavigationBar({Key key, this.isThisSamePage=false}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0
  final bool isThisSamePage; // default is 56.0

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>{
int index=0;
final navigatorKey = NoomiKeys.navKey;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex:index,
      onTap: (index1){
          if (index1==index && widget.isThisSamePage) return;
        String page = '';
        switch (index1){
          case 1:
            page = 'catalog';
            break;
          case 2:
            page = 'cart';
            break;
          case 3:
            page = 'fovarite';
            break;
          case 4:
            page = 'cabinet';
            break;
        }
        navigatorKey.currentState.pushNamed("/$page");
        setState((){
          index = index1;
          _changeSysBar();
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Главная",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.layers_outlined),
          label: "Каталог",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: "Корзина",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: "Избранное",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Кабинет",
        ),
      ],
    );
  }

  void _changeSysBar(){
    Color color = index > 1 ? MyColors.white : MyColors.bigStone;
    FlutterStatusbarcolor.setStatusBarColor(color).then(
          (value){
        bool isWhite = useWhiteForeground(color);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(isWhite);
      },
    );
  }
}