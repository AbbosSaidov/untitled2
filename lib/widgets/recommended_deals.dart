import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/models/shops_response.dart';
import 'package:untitled2/noomi_keys.dart';
import 'package:untitled2/pages/product_filter_page.dart';
import 'package:untitled2/service/category/category_api_provider.dart';
import 'package:untitled2/service/category/cubit/category_cubit.dart';
import 'package:untitled2/service/recommended-product/cubit/recommended_product_cubit.dart';
import 'package:untitled2/service/recommended-product/recommended_product_repository.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/widgets/cache_image_widget.dart';
import 'package:untitled2/service/shops/shops_repository.dart';
import 'package:untitled2/service/shops/cubit/shops_cubit.dart';
import 'package:shimmer/shimmer.dart';

class RecommendedWidget extends StatefulWidget{
  RecommendedWidget({Key key,this.title, this.type, this.categoryName,}) : super(key: key);

  final String title;
  final String type;
  final String categoryName;
  @override
  _RecommendedWidgetState createState()=>_RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget>{
  final categoryRepository = RecommendedProductRepository();

  @override
  Widget build(BuildContext context){

    //    double width = MediaQuery. of(context). size. width;
    //double height = MediaQuery. of(context). size. height/15;
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
          BlocProvider<RecommendedProductCubit>(
            create: (context)=>_initType(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: BlocBuilder<RecommendedProductCubit,RecommendedProductState>(
                builder: (context,state){
                  // print("st11="+(state is ShopsInitial).toString()+state.runtimeType.toString());
                  // print("st12="+(state is ShopsLoadingState).toString());
                  // print("st13="+(state is ShopsLoadedState).toString());
                  if(state is RecommendedProductInitial || state is RecommendedProductLoadingState){
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
                  else if(state is RecommendedProductLoadedState){
                    //    print("st2="+state.runtimeType.toString());
                    var shops = state.list.data;
                    return  GridView.count(
                      childAspectRatio: 0.74,
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
                            onTap:(){
                            print("fron="+shops[index].slug.toString());
                                  print("fro2n="+widget.type.toString());
                                  String sd=widget.type;
                                  if(widget.type.toString()=="category1"){
                                    sd="category";
                                  }
                            NoomiKeys.categorySlug=shops[index].slug.toString();
                            NoomiKeys.typeOpFilter=sd;
                            NoomiKeys.navKey.currentState.pushNamed("/FilterPage");
                           //   Navigator.push(
                           //     context,
                           //     MaterialPageRoute(
                           //       builder: (context) => ProductFilterPage(
                           //         categorySlug:shops[index].slug.toString(),
                           //         typeOpFilter: sd,
                           //         type: "getOfSubCategories",
                           //       ),
                           //     ),
                           //   );
                            },
                            child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width / 4,
                                      height: MediaQuery.of(context).size.width / 4,
                                      child: InkWell(
                                        child: CacheImageWidget(
                                          //  height: height*1.5,
                                          url:  shops[index].banner,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      decoration:BoxDecoration(
                                        border: Border.all(width: 3,color: Colors.black12),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)
                                        ),
                                      ),
                                    ),
                                    Container(height: 10,),
                                    Expanded(
                                      child: Text(
                                        shops[index].title !=null ? shops[index].title:"NUll",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                        //   overflow: TextOverflow.ellipsis,
                                        //    maxLines: 2,
                                        //   softWrap: false,
                                      ),
                                    )
                                  ],
                                ),
                          )
                      ),
                    );
                  }else
                    if(state is SubCategoriesLoadedState){
                     //   print("st2="+state.runtimeType.toString());
                    var shops = state.categories.data;
                    return  GridView.count(
                      childAspectRatio: 0.74,
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
                            onTap:() {
                              print("fron="+shops[index].slug.toString());
                              print("fro2n="+widget.type.toString());
                              String sd=widget.type;
                              if(widget.type.toString()=="category1"){
                                sd="category";
                              }
                              NoomiKeys.categorySlug=shops[index].slug.toString();
                              NoomiKeys.typeOpFilter=sd;
                              NoomiKeys.navKey.currentState.pushNamed("/FilterPage");
                            //    Navigator.push(
                            //      context,
                            //      MaterialPageRoute(
                            //        builder: (context) => ProductFilterPage(
                            //        categorySlug:shops[index].slug.toString(),
                            //        typeOpFilter: sd,
                            //        type: widget.type,
                            //        ),
                            //      ),
                            //    );
                            },
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: MediaQuery.of(context).size.width / 4,
                                  child: InkWell(
                                    child: CacheImageWidget(
                                      //  height: height*1.5,
                                      url:  shops[index].banner,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  decoration:BoxDecoration(
                                    border: Border.all(width: 3,color: Colors.black12),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)
                                    ),
                                  ),
                                ),
                                Container(height: 10,),
                                Expanded(
                                  child: Text(
                                    shops[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    //   overflow: TextOverflow.ellipsis,
                                    //    maxLines: 2,
                                    //   softWrap: false,
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                    );
                  }else
                    if(state is SubBannerLoadedState){
                     return Container(
                       width: double.infinity,
                       height: 150,
                       child: InkWell(
                         child: CacheImageWidget(
                           url: state.subCategories.category.banner,
                           fit: BoxFit.cover,
                         ),
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

  RecommendedProductCubit _initType(){
    RecommendedProductCubit repo = RecommendedProductCubit(categoryRepository);
    //print("type="+repo.state.runtimeType.toString());
    //print("type1="+widget.type.toString());
    switch (widget.type){
      case 'flashdeals':
        return repo..getAll();
      case 'getOfAllFeatured':
        return repo..getAllFeatured();
      case 'getSubBanners':
        return repo..getSubBanner(widget.categoryName);
      case 'category':
        return repo..getAllSubCategories(widget.categoryName);
      case 'category1':
        return repo..getOfPopularCategories();
      default:
        return repo;
    }
  }
}