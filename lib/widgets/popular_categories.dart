import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/models/shops_response.dart';
import 'package:untitled2/service/category/category_api_provider.dart';
import 'package:untitled2/service/category/cubit/category_cubit.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/widgets/cache_image_widget.dart';
import 'package:untitled2/service/shops/shops_repository.dart';
import 'package:untitled2/service/shops/cubit/shops_cubit.dart';
import 'package:shimmer/shimmer.dart';

class PopularCategoriesWidget extends StatefulWidget{
  PopularCategoriesWidget({Key key,this.title,}) : super(key: key);

  final String title;
  @override
  _PopularCategoriesWidgetState createState()=>_PopularCategoriesWidgetState();
}

class _PopularCategoriesWidgetState extends State<PopularCategoriesWidget>{
  final categoryRepository = CategoryRepository();
  @override
  Widget build(BuildContext context){
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height/15;
    return Column(
        children:[
          widget.title != null
              ? Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: MyColors.customBlue,
                  ),
                ),
                Container(
                  width: 7,
                ),
                Text(
                  "Смотреть все",
                  style: TextStyle(
                    fontSize: 13,
                    color: MyColors.customBlue,
                  ),
                ),
              ],
            )
          )
              : Container(),
          BlocProvider<CategoryCubit>(
            create: (context)=>CategoryCubit(categoryRepository)..getPopularCategories(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: BlocBuilder<CategoryCubit,CategoryState>(
                builder: (context,state){

                  // print("st11="+(state is ShopsInitial).toString()+state.runtimeType.toString());
                  // print("st12="+(state is ShopsLoadingState).toString());
                  // print("st13="+(state is ShopsLoadedState).toString());
                  if(state is CategoryInitial || state is CategoryLoadingState){
                    //   print("st3="+state.runtimeType.toString());
                    return  Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: List.generate(
                        9,(index) => Container(
                        width: MediaQuery.of(context).size.width / 3,
                        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                        child: Shimmer.fromColors(
                          baseColor: MyColors.shimmerBaseColor,
                          highlightColor: MyColors.shimmerHighlightColor,
                          child: Container(height: 180, color: Colors.white),
                        ),
                      ),
                      ),
                    );
                  }
                  else if(state is CategoryLoadedState){
                    //    print("st2="+state.runtimeType.toString());

                    var shops = state.list.data;
                    return  GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(
                          shops.length,
                              (index) => InkWell(
                            onTap:() => {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => ProductPage(productId: product.id),
                              //     ),
                              //   )
                            },
                            child: Container(
                              height: height*3,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 6,
                                    height: MediaQuery.of(context).size.width / 6,
                                    padding: EdgeInsets.only(bottom: 3, top: 6),
                                    child: Container(
                                      width: double.infinity,
                                      child: InkWell(
                                        child: CacheImageWidget(
                                          height: height*1.5,
                                          url: shops[index].banner,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.width / 11,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child:Text(
                                            shops[index].name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: false,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              decoration:BoxDecoration(
                                border: Border.all(width: 1,color: Colors.black12),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0)
                                ),
                              ),
                            ),
                          )
                      ),
                    );
                  }else{
                    return Container();
                  }
                },
              ),
            ),
          )
        ]);
  }
}