import 'package:flutter/material.dart';
import 'package:untitled2/models/cart_items_model.dart';
import 'package:untitled2/pages/universal_page.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/provider/cabinet_provider.dart';
import 'package:untitled2/widgets/bottom_navigation_bar.dart';
import 'package:untitled2/widgets/product_cards_widget.dart';

import 'package:provider/provider.dart';

class CabinetPage extends StatefulWidget {
  CabinetPage({Key key, this.updateCarts}) : super(key: key);
  final updateCarts;
  @override
  _CabinetPageState createState() => _CabinetPageState();
}

class _CabinetPageState extends State<CabinetPage> {
  bool isAuth = false;
  CabinetProvider myProvider;
  CartItem cartSave = CartItem();
  @override
  Widget build(BuildContext context){
    myProvider = Provider.of<CabinetProvider>(context);
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          isAuth
              ? Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 50),
            decoration: BoxDecoration(color: MyColors.customBlue),
            child: InkWell(
              onTap: () => {},
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: MyColors.athensGray,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.account_circle_outlined,
                            size: 100,
                            color: MyColors.customBlue,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20, bottom: 25),
                          child: Text(
                            "?????? ????????????",
                            style: TextStyle(color: MyColors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_outlined,
                    color: MyColors.white,
                    size: 30,
                  )
                ],
              ),
            ),
          )
              : Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 34),
            decoration: BoxDecoration(color: MyColors.zumthor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    "?????????????? ?????? ????????????????????????????????",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: Text(
                      "?????????? ???????????? ??????????????, ?????????????????????? ???????????? ?? ???????????????????????? ???????????????????????? ?????????????? ?? ??????????????."),
                ),
                // Container(
                //   width: double.infinity,
                // child:
                Row(children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: RaisedButton(
                      color: MyColors.customBlue,
                      elevation: 0,
                      onPressed: () => {
                        setState(
                              () => {
                            //         isAuth = !isAuth,
                            myProvider.openRegistrationScreen(context),
                          },
                        )
                      },
                      child: Text(
                        "?????????? ?????? ??????????????????????????????????",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                ])
                // )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: MyColors.athensGray),
            height: 30,
          ),
          _listItem(
                () => {myProvider.listItemLocation(context)},
            "??????????????",
            icon: Icons.location_on_outlined,
            primary: true,
          ),
          _listItem(
                () => {myProvider.openPointMap(context)},
            "?????? ?????????????? ??????????????",
          ),
          // _listItem(
          //       () => {myProvider.openPointMap(context)},
          //   "???????????? ???????????? ???? ??????????",
          // ),
          _listItem(
                () => { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UniversalPage(productSlug: "oplata",)),
            )},
            "???????????? ????????????",
            divider: false,
          ),
          //    Container(
          //      decoration: BoxDecoration(color: MyColors.athensGray),
          //      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          //      margin: EdgeInsets.only(top: 5, bottom: 5),
          //      child: Text(
          //        "??????????????".toUpperCase(),
          //        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
          //      ),
          //    ),
          //    _listItem(
          //          () => {myProvider.orderPages(context)},
          //      "????????????",
          //    ),
          //    _listItem(
          //          () => {myProvider.purchasedGoods(context)},
          //      "?????????????????? ????????????",
          //      divider: false,
          //    ),
          //    Container(
          //      decoration: BoxDecoration(color: MyColors.athensGray),
          //      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          //      margin: EdgeInsets.only(top: 5, bottom: 5),
          //      child: Text(
          //        "????????????".toUpperCase(),
          //        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
          //      ),
          //    ),
          _listItem(
                () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UniversalPage(productSlug: "seller-policy-pages",)),
              )
            },
            "???????????????? ????????????",
          ),
          _listItem(
                () => {myProvider.diliveryMethod(context)},
            "?????????????? ??????????????????",
          ),
          _listItem(
                () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UniversalPage(productSlug: "return-policy-page",)),
              )
            },
            "???????????????? ????????????????",
          ),
          _listItem(
                () => {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UniversalPage(productSlug: "vozvrat-plateza",)),
            )},
            "?????????????? ??????????????",
          ),
          _listItem(
                () => {myProvider.helpPage(context)},
            "?????? ?????????? ???????????????????",
            divider: false,
          ),
          _listItem(
                () => {myProvider.helpPage(context)},
            "?????? ?????????? ???????????????????",
            divider: false,
          ),
          _listItem(
                () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UniversalPage(productSlug: "term-conditions-page",)),
              )
            },
            "?????????????????? ????????????",
            divider: false,
          ),
          _listItem(
                () => { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UniversalPage(productSlug: "privacy-policy-page",)),
            )},
            "??????????????????????????????????",
            divider: false,
          ),
          _listItem(
                () => {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UniversalPage(productSlug: "o-torgovoj-platforme",)),
            )},
            "?? ???????????????? ??????????????????",
            divider: false,
          ),
          //  _listItem(
          //        () => {myProvider.paymentMethod(context)},
          //    "?????????????? ????????????",
          //  ),
          //   Container(
          //     decoration: BoxDecoration(color: MyColors.athensGray),
          //     padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          //     margin: EdgeInsets.only(top: 5, bottom: 5),
          //     child: Text(
          //       "????????????????????".toUpperCase(),
          //       style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
          //     ),
          //   ),
          //  _listItem(
          //        () => {myProvider.accountSecurity(context)},
          //    "????????????????????????",
          //  ),
          //  _listItem(
          //        () => {myProvider.helpPage(context)},
          //    "???????????????? ?? ????????",
          //    divider: false,
          //  ),
          _listItem(
                () => {myProvider.aboutApp(context)},
            "?? ????????????????????",
            divider: false,
          ),
          Container(
            decoration: BoxDecoration(color: MyColors.athensGray),
            height: 30,
          ),
          ProductCardsWidget(
            updateCarts: widget.updateCarts,
            named: true,
            perCol: 2,
            title: "???????????? ?????? ??????",
            vertical: false,
            type: "getOfTodaysDeal",
          ),
          Padding(padding: EdgeInsets.all(15))
        ],
      ),
    );
  }

  Widget _listItem(Function onTap, String text,
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
                  Icon(
                    Icons.chevron_right_outlined,
                    color: MyColors.tiara,
                    size: 30,
                  )
                ],
              ),
            ),
            divider ? Divider(height: 0) : Container()
          ],
        ),
      ),
    );
  }
}
