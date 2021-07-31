import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/models/shops_response.dart';
import 'package:untitled2/noomi_keys.dart';
import 'package:untitled2/pages/product_filter_page.dart';
import 'package:untitled2/service/brands/banner_repository.dart';
import 'package:untitled2/service/brands/cubit/brands_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class BrandsWidget extends StatefulWidget{
  BrandsWidget({Key key,this.type,}) : super(key: key);

  final String type;

  @override
  _BrandsWidgetState createState()=>_BrandsWidgetState();
}

class _BrandsWidgetState extends State<BrandsWidget>{
  final brandRepository = BrandsRepository();
  List<String> alphabet=['A','B','C','D','E','F','G','H',
    'I','J','K','L','M','N','O','P','Q','R','S'
    ,'T','V','X','Y','Z'];
  List<List<String>> myList = [];
  List<List<String>> myListSlug = [];
  @override
  Widget build(BuildContext context){
//    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height/15;
    return Column(
        children:[
          BlocProvider<BrandsCubit>(
            create: (context)=>_initType(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: BlocBuilder<BrandsCubit,BrandsState>(
                builder: (context,state){
                  // print("st11="+(state is ShopsInitial).toString()+state.runtimeType.toString());
                  // print("st12="+(state is ShopsLoadingState).toString());
                  // print("st13="+(state is ShopsLoadedState).toString());
                  if(state is BrandLoadingState || state is BrandsInitial){
                    //   print("st3="+state.runtimeType.toString());
                    return  Center(child: CircularProgressIndicator(),);
                  }
                  else if(state is BrandLoadedState){
                    //    print("st2="+state.runtimeType.toString());
                    var brands = state.list.data;
                    for(int i=0;i<alphabet.length;i++){
                      myList.add([]);
                      myListSlug.add([]);
                      for(int k=0;k<brands.length;k++){
                        bool fg=true;
                        for(int m=0;m<myList[i].length;m++){
                          if(brands[k].name.toString()==myList[i][m]){
                            fg=false;
                          }
                        }
                        if(fg && alphabet[i].toString()==brands[k].name.toString().toUpperCase().substring(0,1)){
                          myList[i].add(brands[k].name.toString());
                          myListSlug[i].add(brands[k].slug.toString());
                        }
                      }
                    }
                   return ListView.builder(
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: alphabet.length,
                     itemBuilder: (context, index1){
                       return Container(
                         //      margin: EdgeInsets.only(top: 20),
                           padding: EdgeInsets.symmetric(vertical: 10),
                           //      decoration: BoxDecoration(color: MyColors.athensGray),
                           child: Column(
                             children: [
                               Container(
                                 width: double.infinity,
                                 padding: EdgeInsets.only(right: 18, left: 18),
                                 child: Text(alphabet[index1].toString(),
                                   style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 16,
                                 ),),
                               ),
                         ListView.builder(
                           shrinkWrap: true,
                           physics: NeverScrollableScrollPhysics(),
                           itemCount: (myList[index1].length/2).round(),
                           itemBuilder: (context, index2){
                               return Row(
                                 children: [
                                   Expanded(
                                     flex: 5,
                                       child: InkWell(
                                           onTap:(){
                                             print("fro222n="+myListSlug[index1][index2*2].toString());

                                             print("fro2n="+widget.type.toString());
                                             String sd=widget.type;
                                             if(widget.type.toString()=="getOfAllBrands"){
                                               sd="brand";
                                             }

                                             NoomiKeys.categorySlug=myListSlug[index1][index2*2].toString();
                                             NoomiKeys.typeOpFilter=sd;
                                             NoomiKeys.navKey.currentState.pushNamed("/FilterPage");
                                         //    Navigator.push(
                                         //      context,
                                         //      MaterialPageRoute(
                                         //        builder: (context) => ProductFilterPage(
                                         //            type: "getOfAllBrands",
                                         //            categorySlug:myListSlug[index1][index2*2].toString()),
                                         //      ),
                                         //    );
                                           },
                                           child: Container(
                                         //      margin: EdgeInsets.only(top: 20),
                                           padding: EdgeInsets.symmetric(vertical: 10),
                                           //      decoration: BoxDecoration(color: MyColors.athensGray),
                                           child: Column(
                                             children: [
                                               Container(
                                                   width: double.infinity,
                                                   padding: EdgeInsets.only(right: 18, left: 18),
                                                   child: Text(myList[index1][index2*2].toString(),
                                                     style: TextStyle(
                                                       fontWeight: FontWeight.normal,
                                                       fontSize: 16,
                                                     ),),
                                                 ),
                                             ],
                                           )
                                       ),)
                                   ),
                                   Expanded(
                                     flex: 5,
                                     child: InkWell(
                                       onTap:(){
                                         print("fro2n="+widget.type.toString());
                                         print("fro222n="+myListSlug[index1][index2*2+1].toString());
                                         String sd=widget.type;
                                         if(widget.type.toString()=="getOfAllBrands"){
                                           sd="brand";
                                         }

                                         NoomiKeys.categorySlug=myListSlug[index1][index2*2+1].toString();
                                         NoomiKeys.typeOpFilter=sd;
                                         NoomiKeys.navKey.currentState.pushNamed("/FilterPage");
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => ProductFilterPage(
                                        //         type: "getOfAllBrands",
                                        //         categorySlug:myListSlug[index1][index2*2+1].toString()),
                                        //   ),
                                        // );
                                       },
                                       child:Container(
                                           //      margin: EdgeInsets.only(top: 20),
                                           padding: EdgeInsets.symmetric(vertical: 10),
                                           //      decoration: BoxDecoration(color: MyColors.athensGray),
                                           child: Column(
                                             children: [
                                               myList[index1].length>index2*2+1? Container(
                                                 width: double.infinity,
                                                 padding: EdgeInsets.only(right: 18, left: 18),
                                                 child: Text(myList[index1][index2*2+1].toString(),
                                                   style: TextStyle(
                                                     fontWeight: FontWeight.normal,
                                                     fontSize: 16,
                                                   ),),
                                               ):Container(),

                                             ],
                                           )
                                       ),
                                     ),),
                                 ],
                               );
                           },
                         )
                         ],
                           )
                       );
                     },
                   );
                  }
                  else{
                    return Container();
                  }
                },
              ),
            ),
          )
        ]);
  }

  BrandsCubit _initType(){
    BrandsCubit repo = BrandsCubit(brandRepository);
    //print("type="+repo.state.runtimeType.toString());
    //print("type1="+widget.type.toString());

    switch (widget.type){
      case 'getOfAllBrands':
        return repo..getList();
      default:
        return repo;
    }
  }
}