import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/service/wishlist/cubit/wishlist_cubit.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/widgets/appbar_widget.dart';
import 'package:untitled2/widgets/bottom_navigation_bar.dart';
import 'package:untitled2/widgets/favorite_card_widget.dart';
import 'package:untitled2/service/wishlist/wishlist_repository.dart';
import 'package:shimmer/shimmer.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key}) : super(key: key);
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String selected = "a";
  int _radioVal = 0;
  bool status = false;
  final wishlistRepository = WishlistRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WishlistCubit>(
        create: (context) =>WishlistCubit(wishlistRepository)..getAll(9),
      child: Scaffold(
        appBar: CustomAppBar(backButton: false,),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 0, 0),
              child: Text(
                "Избранное",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 16.0),
            Divider(height: 1.0),
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _dialog();
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Row(
                          children: <Widget>[
                            Text("Cначала новые"),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.black,
                              size: 36.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        builder: (BuildContext context) {
                          return _buildBottomsheet(context);
                        },
                      );
                    },

                    //   showModalBottomSheet(
                    //     builder: (context) => _buildBottomsheet(context),
                    //     context: context);
                    // },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.filter_alt,
                          color: Colors.black,
                          size: 20.0,
                        ),
                        Text(
                          "Фильтры",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<WishlistCubit, WishlistState>(builder: (context, state) {
              if (state is WishlistErrorState) {
                return Text("error");
              }
              if (state is WishlistLoadingState) {
                return Shimmer.fromColors(
                  baseColor: MyColors.shimmerBaseColor,
                  highlightColor: MyColors.shimmerHighlightColor,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: false,
                      height: 150,
                      aspectRatio: 1,
                      enlargeCenterPage: true,
                    ),
                    items: List.generate(
                      3,
                          (_) => Container(
                        width: double.infinity,
                        color: MyColors.white,
                      ),
                    ),
                  ),
                );
              }
              if (state is WishlistLoadedState) {
                print("Okkkkkkkkkkkkkkkkkkkkkkkkkk");
                return Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      Wrap(
                        children: List.generate(
                          state.list.length,
                              (index) => state.list[index] !=null ? Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: FavoriteCardWidget(wishlistLoadedState: state.list[index]),
                          ) :Container(),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("No information"),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _dialog(){
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          child: Container(
            height: 250,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selected = "1";
                      });
                    },
                    child: _dialogItem("Сначала новые", "1"),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          selected = "2";
                        });
                      },
                      child: _dialogItem("Сначала стары", "2")),
                  InkWell(
                      onTap: () {
                        setState(() {
                          selected = "3";
                        });
                      },
                      child: _dialogItem("Сначала дешёвые", "3")),
                  InkWell(
                      onTap: () {
                        setState(() {
                          selected = "4";
                        });
                      },
                      child: _dialogItem("Сначала дорогие", "4")),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selected = "5";
                      });
                    },
                    child: _dialogItem("По размеру скидки", "5"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dialogItem(String name, String number) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Visibility(
              child: Icon(
                Icons.check,
                color: Colors.black,
                size: 20.0,
              ),
              visible: selected == number,
            ),
          )
        ],
      ),
    );
  }

  Container _buildBottomsheet(BuildContext context) {
    return Container(
      child: Container(
        child: Stack(children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 55,
                      ),
                      Text(
                        "Фильтры",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "Закрыть",
                        style: TextStyle(color: MyColors.customBlue, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Детские товары"),
                  ),
                  Row(
                    children: [0]
                        .map((int index) => Radio<int>(
                              activeColor: Colors.green,
                              value: index,
                              groupValue: this._radioVal,
                              onChanged: (int value) {
                                setState(() => this._radioVal = 1);
                              },
                            ))
                        .toList(),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Divider(height: 2.0),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Все категории",
                      style: TextStyle(color: MyColors.customBlue, fontSize: 15),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Толко в наличии"),
                    Switch(
                      activeColor: Colors.pinkAccent,
                      value: status,
                      onChanged: (value) {
                        print("VALUE : $value");
                        setState(() {
                          status = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  color: MyColors.customBlue,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Посмотреть",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "1 товар",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
