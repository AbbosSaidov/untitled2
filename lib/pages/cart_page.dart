import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled2/models/cart_items_model.dart';
import 'package:untitled2/models/product_detail_response.dart';
import 'package:untitled2/noomi_keys.dart';
import 'package:untitled2/service/product/product_api_provider.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/extensions/hex_color.dart';
import 'package:untitled2/utils/sharedPref.dart';
import 'package:untitled2/widgets/cache_image_widget.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key, this.updateCarts}) : super(key: key);
  final updateCarts;
  @override
  _CartPageState createState() => _CartPageState();
}
class _CartPageState extends State<CartPage>{
  bool isChecked = true;
  bool isLoaded = false;
  SharedPref prefs=SharedPref();
  List<CartItem> cartItem;

  TextEditingController controller = new TextEditingController();
  bool isChecked2 = false;
  bool _isFavorite = false;
  bool _istextnumber = false;
  bool _iconvisible = false;
  String _icostalocnumber = "21";
  String number = "0";
  bool _isostaosnumbervisible = false;
  int _currentIntValue = 10;
  ProductApiProvider _pro = ProductApiProvider();
  @override
  void initState(){
    getCarts().then((value){
      isLoaded=true;
      setState(() {});
    });
    super.initState();
  }

  Future<void> getCarts()async{
    cartItem= await prefs.read();
    if(cartItem.length>0){
      for(int i =0;i<cartItem.length;i++){
        ProductDetailResponse gh= await _pro.getById(cartItem[i].slug);
        cartItem[i].image=gh.data.photos[0].toString();
        cartItem[i].name=gh.data.name;
        cartItem[i].isWishlist=false;
        cartItem[i].price=gh.data.priceLower;
      }
      isLoaded=true;
      print(cartItem[0].slug);
    }else{
      print("null");
    }
    //  super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Корзина"),
        backgroundColor: MyColors.customBlue,
        automaticallyImplyLeading: false,
      ),
      body: isLoaded ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
       /*   Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 0, 0),
            child: Container(
              child: Text(
                "Корзина",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),*/
          Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Container(
              color: MyColors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => {print("pressed")},
                    child: Row(
                      children: [
                        InkWell(
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
                                  ? MyColors.customBlue
                                  : MyColors.white,
                              border: Border.all(
                                color: isChecked
                                    ? MyColors.customBlue
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
                        SizedBox(width: 10),
                        Text("Выбрать все"),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => {},
                    child: Text(
                      "Удалить выбранные",
                      style: TextStyle(color: MyColors.red),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
               /*  Container(
                    color: Color.fromRGBO(242, 243, 245, 1),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                          child: InkWell(
                            onTap: () {
                              myProvider.openSearchScreen(context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8.0),
                                Text(
                                  "Населенний пункт",
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 12.0),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Москва",
                                      style: TextStyle(
                                          color: HexColor("#0757F6"),
                                          fontSize: 14.0),
                                    ),
                                    Icon(
                                      Icons.unfold_more,
                                      size: 16.0,
                                      color: Colors.black,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Divider(height: 1),
                        ),
                        SizedBox(height: 30.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                "Доставка",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.train_outlined,
                                  color: Colors.black,
                                ),
                                Text("Курьром"),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black,
                                ),
                                Text("Курьром"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                      ],
                    ),
                  ),*/
        // Shimmer.fromColors(
                  // baseColor: MyColors.shimmerBaseColor,
                  // highlightColor: MyColors.shimmerHighlightColor,
                  // child:
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cartItem.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                      //    color: Color.fromRGBO(242, 243, 245, 1),
                          height: 8.0,
                        ),
                    itemBuilder: (context, index) => cartItemWidget(cartItem[index],),
                  ),
                  // ),
                  Container(
                    //color: Color.fromRGBO(242, 243, 245, 1),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        children: [
                          SizedBox(height: 15.0),
                          Text(
                            "Ваша корзина",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Количества товаров",
                                style: TextStyle(
                                  color: Colors.black,),
                              ),
                              Text(
                                "3 шт.",
                                style: TextStyle(color: Colors.black45),
                              )
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Стоимость товаров",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "5 565 000 сум",
                                style: TextStyle(color: Colors.black45),
                              )
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Стоимость доставки",
                                style: TextStyle(
                                  color: Colors.black,),
                              ),
                              Text(
                                "105 000 сум",
                                style: TextStyle(color: Colors.black45),
                              )
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Сумма скидок",
                                style: TextStyle(
                                  color: Colors.black,),
                              ),
                              Text(
                                "- 20 000 сум",
                                style: TextStyle(color: Colors.black45),
                              )
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Сумма балов",
                                style: TextStyle(
                                  color: Colors.black,),
                              ),
                              Text(
                                "- 60 000 сум",
                                style: TextStyle(color: Colors.black45),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Divider(height: 1.0),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Общая стоимость",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "23 748 P",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: MyColors.customBlue,
                              onPressed: () => null,
                              child: Text(
                                "Перейти к оформлению",
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: MyColors.red,
                              onPressed: () => null,
                              child: Text(
                                "Оформить в рассрочку",
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "Онлайн оформление рассрочки - решение за 10 минут. Вы можете выбрать"
                                " срок рассрочки самостоятельно. Способы и время доставки вы можете выбрать "
                                "при выборе адреса доставки",
                            style: TextStyle(color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 8.0, 0, 0),
                    child: Container(
                      child: Text(
                        "Вы смотрели",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ):Center(child: CircularProgressIndicator(),),
    );
  }

  Widget cartItemWidget(CartItem cartItem1){
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                  child: InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        Icon(Icons.store_mall_directory_outlined),
                        SizedBox(width: 5),
                        // number == "0" ? Text("1 шт.") : Text(number + "шт."),
                        Text("Elmakon"),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
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
                          //  SizedBox(width: 6),
                          //  Text("В избранное"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () => {showAlertDialog(cartItem1)},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 4,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline),
                       //     SizedBox(width: 6),
                       //     Text("Удалить"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                      isChecked2 = !isChecked2;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isChecked2
                          ? MyColors.customBlue
                          : MyColors.white,
                      border: Border.all(
                        color: isChecked2
                            ? MyColors.customBlue
                            : MyColors.zumthor,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        isChecked2
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
                flex:32,
                child: CacheImageWidget(
                  height: 110,
                  url: cartItem1.image,
                ),
              ),
              Expanded(
                flex:1,
                child: Container(),
              ),
              Expanded(
                  flex:54,
                  child:  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(cartItem1.name),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Цена: ",
                                  style: TextStyle(
                                    color: MyColors.customBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      NumberFormat("#,##0 сум", "en_US").format(cartItem1.price),
                                      //NumberFormat.currency(locale: 'eu',symbol: "сум").format(cartItem1.price),
                                      style: TextStyle(
                                        color: MyColors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 3),
                                      child: Text(
                                        NumberFormat("#,##0 сум", "en_US").format(cartItem1.price),
                                        // NumberFormat.currency(locale: 'eu',symbol: "сум").format(cartItem1.price),
                                        style: TextStyle(
                                          color: MyColors.thunder,
                                          fontSize: 11,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: MyColors.hibiscus,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )  ,

                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex:4,
                                    child:Text(
                                      "Рассрочка: ",
                                      style: TextStyle(
                                        color: MyColors.customBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex:6,
                                    child:Text(
                                      "210 000 сум / мес",
                                      style: TextStyle(
                                        color: MyColors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              )  ,

                            ],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline_outlined,size: 33,),
                              onPressed: () => setState(() {
                                final newValue = _currentIntValue - 1;
                                _currentIntValue = newValue.clamp(0, 100);
                              }),
                            ),
                            Text('$_currentIntValue'),
                            IconButton(
                              icon: Icon(Icons.add_box_outlined,size: 33,),
                              onPressed: () => setState(() {
                                final newValue = _currentIntValue + 1;
                                _currentIntValue = newValue.clamp(0, 100);
                              }),
                            ),
                          ],
                        ),
                  /*      Container(
                       //  decoration: BoxDecoration(
                       //    color: MyColors.ripeLemon,
                       //    borderRadius: BorderRadius.circular(5),
                       //  ),
                          padding: EdgeInsets.symmetric(
                           // horizontal: 8,
                            vertical: 4,
                          ),
                          child: Text("Частями по 112 руб / мес",style: TextStyle(color: MyColors.red),),
                        ),*/
                      ],
                    ),
                  )
              ),
            ],
          ),
    /*     Container(
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
          ),*/
    Divider(height: 1),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ожидаемая доставка",
                style: TextStyle(
                    color: Colors.black,),
              ),
              Text(
                "1-день",
                style: TextStyle(color: Colors.black45),
              )
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Стоимость доставки",
                style: TextStyle(
                    color: Colors.black,
                   ),
              ),
              Text(
                "35 000 сум",
                style: TextStyle(color: Colors.black45),
              )
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Скидка 10%",
                style: TextStyle(
                    color: Colors.black,),
              ),
              Text(
                "- 288 000 сум",
                style: TextStyle(color: Colors.black45),
              )
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Накопленные баллы",
                style: TextStyle(
                    color: Colors.black,),
              ),
              Text(
                "- 20 000 сум",
                style: TextStyle(color: Colors.black45),
              )
            ],
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

  showAlertDialog(CartItem cartItem1){
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Отмена"),
      onPressed: () {setState(() {});Navigator.of(context, rootNavigator: true).pop();},
    );
    Widget continueButton = FlatButton(
      child: Text("Удалить"),
      onPressed: () async {

        print("remo1");
        final prefs = await SharedPreferences.getInstance();
        List<CartItem> allCarts=NoomiKeys.cartSaves;//List<CartItem>.from(json.decode(prefs.getString("CartItems")).map((x) => CartItem.fromJson(x)));
        for(int i =0; i<allCarts.length;i++){
          if(allCarts[i].slug==cartItem1.slug){
            print("remo2="+allCarts[i].slug);
            allCarts.removeAt(i);
            i=allCarts.length+1;
          }
        }
        NoomiKeys.cartSaves=allCarts;
        prefs.setString("CartItems", json.encode(allCarts));
        getCarts().then((value){
          isLoaded=true;
          setState(() {});
        });
        print("l="+allCarts.length.toString());
        widget.updateCarts();
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
      builder: (BuildContext context,) {
        return alert;
      },
    );
  }
}
