import 'package:flutter/material.dart';
import 'package:untitled2/noomi_keys.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/widgets/cache_image_widget.dart';
import 'package:untitled2/service/shops/shops_repository.dart';
import 'package:untitled2/service/shops/cubit/shops_cubit.dart';
import 'package:shimmer/shimmer.dart';

class ShopsWidget extends StatefulWidget{
  ShopsWidget({Key key,this.title,}) : super(key: key);

  final String title;
  @override
  _ShopsWidgetState createState()=>_ShopsWidgetState();
}
class _ShopsWidgetState extends State<ShopsWidget>{
  final shopsRepository=ShopsRepository();
  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;


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
          ):Container(),
          BlocProvider<ShopsCubit>(
            create: (context)=>ShopsCubit(shopsRepository)..fetchBanners(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: BlocBuilder<ShopsCubit,ShopsState>(
                builder: (context,state){
                      // print("st11="+(state is ShopsInitial).toString()+state.runtimeType.toString());
                      // print("st12="+(state is ShopsLoadingState).toString());
                      // print("st13="+(state is ShopsLoadedState).toString());
                  if(state is ShopsInitial || state is ShopsLoadingState){
                      // print("st3="+state.runtimeType.toString());
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
                  }else if(state is ShopsLoadedState){
                    //print("st2="+state.runtimeType.toString());
                      var shops = state.res.data;
                      if(shops==null || shops.length<1){
                        return Container();
                      }else{
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
                                onTap:()  {
                                  NoomiKeys.categorySlug=shops[index].slug.toString();
                                  NoomiKeys.navKey.currentState.pushNamed("/shopsWidget");
                                  //    Navigator.push(
                                  //      context,
                                  //      MaterialPageRoute(
                                  //        builder: (context) => ShopsMainPage(
                                  //            slug: shops[index].slug),
                                  //      ),
                                  //    )
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
                                          url:  shops[index].logo,
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
                      }

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