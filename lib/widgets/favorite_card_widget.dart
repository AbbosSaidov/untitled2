import 'package:flutter/material.dart';
import 'package:untitled2/models/wishlist_request.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/extensions/hex_color.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../extensions/hex_color.dart';
import 'cache_image_widget.dart';

class FavoriteCardWidget extends StatefulWidget {
  FavoriteCardWidget({this.wishlistLoadedState});

  final WishlistModel wishlistLoadedState;

  @override
  _FavoriteCardWidgetState createState() => _FavoriteCardWidgetState();
}

class _FavoriteCardWidgetState extends State<FavoriteCardWidget> {
  // final GlobalKey<ScaffoldState> _scaffoldStatae = GlobalKey<ScaffoldState>();
  int _currentBanner = 0;
  int _itemCount = 0;
  bool _isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return
        //  Shimmer.fromColors(
        // baseColor: MyColors.shimmerBaseColor,
        // highlightColor: MyColors.shimmerHighlightColor,
        // child:
        Container(
      width: MediaQuery.of(context).size.width / 3.2,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 6),
        width: MediaQuery.of(context).size.width / 3.5,
        child: Column(
          children: [
            InkWell(
              // onTap: () => {Get.toNamed("/product")},
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 3, top: 6),
                    height: MediaQuery.of(context).size.width / 3.3,
                    child: Stack(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            // autoPlay: true,
                            // height: 150,
                            // aspectRatio: 1,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentBanner = index;
                              });
                            },
                          ),
                          items: List.generate(
                            6,
                            (_) => Container(
                              width: double.infinity,
                              // decoration: BoxDecoration(
                              //   color: MyColors.white,
                              //   borderRadius: BorderRadius.circular(8),
                              // ),
                              child: InkWell(
                                child: CacheImageWidget(
                                  height: 110,
                                  url: widget.wishlistLoadedState.thumbnail_image,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // width: MediaQuery.of(context).size.width,
                          // bottom: 0,
                          // left: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 55,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                6,
                                (index) => Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 3.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentBanner == index
                                        ? Colors.white
                                        : HexColor("#D6D9DE"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                // _isFavorite = !_isFavorite;
                                _isFavorite = !_isFavorite;
                              });
                            },
                            child: _isFavorite
                                ? Icon(
                                    Icons.favorite,
                                    color: HexColor("#FB0F5A"),
                                    size: 35.0,
                                  )
                                : Stack(children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 35.0,
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: HexColor("#FB0F5A"),
                                        size: 35.0,
                                      ),
                                    ),
                                  ]),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 8,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: HexColor("#FB0F5A"),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            // child: Container(
                            //   margin:
                            //       EdgeInsets.only(left: 2, right: 2, top: 2),
                            //   width: double.infinity,
                            //   height: 10,
                            //   color: MyColors.white,
                            // ),
                            child: Text(
                              "—40%",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Wrap(
                          children: [
                            // Container(
                            //   margin:
                            //       EdgeInsets.only(left: 2, right: 2, top: 2),
                            //   width: double.infinity,
                            //   height: 10,
                            //   color: MyColors.white,
                            // ),
                            Text(
                              widget.wishlistLoadedState.base_price.toString(),
                              style: TextStyle(
                                color: HexColor("#FF4170"),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 3),
                              // child:
                              // Container(
                              //   margin: EdgeInsets.only(
                              //       left: 2, right: 2, top: 2),
                              //   width: double.infinity,
                              //   height: 10,
                              //   color: MyColors.white,
                              // ),
                              child: Text(
                                widget.wishlistLoadedState.base_price.toString(),
                                style: TextStyle(
                                  color: HexColor("#4c4c4c"),
                                  fontSize: 11,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: HexColor("#FF4170"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      _text(widget.wishlistLoadedState.name.toString()),
                     // _text("22₽ / шт"),
                     // _text("Premium Care, 9-15 kg, rezmer"),
                      //_text("Premium Care, 9-15 kg, rezmer"),
                     // _text("4,76 шт"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: _getCounterBtn(),
            )
          ],
        ),
      ),
      // ),
    );
  }

  Widget _getCounterBtn() {
    return _itemCount > 0
        ? Container(
            // padding: EdgeInsets.only(top: 10, bottom: 6),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: _createIncrementDicrementButton(
                    Icons.remove,
                    () => setState(() => _itemCount--),
                    HexColor("#F0F4F4"),
                  ),
                ),
                Expanded(
                  child: Text(
                    _itemCount.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: _createIncrementDicrementButton(
                    Icons.add,
                    () => setState(() => _itemCount++),
                    HexColor("#F0F4F4"),
                  ),
                )
              ],
            ),
          )
        : Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  onPressed: () => setState(() => _itemCount++),
                  // child: Container(
                  //   margin: EdgeInsets.only(left: 2, right: 2, top: 2),
                  //   width: double.infinity,
                  //   height: 10,
                  //   color: MyColors.white,
                  // ),
                  child: Text(
                    "В корзину",
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    softWrap: false,
                  ),
                  color: HexColor("#005AFC"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                InkWell(
                  onTap: () => showModalBottomSheet(
                      builder: (context) => _buildBottomsheet(context),
                      context: context),
                  child: Container(
                    child: _createIncrementDicrementButtonmm(
                      Icons.more_vert,
                      HexColor("#F0F4F4"),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _createIncrementDicrementButton(
      IconData icon, Function onPressed, Color color) {
    return Expanded(
      child: RawMaterialButton(
        // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
        onPressed: onPressed,
        elevation: 2.0,
        fillColor: color,
        child: Icon(icon, color: HexColor("#005AFC"), size: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  Widget _createIncrementDicrementButtonmm(IconData icon, Color color) {
    return RawMaterialButton(
      onPressed: () => {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      elevation: 2.0,
      fillColor: color,
      child: Icon(icon, color: Colors.black, size: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Container _buildBottomsheet(BuildContext context) {
    return Container(
      child: Expanded(
        child: Container(
          child: Column(
            children: [
              _paddingText(
                "Добавить в список",
                Icon(
                  Icons.add,
                  size: 18,
                ),
              ),
              _paddingTextSized("Регулярная доставка", SizedBox(width: 18)),
              _paddingTextSized("Регулярная доставка", SizedBox(width: 18)),
              _paddingTextSized("Регулярная доставка", SizedBox(width: 18)),
              _paddingTextSized("Регулярная доставка", SizedBox(width: 18)),
              _paddingText(
                "Удалить из избранного",
                Icon(
                  Icons.delete_outline,
                  size: 18,
                ),
              ),
              _paddingText(
                "Отмена",
                Icon(
                  Icons.close,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _button() {
  //   return Expanded(
  //     child: Container(
  //       child: Column(
  //         children: [
  //           _paddingText(
  //             "Добавить в список",
  //             Icon(
  //               Icons.add,
  //               size: 18,
  //             ),
  //           ),
  //           _paddingTextSized("Регулярная доставка", SizedBox(width: 18)),
  //           _paddingTextSized("Регулярная доставка", SizedBox(width: 18)),
  //           _paddingTextSized("Регулярная доставка", SizedBox(width: 18)),
  //           _paddingTextSized("Регулярная доставка", SizedBox(width: 18)),
  //           _paddingText(
  //             "Удалить из избранного",
  //             Icon(
  //               Icons.delete_outline,
  //               size: 18,
  //             ),
  //           ),
  //           _paddingText(
  //             "Отмена",
  //             Icon(
  //               Icons.close,
  //               size: 18,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _paddingText(String text, Widget i) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            i,
            Text(
              text,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Widget _paddingTextSized(String text, Widget a) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            a,
            Text(
              text,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Widget _text(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: Text(
        name,
        style: TextStyle(
          color: HexColor("#4c4c4c"),
          fontSize: 12,
        ),
      ),
    );
  }
}
