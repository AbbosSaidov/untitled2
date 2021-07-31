import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/extensions/hex_color.dart';

class CabinetOrderPage extends StatefulWidget {
  @override
  _CabinetOrderPageState createState() => _CabinetOrderPageState();
}

class _CabinetOrderPageState extends State<CabinetOrderPage> {
  bool isChecked = false;
  bool _istextnumber = false;
  bool _iconvisible = false;
  String _icostalocnumber = "21";
  String number = "0";
  bool _isostaosnumbervisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Заказы",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              bottomSheetDialog();
            },
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Все",
                      style: TextStyle(color: MyColors.customBlue),
                    ),
                    Icon(Icons.unfold_more),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Divider(height: 1),
          ),
          Container(color: Colors.white, height: 10),
          Expanded(
            child: Container(
              color: Color.fromRGBO(242, 243, 245, 1),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'У вас нет заказов',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Начните с главной - может, найдется\nчто-то вам по вкусу :)'),
                  SizedBox(height: 10),
                  FlatButton(
                    onPressed: () => {},
                    child: Text(
                      'Начать покупки',
                      style: TextStyle(color: MyColors.customBlue),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bottomSheetDialog() {
    return showBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // height: 600,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Выберите количество",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () => {},
                        child: Text(
                          "Закрыть",
                          style: TextStyle(color: HexColor("#467FD2")),
                        ),
                      )
                    ],
                  ),
                ),
                _listItemnumber(
                    () => {
                          _istextnumber = false,
                          _iconvisible = true,
                          _isostaosnumbervisible = true,
                          number = "1",
                          setState(() {})
                        },
                    "1"),
                _listItemnumber(
                    () => {
                          _istextnumber = false,
                          _iconvisible = true,
                          _isostaosnumbervisible = true,
                          number = "2",
                          setState(() {})
                        },
                    "2"),
                _listItemnumber(
                    () => {
                          _istextnumber = false,
                          _iconvisible = true,
                          _isostaosnumbervisible = true,
                          number = "3",
                          setState(() {})
                        },
                    "3"),
                _listItemnumber(
                    () => {
                          _istextnumber = false,
                          _iconvisible = true,
                          _isostaosnumbervisible = true,
                          number = "4",
                          setState(() {})
                        },
                    "4"),
                _listItemnumber(
                    () => {
                          _istextnumber = false,
                          _iconvisible = true,
                          _isostaosnumbervisible = true,
                          number = "5",
                          setState(() {})
                        },
                    "5"),
                _listItemnumber(
                    () => {
                          _istextnumber = false,
                          _iconvisible = true,
                          _isostaosnumbervisible = true,
                          number = "6",
                          setState(() {})
                        },
                    "6"),
                _listItemnumber(
                    () => {
                          _istextnumber = false,
                          _iconvisible = true,
                          _isostaosnumbervisible = true,
                          number = "7",
                          setState(() {})
                        },
                    "7"),
                _listItemnumber(
                    () => {
                          _istextnumber = false,
                          _iconvisible = true,
                          _isostaosnumbervisible = true,
                          number = "8",
                          setState(() {})
                        },
                    "8"),
                _listItemnumber(
                    () => {
                          _istextnumber = false,
                          _iconvisible = true,
                          _isostaosnumbervisible = true,
                          number = "9",
                          setState(() {})
                        },
                    "9"),
                _listItemnumber(
                    () => {
                          _istextnumber = true,
                          _iconvisible = true,
                          _isostaosnumbervisible = true,
                          number = "10+",
                          setState(() {})
                        },
                    "10+",
                    divider: false),
                Visibility(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelText: "Количество товаров",
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
                  visible: _istextnumber,
                ),
                Visibility(
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(width: 150),
                        Text(
                          "Осталось" + _icostalocnumber + "шт",
                        )
                      ],
                    ),
                  ),
                  visible: _isostaosnumbervisible,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listItemnumber(Function onTap, String text,
      {IconData icon, primary = false, divider = true}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 18),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      icon != null
                          ? Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(
                                icon,
                                color: primary
                                    ? MyColors.mariner
                                    : MyColors.blackBean,
                                size: 34,
                              ),
                            )
                          : Container(),
                      Container(
                        padding: EdgeInsets.only(left: icon != null ? 12 : 0),
                        child: Text(
                          text,
                          style: TextStyle(
                            color:
                                primary ? MyColors.mariner : MyColors.blackBean,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.check,
                        color: HexColor("#467FD2"),
                        size: 18,
                      ),
                    ),
                    visible: _iconvisible,
                  )
                ],
              ),
            ),
            divider ? Divider(height: 1) : Container()
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Отмена"),
      onPressed: () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Удалить"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Удаление товара"),
      content: Text(
          "Вы точно хотите удалить новар? Отменить действие будет невозможною"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
