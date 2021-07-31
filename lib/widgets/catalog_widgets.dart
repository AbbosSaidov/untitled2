import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/noomi_keys.dart';
import 'package:untitled2/pages/brand_page.dart';
import 'package:untitled2/pages/catalog_page.dart';
import 'package:untitled2/pages/in_catalog_page.dart';
import 'package:untitled2/pages/shops_page.dart';
import 'package:untitled2/pages/stock_page.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/widgets/cache_image_widget.dart';
import 'package:untitled2/service/category/category_api_provider.dart';
import 'package:untitled2/service/category/cubit/category_cubit.dart';
import 'package:shimmer/shimmer.dart';

class CatalogWidget extends StatefulWidget{
  CatalogWidget({Key key}) : super(key: key);


  @override
  _CatalogWidgetState createState() => _CatalogWidgetState();
}
class _CatalogWidgetState extends State<CatalogWidget>{
  final categoryRepository = CategoryRepository();
  final _navigatorKey = NoomiKeys.navKey;
  double kDefaultPaddin = 10;

  @override
  Widget build(BuildContext context){
    return _getCategory();
  }

  Widget _getCategory(){
    return BlocProvider<CategoryCubit>(
      create: (context) => CategoryCubit(categoryRepository)..getAll(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state){
          if (state is CategoryInitial || state is CategoryLoadingState){
            return GridView.count(
              shrinkWrap: true,
              primary: false,
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 5,
              children: List.generate(
                10,
                    (index) => Container(
                  child: InkWell(
                    onTap: () => {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 2),
                          width: MediaQuery.of(context).size.width / 10,
                          height: MediaQuery.of(context).size.width / 10,
                          child: ClipRRect(
                           // borderRadius: BorderRadius.circular(50),
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
          }
          else if(state is CategoryLoadedState){
            return GridView.count(
              shrinkWrap: true,
              primary: false,
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 7),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 5,
              children: List.generate(
                10,
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
    switch(index){
      case 0: return Container(
        child: InkWell(
          onTap: () {
          _navigatorKey.currentState.pushNamed("/shops");
         //  Navigator.push(
         //     context,
         //     MaterialPageRoute(
         //       builder: (context) => ShopsPage(),
         //     ),
         //   );
        },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 2),
                width: MediaQuery.of(context).size.width / 15,
                height:MediaQuery.of(context).size.width / 15,
                child: ClipRRect(
                //  borderRadius: BorderRadius.circular(50),
                  child:Icon(Icons.store_sharp,color: Colors.green,)/* CacheImageWidget(
                    url: category.icon,
                    fit: BoxFit.cover,
                  ),*/
                ),
              ),
              Text(
                "Магазины",
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );break;
      case 1: return Container(
        child: InkWell(
          onTap: () => {
          _navigatorKey.currentState.pushNamed("/brands")
          //    Navigator.push(
          //    context,
          //    MaterialPageRoute(
          //      builder: (context) => BrandPage(),
          //    ),
          //  ),
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 2),
                width: MediaQuery.of(context).size.width / 15,
                height: MediaQuery.of(context).size.width / 15,
                child: ClipRRect(
               //     borderRadius: BorderRadius.circular(50),
                    child:Icon(Icons.auto_awesome,color: MyColors.customBlue,)/* CacheImageWidget(
                    url: category.icon,
                    fit: BoxFit.cover,
                  ),*/
                ),
              ),
              Text(
                "Бренды",
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );break;
      case 2: return Container(
        child: InkWell(
          onTap: () => {
            _navigatorKey.currentState.pushNamed("/stocks")
         //    Navigator.push(
         //     context,
         //     MaterialPageRoute(
         //       builder: (context) => StockPage(
         //       ),
         //     ),
         //   ),
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 2),
                width: MediaQuery.of(context).size.width / 15,
                height: MediaQuery.of(context).size.width / 15,
                child: ClipRRect(
               //     borderRadius: BorderRadius.circular(50),
                    child:Icon(Icons.assessment_outlined,color: Colors.red,)/* CacheImageWidget(
                    url: category.icon,
                    fit: BoxFit.cover,
                  ),*/
                ),
              ),
              Text(
                "Акции",
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );break;
      case 3: return Container(
        child: InkWell(
          onTap: () => {
            /*  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InCatalogPage(
                  category: category,
                ),
              ),
            ),*/
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 2),
                width: MediaQuery.of(context).size.width / 15,
                height: MediaQuery.of(context).size.width / 15,
                child: ClipRRect(
                //    borderRadius: BorderRadius.circular(50),
                    child:Icon(Icons.badge,color: Colors.orangeAccent,)/* CacheImageWidget(
                    url: category.icon,
                    fit: BoxFit.cover,
                  ),*/
                ),
              ),
              Text(
                "Купоны",
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );break;
      case 9: return Container(
        child: InkWell(
          onTap: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CatalogPage()),
          ),
            /*  Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InCatalogPage(
                  category: category,
                ),
              ),
            ),*/
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 2),
                width: MediaQuery.of(context).size.width / 15,
                height: MediaQuery.of(context).size.width / 15,
                child: ClipRRect(
            //        borderRadius: BorderRadius.circular(50),
                    child:Icon(Icons.more_horiz)/* CacheImageWidget(
                    url: category.icon,
                    fit: BoxFit.cover,
                  ),*/
                ),
              ),

            ],
          ),
        ),
      );break;
      default:
        final category = state.list.data[index-4];

print("image="+category.icon.toString());
      return Container(
        child: InkWell(
          onTap: () {
          NoomiKeys.categoryModel=category;
          _navigatorKey.currentState.pushNamed("/shopsCat");

          //  Navigator.push(
          //    context,
          //    MaterialPageRoute(
          //      builder: (context) => InCatalogPage(
          //        category: category,
          //      ),
          //    ),
          //  ),
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 2),
                width: MediaQuery.of(context).size.width / 15,
                height: MediaQuery.of(context).size.width / 15,
                child: ClipRRect(
                //  borderRadius: BorderRadius.circular(50),
                  child: CacheImageWidget(
                    url: category.icon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                category.name ?? "",
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
  }
}