import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/const/consts.dart';
import 'package:untitled2/pages/cabinet_help_inside_page.dart';
import 'package:untitled2/provider/cabinet_help_inside_provider.dart';
import 'package:provider/provider.dart';

class CabinetHelpProvider extends ChangeNotifier {
  void cabinetHelpOpenScreen(BuildContext context, int index) {
    List<String> list;
    switch (index) {
      case 0:
        list = help_driver;
        break;
      case 1:
        list = help_edit_order;
        break;
      case 2:
        list = help_payment;
        break;
      case 3:
        list = help_something_wrong;
        break;
      case 4:
        list = help_not_get_order;
        break;
      case 5:
        list = list = kredit_ashop;
        break;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => CabinetHelpInsideProvider(),
          child: CabinetHelpDriverPage(
            list: list,
            appbarTitle: help[index],
          ),
        ),
      ),
    );
  }
}
