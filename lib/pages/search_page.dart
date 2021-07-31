import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/models/category_response.dart';
import 'package:untitled2/noomi_keys.dart';
import 'package:untitled2/pages/product_page.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/utils/debouncer.dart';
import 'package:untitled2/widgets/cache_image_widget.dart';
import 'package:untitled2/models/search_response_model.dart';
import 'package:untitled2/service/search/cubit/search_cubit.dart';
import 'package:untitled2/service/search/search_repository.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Color oldColor;

  final _debouncer = Debouncer(milliseconds: 500);
  final TextEditingController _textController = new TextEditingController();
  final searchRepository = SearchRepository();

  SearchCubit searchCubit;

  @override
  void initState() {
    FlutterStatusbarcolor.getStatusBarColor().then((old) {
      oldColor = old;
      _changeSysBar(MyColors.white);
    });
    super.initState();
  }

  @override
  void dispose() {
    _changeSysBar(oldColor);
    _textController.dispose();

    super.dispose();
  }

  void _changeSysBar(Color color){
    FlutterStatusbarcolor.setStatusBarColor(color).then(
      (value) {
        bool isWhite = useWhiteForeground(color);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(isWhite);
      },
    );
  }

  void onTextChange(String text){
    if (searchCubit != null){
      if (text != null && text.isNotEmpty){

        _debouncer.run(()async{
          searchCubit.search(text);
        });
      }else{
        searchCubit.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(searchRepository),
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: AppBar(
          elevation: 5,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          backgroundColor: MyColors.white,
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5, right: 7),
                child: InkWell(
                  onTap: () => {Navigator.pop(context)},
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    height: 42,
                    child: TextFormField(
                      onChanged: onTextChange,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Искать...',
                        isDense: true,
                        contentPadding: EdgeInsets.only(top: 10),
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          iconSize: 25,
                          color: Colors.black45,
                          onPressed: () => onTextChange,
                        ),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 50,
                          minHeight: 10,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => {_textController.clear()},
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black45,
                          ),
                        ),
                        fillColor: Colors.white30,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16)
            ],
          ),
        ),
        body: BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(searchRepository),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              searchCubit = BlocProvider.of<SearchCubit>(context);

              if (state is SearchInitial) {
                return Container();
              } else if (state is SearchLoadedState) {
                var products = json.decode(state.res);
                //print("listCat="+state.res.categories.length.toString());
                //print("listCat0="+state.res.categories[0]['name'].toString());

                return Container(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    physics: BouncingScrollPhysics(),
                    itemCount: products['products']['data'].length+products['categories'].length,//state.res.categories.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap:(){
                        if(products['categories'].length > index){
                          Navigator.pop(context);
                          final category = CategoryModel.fromMap(products['categories'][index]);
                          NoomiKeys.categoryModel=category;
                          NoomiKeys.navKey.currentState.pushNamed("/shopsWidget");
                        }else{
                          Navigator.pop(context);
                          NoomiKeys.productSlug=products['products']['data'][products['products']['data'].length+products['categories'].length-index-1]['slug'];
                          NoomiKeys.navKey.currentState.pushNamed("/product");
                        }
                       // Navigator.push(
                       //   context,
                       //   MaterialPage Route(
                       //     builder: (context) => ProductPage(
                       //       productId: products[index].id,
                       //     ),
                       //   ),
                       // ),
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  width: 80,
                                  height: 50,
                                  child: products['categories'].length > index ? Container():
                                  CacheImageWidget(
                                    url: products['products']['data'][products['products']['data'].length+products['categories'].length-index-1]['thumbnaileImage'],//products[products.length+state.res.categories.length-index-1].thumbnaileImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    products['categories'].length > index ?  products['categories'][index]['name'].toString() :
                                    products['products']['data'][products['products']['data'].length+products['categories'].length-index-1]['name'],
                                    style: TextStyle(color: MyColors.firefly),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: false,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: MyColors.regentGray,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 53, top: 8),
                              child: Divider(height: 0, color: MyColors.alto),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  // Container getKeywords() {
  //   return Container(
  //     child: ListView.builder(
  //       physics: BouncingScrollPhysics(),
  //       itemCount: 20,
  //       itemBuilder: (context, index) => index == 0 || index == 5
  //           ? Container(
  //               padding: EdgeInsets.only(
  //                 left: 15,
  //                 right: 15,
  //                 top: 25,
  //                 bottom: 15,
  //               ),
  //               child: Text(
  //                 index == 0 ? "История" : "Популярные",
  //                 style: TextStyle(
  //                   color: MyColors.blueCharcoal,
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //             )
  //           : InkWell(
  //               onTap: () => {},
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(vertical: 5),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Container(
  //                           padding: EdgeInsets.symmetric(horizontal: 15),
  //                           child: Icon(
  //                             Icons.search,
  //                             color: MyColors.regentGray,
  //                             size: 28,
  //                           ),
  //                         ),
  //                         Expanded(
  //                           child: Text(
  //                             "Пазл",
  //                             style: TextStyle(color: MyColors.firefly),
  //                             overflow: TextOverflow.ellipsis,
  //                             maxLines: 1,
  //                             softWrap: false,
  //                           ),
  //                         ),
  //                         Container(
  //                           padding: EdgeInsets.only(right: 10),
  //                           child: Icon(
  //                             Icons.chevron_right,
  //                             color: MyColors.regentGray,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Container(
  //                       padding: EdgeInsets.only(left: 53, top: 8),
  //                       child: Divider(
  //                         height: 0,
  //                         color: MyColors.alto,
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //     ),
  //   );
  // }
}
