import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/const/consts.dart';
import 'package:untitled2/pages/cabine_regis_email_page.dart';
import 'package:untitled2/pages/cabinet_about_app_page.dart';
import 'package:untitled2/pages/cabinet_account_security_page.dart';
import 'package:untitled2/pages/cabinet_costofdelivery.dart';
import 'package:untitled2/pages/cabinet_help_inside_page.dart';
import 'package:untitled2/pages/cabinet_help_page.dart';
import 'package:untitled2/pages/cabinet_orders_page.dart';
import 'package:untitled2/pages/cabinet_purchased_goods_page.dart';
import 'package:untitled2/pages/cart_page_search.dart';
import 'package:untitled2/pages/point_map.dart';
import 'package:untitled2/provider/cabinet_help_provider.dart';
import 'package:provider/provider.dart';

import 'cabinet_help_inside_provider.dart';

class CabinetProvider extends ChangeNotifier {
  openRegistrationScreen(BuildContext context) {
    Navigator.push(
      context,
      CabinetPageRegistrationEmail.route(),
    );
  }

  listItemLocation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartSearch()),
    );
  }

  accountSecurity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountSecurity()),
    );
  }

  aboutApp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutApp()),
    );
  }

  helpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => CabinetHelpProvider(),
              child: CabinetHelpPage())),
    );
  }

  diliveryMethod(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => CabinetHelpInsideProvider(),
              child: CabinetHelpDriverPage(
                list: delivery_methods,
                appbarTitle: 'Способы доставки',
              ))),
    );
  }

  paymentMethod(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => CabinetHelpInsideProvider(),
              child: CabinetHelpDriverPage(
                list: payment_methods,
                appbarTitle: 'Способы оплаты',
              ))),
    );
  }

  purchasedGoods(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PurchasedGoods()),
    );
  }

  orderPages(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CabinetOrderPage()),
    );
  }

  costofDeliry(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CabinetCostOfDelivery()),
    );
  }

  openPointMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PointMap()),
    );
  }
}
