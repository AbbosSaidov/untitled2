import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/noomi_keys.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/widgets/product_card_widget.dart';

import 'package:untitled2/service/product/cubit/product_cubit.dart';
import 'package:untitled2/service/product/product_repository.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardsWidget extends StatefulWidget{
  ProductCardsWidget({
    Key key,
    this.title,
    this.isFiltered,
    this.named = true,
    this.vertical = false,
    this.showAll = true,
    this.perCol = 3,
    this.updateCarts,
    this.url,
    @required this.type,
    this.categorySlug,
    this.typeOpFilter,
  }) : super(key: key);

  final String title;
  final bool named;
   bool isFiltered;
  final bool vertical;
  final bool showAll;
  final updateCarts;
  final int perCol;
  final String type;
  final String url;
  final String categorySlug;
  final String typeOpFilter;

  @override
  _ProductCardsWidgetState createState() => _ProductCardsWidgetState();
}

class _ProductCardsWidgetState extends State<ProductCardsWidget>{
  final productRepository = ProductRepository();
  ScrollController _scrollController=ScrollController();
  int scrollL=1;

  @override
  Widget build(BuildContext context){
    bool isBestSaller = widget.type == 'getOfBestSeller';
    //print("typeXX="+widget.type.toString());
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
                     // color: MyColors.customBlue,
                    ),
                  ),
                  Container(
                    width: 7,
                  ),
                  widget.showAll ? InkWell(
                    onTap: (){
                      print("fron="+widget.categorySlug.toString());
                      print("fro2n="+widget.type.toString());
                      String sd="category";

                      if(widget.type.toString()=="best-seller" ){
                        sd="recommendation";
                      }
                      if(widget.type.toString()=="new-products" ){
                        sd="new";
                      }
                      if(widget.type.toString()=="getOfFreeFeatured" ){
                        sd="freeDelevery";
                      }
                      if(widget.type.toString()=="featured"){
                        sd="popular";
                      }
                      NoomiKeys.categorySlug=widget.categorySlug;
                      NoomiKeys.typeOpFilter=sd;
                      NoomiKeys.navKey.currentState.pushNamed("/FilterPage");
                    },
                    child: Text(
                      "Смотреть все",
                      style: TextStyle(
                        fontSize: 13,
                        color: MyColors.customBlue,
                      ),
                    ),
                  ): Container(),
                ],
              )
            )
          : Container(),
      BlocProvider<ProductCubit>(
        create: (context) => _initType(),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state){
            if(widget.isFiltered!=null && widget.isFiltered){
              widget.isFiltered=false;
              context.watch<ProductCubit>().getFilterCategories(widget.categorySlug,widget.typeOpFilter);
            }
          // print("stproduct1="+state.runtimeType.toString());
            if (state is ProductInitial || state is ProductLoadingState){
              if (widget.vertical){
                return _getVerticalViewShimmer(isBestSaller);
              }else{
                return _getHorizontalViewShimmer(isBestSaller);
              }
            }else if(state is ProductLoadedState){
             // log("asAAAds2="+state.list.toJson().toString());
              if (state.list.data.length > 0){
                if(widget.vertical){
                  return _getVerticalView(state, isBestSaller);
                }else{
                  return _getHorizontalView(state, isBestSaller);
                }
              }else{
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Нет данных..."),
                    ],
                  ),
                );
              }
            }else{
              return _getHorizontalViewShimmer(isBestSaller);
              // return Container();
            }
          },
        ),
      ),
    ]);
  }
  Widget _getVerticalViewShimmer(bool isBestSaller){
    return Container(
      height: 335,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: 12,
        itemBuilder: (context, index) {
          return Container(
            width: 180,
            child: Shimmer.fromColors(
              baseColor: MyColors.shimmerBaseColor,
              highlightColor: MyColors.shimmerHighlightColor,
              child: Container(height: double.infinity, color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget _getHorizontalViewShimmer(bool isBestSaller) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: List.generate(
        12,
        (index) => Container(
          width: MediaQuery.of(context).size.width / widget.perCol,
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

  Widget _getVerticalView(ProductLoadedState state, bool isBestSaller){
    print("showles");
    return Container(
      height: 335,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: state.list.data.length >12 ? 12 : state.list.data.length,
        itemBuilder: (context, index){
          return Container(
            width: 180,
            child: ProductCardWidget(
              updateCarts: widget.updateCarts,
              rowNumber: widget.perCol,
              named: widget.named,
              product: state.list.data[index],
              isBestSaller: isBestSaller,
            ),
          );
        },
      ),
    );
  }

  Widget _getHorizontalView(ProductLoadedState state, bool isBestSaller){
    return Container(
      width: double.infinity,
      child:Wrap(
        alignment: WrapAlignment.start,
        children: List.generate(
          state.list.data.length > 12 ? 12 : state.list.data.length,
              (index) => Container(
            width: MediaQuery.of(context).size.width / widget.perCol,
            child: ProductCardWidget(
              updateCarts: widget.updateCarts,
              rowNumber: widget.perCol,
              named: widget.named,
              product: state.list.data[index],
              isBestSaller: isBestSaller,
            ),
          ),
        ),
      ),
    );
  }

  ProductCubit _initType(){
    ProductCubit repo = ProductCubit(productRepository);
    //print("type="+repo.state.runtimeType.toString());
    print("type1="+widget.type.toString());

    switch (widget.type){
      case 'new-products':
        return repo..getOfTodaysDeal();
      case 'best-seller':
        return repo..getOfBestSeller();
      case 'getOfFreeFeatured':
        return repo..getOfFreeFeatured();
        case 'getOfRecomendedAlso':
        return repo..getOfRecomendedAlso(widget.url);
      case 'featured':
        return repo..getOfFeatured();
      case 'getOfCategory':
        return repo..getOfCategory(widget.categorySlug, 1);
      case 'getOfAll':
        return repo..getOfAll(widget.categorySlug);
      case 'getOfShops':
        return repo..getOfShops(widget.categorySlug);
      case 'getOfAllShops':
        return repo..getOfAllShops(widget.categorySlug);
      case 'getOfPopular':
        return repo..getOfPopular(widget.categorySlug);
      case 'getSubCategories':
        return repo..getFilterCategories(widget.categorySlug,widget.typeOpFilter);
    //      if(widget.isFiltered!=null && widget.isFiltered){
    //        return repo..getFilterCategories(widget.categorySlug);
    //      }
    //        return repo..getSubCategories(widget.categorySlug);
      default:
        return repo;
    }
  }
}
