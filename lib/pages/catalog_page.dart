import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/pages/in_catalog_page.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/widgets/appbar_widget.dart';
import 'package:untitled2/widgets/bottom_navigation_bar.dart';
import 'package:untitled2/widgets/cache_image_widget.dart';
import 'package:untitled2/service/category/category_api_provider.dart';
import 'package:untitled2/service/category/cubit/category_cubit.dart';
import 'package:shimmer/shimmer.dart';

class CatalogPage extends StatefulWidget{
  CatalogPage({Key key, this.updateCarts}) : super(key: key);
  final updateCarts;
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage>{
  final categoryRepository = CategoryRepository();

  double kDefaultPaddin = 10;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(backButton: false,),
      body:_getCategory(),
    );
  }
  Widget _getCategory(){
    return BlocProvider<CategoryCubit>(
      create: (context) => CategoryCubit(categoryRepository)..getAll(),
      child: BlocBuilder<CategoryCubit,CategoryState>(
        builder: (context, state){
          if (state is CategoryInitial || state is CategoryLoadingState){
            return GridView.count(
              shrinkWrap: true,
              primary: false,
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 4,
              children: List.generate(
                9,(index) => Container(
                  child: InkWell(
                    onTap: () => {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 5),
                          width: MediaQuery.of(context).size.width / 9,
                          height: MediaQuery.of(context).size.width / 9,
                          child: ClipRRect(
                          //  borderRadius: BorderRadius.circular(50),
                            child: Shimmer.fromColors(
                              baseColor: MyColors.shimmerBaseColor,
                              highlightColor: MyColors.shimmerHighlightColor,
                              child: Container(
                                height: double.infinity,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          width: double.infinity,
                          child: Shimmer.fromColors(
                            baseColor: MyColors.shimmerBaseColor,
                            highlightColor: MyColors.shimmerHighlightColor,
                            child: Container(
                              height: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }else if(state is CategoryLoadedState){
            return GridView.count(
              shrinkWrap: true,
              primary: false,
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 4,
              children: List.generate(
               state.list.data.length,
                (index) => itemView(context, state, index),
              ),
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }

  itemView(BuildContext context, CategoryLoadedState state, index){
    final category = state.list.data[index];
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InCatalogPage(
              updateCarts: widget.updateCarts,
              category: category,
            ),
          ),
        ),
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 5),
            width: MediaQuery.of(context).size.width / 9,
            height: MediaQuery.of(context).size.width / 9,
            child: ClipRRect(
            //  borderRadius: BorderRadius.circular(50),
              child: CacheImageWidget(
                url: category.icon,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2),
            width: double.infinity,
            child: Text(
              category.name ?? "",
              style: TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
