import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled2/models/cart_items_model.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/extensions/hex_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache_image_widget.dart';

class CartItemWidget extends StatefulWidget{
  CartItemWidget({Key key, this.cartItem}) : super(key: key);
  final CartItem cartItem;

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget>{
  TextEditingController controller = new TextEditingController();
  bool isChecked = false;
  bool _isFavorite = false;
  bool _istextnumber = false;
  bool _iconvisible = false;
  String _icostalocnumber = "21";
  String number = "0";
  bool _isostaosnumbervisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
           // crossAxisAlignment: CrossAxisAlignment.center,
           // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isChecked
                          ? HexColor("#0757F6")
                          : MyColors.white,
                      border: Border.all(
                        color: isChecked
                            ? HexColor("#0757F6")
                            : MyColors.zumthor,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        isChecked
                            ? Icons.check
                            : Icons.check_box_outline_blank,
                        size: 15,
                        color: MyColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex:1,
                child: Container(),
              ),
              Expanded(
                flex:43,
                  child: CacheImageWidget(
                    height: 110,
                    url: widget.cartItem.image,
                  ),
              ),
              Expanded(
                flex:43,
                  child:  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              Text(
                                widget.cartItem.price.toString(),
                                style: TextStyle(
                                  color: MyColors.hibiscus,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 3),
                                child: Text(
                                  widget.cartItem.price.toString(),
                                  style: TextStyle(
                                    color: MyColors.thunder,
                                    fontSize: 11,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: MyColors.hibiscus,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Text(widget.cartItem.name),
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            child: Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.ripeLemon,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  margin: EdgeInsets.only(left: 10, top: 8),
                  child: Text("Частями по 112 руб / мес"),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: HexColor("#6E3692"),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: EdgeInsets.only(left: 10, top: 8),
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    "Частями",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        })
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 4,
                        ),
                        child: Row(
                          children: [
                            _isFavorite
                                ? Icon(
                                    Icons.favorite,
                                    color: MyColors.red,
                                  )
                                : Stack(children: [
                                    Icon(
                                      Icons.favorite,
                                      color: MyColors.white,
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: MyColors.black,
                                      ),
                                    ),
                                  ]),
                            SizedBox(width: 6),
                            Text("В избранное"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () => {showAlertDialog(context)},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 4,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline),
                            SizedBox(width: 6),
                            Text("Удалить"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                  child: InkWell(
                    onTap: () => {
                      showBottomSheet(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            style: TextStyle(
                                                color: HexColor("#467FD2")),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0),
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
                                            "Осталось" +
                                                _icostalocnumber +
                                                "шт",
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
                      )
                    },
                    child: Row(
                      children: [
                        // number == "0" ? Text("1 шт.") : Text(number + "шт."),
                        Text(widget.cartItem.pieces.toString()+" шт."),
                        SizedBox(width: 5),
                        Icon(Icons.unfold_more)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listItemnumber(Function onTap, String text,
      {IconData icon, primary = false, divider = true}){
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

  showAlertDialog(BuildContext context){
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Отмена"),
      onPressed: () {Navigator.of(context, rootNavigator: true).pop();},
    );
    Widget continueButton = FlatButton(
      child: Text("Удалить"),
      onPressed: () async {
        print("remo1");
        final prefs = await SharedPreferences.getInstance();
        List<CartItem> allCarts=List<CartItem>.from(json.decode(prefs.getString("CartItems")).map((x) => CartItem.fromJson(x)));
        for(int i =0; i<allCarts.length;i++){
          if(allCarts[i].slug==widget.cartItem.slug){
            print("remo2="+allCarts[i].slug);
            allCarts.removeAt(i);
            i=allCarts.length+1;
          }
        }
        prefs.setString("CartItems", json.encode(allCarts));
        setState(() {});
        Navigator.of(context, rootNavigator: true).pop();

        },
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
