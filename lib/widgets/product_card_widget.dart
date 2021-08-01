import 'package:flutter/material.dart';
import 'package:untitled2/models/cart_items_model.dart';
import 'package:untitled2/noomi_keys.dart';
import 'package:untitled2/pages/cabine_regis_email_page.dart';
import 'package:untitled2/provider/user_provider.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/pages/product_page.dart';
import 'package:untitled2/utils/sharedPref.dart';
import 'package:untitled2/widgets/cache_image_widget.dart';
import 'package:untitled2/models/login_response.dart';
import 'package:untitled2/models/products_response.dart';

import 'package:intl/intl.dart';
//kkkkk
class ProductCardWidget extends StatefulWidget{
  ProductCardWidget({
    Key key,
    @required this.updateCarts,
    this.named = false,
    this.rowNumber = 3,
    @required this.product,
    this.isBestSaller = false,
  }) : super(key: key);

  final bool named;
  final ProductModel product;
  final int rowNumber;
  final updateCarts;
  final bool isBestSaller;

  @override
  _ProductCardWidgetState createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget>{
  bool _selected = false;
  bool _isFavorite = false;
  SharedPref sharedPref =SharedPref();
  bool isAuth;

  UserProvider userProvider = UserProvider();

  void getIsAuth() async{
    final LoginResponseModel user = await userProvider.getUser();
    setState((){
      isAuth = user != null;
    });
  }

  @override
  void initState(){
    super.initState();
    // print("basepr="+widget.product.basePrice.toString());
    getIsAuth();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final ProductModel product = widget.product;

    final NumberFormat _num = NumberFormat("#,###.##", 'en_US');
    _num.maximumIntegerDigits = 2;

    String _sum(double param){
      final String res = _num.format(param);
      return res.replaceAll(',', "");
    }

    final bool isDiscount = product.discount != null && product.discount > 0;

    if(widget.rowNumber==1){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 9),
        child: InkWell(
          onTap: (){
          NoomiKeys.productSlug=product.slug;
          NoomiKeys.navKey.currentState.pushNamed("/product");
           // Navigator.push(
           //   context,
           //   MaterialPageRoute(
           //     builder: (context) => ProductPage(productId: product.id),
           //   ),
           // )
          },
          child:Row(
          children:[
            Expanded(
              flex: 30, // 40%
              child: Container(
                width: double.infinity,
                child: InkWell(
                  child: CacheImageWidget(
                    height: MediaQuery.of(context).size.width /3,
                    url: product.thumbnailImage,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 55, // 60%
                child: Container(
                    height:MediaQuery.of(context).size.width /3 ,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _isBestSaller(widget.isBestSaller),
                        Container(
                          width: double.infinity,
                          child: isDiscount
                              ? Wrap(
                            children: [
                              Text(
                              NumberFormat("#,##0 сум", "en_US").format(product.baseDiscountedPrice),
                              //  NumberFormat.currency(locale: 'eu',symbol: "сум").format(product.baseDiscountedPrice),
                               // "${_sum(product.baseDiscountedPrice)}",
                                style: TextStyle(
                                  color: MyColors.hibiscus,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 3, top: 2),
                                child:  Text(
                                  NumberFormat("#,##0 сум", "en_US").format(product.basePrice),
                                //  NumberFormat.currency(locale: 'eu',symbol: "сум").format(product.basePrice),
                                  style: TextStyle(
                                    color:  MyColors.thunder,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),/* Text(
                                  "${_sum(product.basePrice)}",
                                  style: TextStyle(
                                    color: MyColors.thunder,
                                    fontSize: 11,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: MyColors.hibiscus,
                                  ),
                                )*/
                              )
                            ],
                          )
                              : Text(
                            NumberFormat("#,##0 сум", "en_US").format(product.basePrice),
                           // NumberFormat.currency(locale: 'eu',symbol: "сум").format(product.basePrice),
                            style: TextStyle(
                              color: MyColors.hibiscus,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        widget.named
                            ? Container(
                          width: double.infinity,
                          height: 33,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: false,
                              ),
                            ],
                          ),
                        )
                            : Container(),
                        _getCounterBtn()
                      ],
                    )
                )
            ),
            Expanded(
                flex: 15,
                child:Container(
                  height: MediaQuery.of(context).size.width /3 ,
                  child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          if (isAuth) {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          } else {
                            Navigator.push(
                              context,
                              CabinetPageRegistrationEmail.route(),
                            );
                          }
                        },
                        child: _isFavorite
                            ? Icon(
                          Icons.favorite,
                          color: MyColors.red,
                          size: 35.0,
                        )
                            : Icon(
                          Icons.favorite_border,
                          color: MyColors.black,
                          size: 35.0,
                        ),
                      ),

                      isDiscount
                          ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: MyColors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "-"+product.discount.toString()+"%",
                         // "-${((product.discount / product.basePrice) * 100).round()}%",
                          style: TextStyle(
                            color: MyColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                )
            )
            /*   InkWell(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(productId: product.id),
                ),
              )
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 3, top: 6),
                    child: Stack(
                      children: [

                      ],
                    ),
                  ),
                  Column(
                    children: [

                    ],
                  ),
                ],
              ),
            ),
          ) ,*/
          ],
        ),)
      );
    }else{
      return Container(
          padding: EdgeInsets.symmetric(vertical: 9),
          child: Column(
            children:[
              InkWell(
                onTap:(){
                  NoomiKeys.productSlug=product.slug;
                  NoomiKeys.navKey.currentState.pushNamed("/product");
               //   Navigator.push(
               //     context,
               //     MaterialPageRoute(
               //       builder: (context) => ProductPage(productId: product.id),
               //     ),
               //   )
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 3, top: 6),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              child: InkWell(
                                child: CacheImageWidget(
                                  height: 110,
                                  url: product.thumbnailImage,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: InkWell(
                                onTap: () {
                                  if (isAuth) {
                                    setState(() {
                                      _isFavorite = !_isFavorite;
                                    });
                                  } else {
                                    Navigator.push(
                                      context,
                                      CabinetPageRegistrationEmail.route(),
                                    );
                                  }
                                },
                                child: _isFavorite
                                    ? Icon(
                                  Icons.favorite,
                                  color: MyColors.red,
                                  size: 35.0,
                                )
                                    : Stack(children: [
                                  Icon(
                                    Icons.favorite,
                                    color: MyColors.white,
                                    size: 35.0,
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: MyColors.black,
                                      size: 35.0,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            isDiscount
                                ? Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: MyColors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "-"+product.discount.toString()+"%",
                               //   "-${((product.discount / product.basePrice) * 100).round()}%",
                                  style: TextStyle(
                                    color: MyColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                                : Container(),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          _isBestSaller(widget.isBestSaller),
                          Container(
                            height: 27,//MediaQuery. of(context). size. width/13,
                            width: double.infinity,
                            child: isDiscount
                                ? Wrap(
                              children: [
                                Text(
                                  NumberFormat("#,##0 сум", "en_US").format(product.baseDiscountedPrice),
                                  //NumberFormat.currency(locale: 'eu',symbol: "сум").format(product.baseDiscountedPrice),

                            //      "${_sum(product.baseDiscountedPrice)}",
                                  style: TextStyle(
                                    color: MyColors.hibiscus,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  //padding: EdgeInsets.only(left: 3, top: 2),
                                  child: Text(
                                 //   NumberFormat.currency(locale: 'eu',symbol: "сум").format(product.basePrice),
                                    NumberFormat("#,##0 сум", "en_US").format(product.basePrice),
                               //     "${_sum(product.basePrice)}",
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
                                : Align(
                              alignment: Alignment.center,
                              child: Text(

                              NumberFormat("#,##0 сум", "en_US").format(product.basePrice),
                              //   NumberFormat.currency(locale: 'eu',symbol: "сум").format(product.basePrice),
                              style: TextStyle(
                                color: MyColors.hibiscus,
                                fontWeight: FontWeight.bold,
                              ),
                            ),),
                          ),
                          widget.named
                              ? Container(
                            width: double.infinity,
                            height: 33,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                ),
                              ],
                            ),
                          )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: _getCounterBtn(),
              )
            ],
          ));
    }
  }
  Widget _isBestSaller(bool isBestSaller){
    return isBestSaller
        ? Container(
            width: double.infinity,
            child: Text(
              "Бестселлер",
              style: TextStyle(
                color: MyColors.sorrellBrown,
                fontSize: 12,
              ),
            ),
          )
        : Container();
  }
  Widget _getCounterBtn(){
    return Container(
      width: double.infinity,
      child: RaisedButton(
        onPressed:(){

          if(_selected==false){
            _selected=true;
          CartItem cartSave = CartItem();
          cartSave.slug=widget.product.slug;
          cartSave.name=widget.product.name;
          cartSave.price=widget.product.basePrice;
          cartSave.image=widget.product.photos!=null ? widget.product.photos[0]:"null";
          // cartSave.pieces=state.response.data.photos!=null ? state.response.data.photos[0]:"null";
          cartSave.isWishlist=false;
          cartSave.pieces=1;
          sharedPref.save(cartSave, widget.updateCarts);

          setState(() {});
          }

         },
        color: _selected ? MyColors.green : MyColors.customBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          "В корзину",
          style: TextStyle(color: MyColors.white),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          maxLines: 1,
          softWrap: false,
        ),
      ),
    );
  }
}
