

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/pages/cabinet_help_last_page.dart';

class CabinetHelpInsideProvider extends ChangeNotifier {

  void openScreen(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CabinetHelpLastPage()),
    );
  }

}