import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:untitled2/extensions/hex_color.dart';
import 'package:untitled2/models/cart_items_model.dart';
import 'package:untitled2/noomi_keys.dart';
import 'package:untitled2/pages/cart_page.dart';
import 'package:untitled2/pages/universal_page.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/config.dart';
import 'package:untitled2/models/product_detail_response.dart';
import 'package:untitled2/service/product/cubit/product_cubit.dart';
import 'package:untitled2/service/product/product_repository.dart';
import 'package:untitled2/utils/sharedPref.dart';
import 'package:untitled2/widgets/cache_image_widget.dart';
import 'package:untitled2/widgets/product_cards_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductPage extends StatefulWidget{
  ProductPage({
    Key key,
    @required this.productSlug,
    this.updateCarts,
  }) : super(key: key);

  final String productSlug;
  final updateCarts;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
  with SingleTickerProviderStateMixin{
  final controller = PageController(viewportFraction: 1);
  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 14.0);
  TextStyle linkStyle = TextStyle(color: MyColors.customBlue);
  var productRepository = ProductRepository();
  SharedPref sharedPref =SharedPref();
  CartItem cartSave = CartItem();
  int pieces=0;
  bool isFavorite = false;
  bool _selected = false;
  List<int> isSize = [];
  int isSize2 = 0;
  int isSize3 = 0;
  double rating1 = 0;
  String variantColor="null";
  String choiseOption="null";
  bool verticalGallery = false;
  TabController _tabController;
 // TabController _tabController2;
  int inStocknumber=0;
  int price=0;
  bool isAvailble=false;
  Widget getFooter;
  bool isRegistorFromPhone=true;
  bool isRegistered=false;
  bool _switchValue=false;
  int _tabIndex = 0;
  bool monVal=false;
  bool clicked=false;
  @override
  void initState(){
    _tabController = TabController(length: 2, vsync: this);

    // _tabController2 = TabController(length: 2, vsync: this);
    _tabController.addListener((){
      setState(() {
        _tabIndex = _tabController.index;
      });
    });

    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context){
    return BlocProvider<ProductCubit>(
      create: (context) =>
          ProductCubit(productRepository)..getById(widget.productSlug),
      child: Scaffold(
        backgroundColor: MyColors.white,
        appBar: _getAppBar(),
        body:
        BlocBuilder<ProductCubit, ProductState>(builder: (context, state){
          if (state is ProductInitial || state is ProductLoadingState){
            return Shimmer.fromColors(
              baseColor: MyColors.shimmerBaseColor,
              highlightColor: MyColors.shimmerHighlightColor,
              child:CarouselSlider(
                options:CarouselOptions(
                  autoPlay: false,
                  height: 150,
                  aspectRatio: 1,
                  enlargeCenterPage: true,
                ),
                items:List.generate(
                  3,(_) => Container(
                    width: double.infinity,
                    color: MyColors.white,
                  ),
                ),
              ),
            );
          }else if(state is ProductDetailLoadedState){
            cartSave.slug=widget.productSlug;
            cartSave.name=state.response.data.name;
            cartSave.price=state.response.data.priceLower;
            cartSave.image=state.response.data.photos!=null ? state.response.data.photos[0]:"null";
           // cartSave.pieces=state.response.data.photos!=null ? state.response.data.photos[0]:"null";
            cartSave.isWishlist=false;
            cartSave.pieces=pieces;
            return _getBody(state.response.data);
          }else if(state is ProductErrorState){
            return Center(
              child: Text("Error"),
            );
          }else{
            return Container();
          }
        }),
        bottomNavigationBar:
        BlocBuilder<ProductCubit, ProductState>(builder:(context, state){
          if(state is ProductInitial || state is ProductLoadingState){
            return _getFooter(0,false);
          }else if(state is ProductDetailLoadedState){
           // changeFooter(state.response.data);
            return _getFooter(price,isAvailble);
          }else if(state is ProductErrorState){
            return _getFooter(0,false);
          }else{
            return _getFooter(0,false);
          }
        }),
      ),
    );
  }

  void changeFooter(var product){
    if(variantColor=="null" && choiseOption=="null"){
      price=product.variations[0].price;
      inStocknumber=product.variations[0].qty;
      if(product.variations[0].qty>0){
        isAvailble=true;
      }
    }
    if(variantColor=="null"&& choiseOption!="null"){
      if(product.colors.length>0){
        variantColor=product.colors[0].name;
      }else{
        variantColor="";
      }
    }
    for(int i=0;i<product.variations.length;i++){
      if(product.variations[i].variant==variantColor+choiseOption){
        inStocknumber=product.variations[i].qty;
        price=product.variations[i].price;
        if(product.variations[i].qty>0){
          isAvailble=true;
        }else{
          isAvailble=false;
        }
      }
    }
  }
  Widget _getAppBar(){
    return AppBar(
      backgroundColor: MyColors.bigStone,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5, right: 7),
            child: InkWell(
              onTap: () => {Navigator.pop(context)},
              borderRadius: BorderRadius.circular(50),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
          Expanded(child: Text("")),
          Row(children: [
            __getAppBarButton(Icons.share, () {
              var url = 'Hallo from marketplace!';
              Share.share(url);
            }),
            __getAppBarButton(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              color: isFavorite ? MyColors.redRibbon : Colors.white,
            ),
          ])
        ],
      ),
    );
  }

  Widget _getBody(ProductDetailModel product){
  //  print(product.id);
  //  print("dd"+product.photos[0].toString());

      isSize.clear();
      for(int m=0;m<product.choiceOptions.length;m++){
        isSize.add(product.variant['attributes'][m]);
      }

    String colorName="";
    for(int h=0;h<product.colors.length;h++){
      if(product.colors[h].id==product.variant['color']){
        colorName=product.colors[h].name;
        isSize2=h;
      }
    }
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 250,
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: controller,
              children: List.generate(
                product.photos.length,
                (index) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   InkWell(
                     onTap:(){
                       open(context,0,product.photos);
                     } ,
                     child:Container(
                       padding: EdgeInsets.symmetric(horizontal: 20),
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(8.0),
                         child: Padding(
                           padding: const EdgeInsets.all(15.0),
                           child: CachedNetworkImage(
                             imageUrl: Config.filesUrl + product.photos[index],
                             fit: BoxFit.cover,
                           ),
                         ),
                       ),
                     ),
                   )

                  ],
                ),
              ),
            ),
          ),
          Container(
            padding:EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 12),
            child:Row(
              children:[
                product.discount != 0 ?
                Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "-"+product.discount.toString()+"%",
                      style: TextStyle(
                        color: MyColors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        fontSize: 12,
                      ),
                    ),
                  ):Container()
               /* Container(
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.royalPurple,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Часто покупаете?",
                    style: TextStyle(
                      color: MyColors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      fontSize: 12,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: product.photos.length,
            effect: SlideEffect(
              dotWidth: 10,
              dotHeight: 10,
              dotColor: MyColors.tiara,
              activeDotColor: MyColors.blackPearl,
            ),
          ),
          Container(
            height: 10,
          ),
       /*Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(color: MyColors.athensGray),
            child: Row(
              children: [
                Icon(Icons.train_outlined, color: MyColors.raven),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Доступно 2 варианта доставки",
                    style: TextStyle(
                      color: MyColors.raven,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),*/
       /*  Container(
            //      margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            //       decoration: BoxDecoration(color: MyColors.athensGray),
            child: Row(
              children: [
                Icon(Icons.train_outlined, color: MyColors.raven),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Доступно 2 варианта доставки",
                    style: TextStyle(
                      color: MyColors.raven,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 18, right: 18, top: 6),
            width: double.infinity,
            child: Text(
              "Бестселлер",
              style: TextStyle(
                color: MyColors.sorrellBrown,
                fontSize: 12,
              ),
            ),
          ),*/
       /*   Container(
            padding: EdgeInsets.only(left: 18, right: 18, top: 2),
            width: double.infinity,
            child: Text(product.name),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Text(
                  (product.priceLower < product.priceHigher &&
                          product.priceLower != 0)
                      ? product.priceLower.toString()
                      : product.priceHigher.toString(),
                  style: TextStyle(
                    color: (product.priceHigher > product.priceLower)
                        ? MyColors.hibiscus
                        : MyColors.thunder,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(
                    (product.priceLower != 0)
                        ? product.priceHigher.toString()
                        : "",
                    style: TextStyle(
                      color: MyColors.thunder,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: MyColors.hibiscus,
                    ),
                  ),
                )
              ],
            ),
          ),*/
       /*  Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, bottom: 2, left: 18, right: 18),
            child: Text(
              product.unit,
              style: TextStyle(color: MyColors.stTropaz),
            ),
          ),*/
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 18, left: 18),
            child: Text(
              product.name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: MyColors.blackPearl,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: product.choiceOptions.length,
            itemBuilder: (context, index1){
              return Container(
                //      margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(vertical: 10),
                //      decoration: BoxDecoration(color: MyColors.athensGray),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(right: 18, top: 20, left: 18),
                      child: Text(product.choiceOptions[index1]['attribute'].toString()),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      height: 42,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: product.choiceOptions[index1]['values'] !=null ?
                        product.choiceOptions[index1]['values'].length :0,
                        itemBuilder: (context, index) => Container(
                          //    margin: EdgeInsets.only(left: 18, right: index == 19 ? 18 : 0),
                          margin: EdgeInsets.only(left: 18, right: index == product.choiceOptions[index1]['values'].length ?
                          product.choiceOptions[index1]['values'].length-1:0),

                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap:(){
                             // choiseOption=product.colors.length>0 ?"-":"";
                              isSize[index1] = index;
                              String slig="";
                              for(int m=0;m<product.variations.length;m++){
                                for(int g=0;g<product.variations[m].attributes.length;g++){
                                  if(product.variations[m].color==product.variant['color'] &&
                                      product.choiceOptions[index1]['values'][index]['id']==product.variations[m].attributes[g]){
                                    slig=product.variations[m].slug;break;
                                    //g=product.variations[m].attributes.length;
                                    //m=product.variations.length;
                                  }
                                }
                              }
                              Navigator.pop(context);
                              print("slug="+slig);
                              NoomiKeys.productSlug=slig;
                              NoomiKeys.navKey.currentState.pushNamed("/product");
                              //  String ts="-";
                            //  for(int t=0;t<product.choiceOptions.length;t++){
                            //    ts=t==0?"":"-";
                            //    choiseOption=choiseOption+ts+product.choiceOptions[t]['values'][isSize[t]];
                            //  }
                              //changeFooter(product);
                              setState((){});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color:isSize[index1]==product.choiceOptions[index1]['values'][index]['id']
                                      ? MyColors.toryBlue
                                      : MyColors.wildSand,
                                  width: 2,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 13),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    product.choiceOptions[index1]['values'][index]['name'].toString(),
                                    style: TextStyle(
                                      color: MyColors.blackPearl,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              );
            },
          ),
          product.colors.length >0 ? Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 18, top: 5, left: 18),
            child: Text("Цвет: "+colorName.toString()),
          ):Container(),
          product.colors.length >0 ? Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: product.colors.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(left: 18, right: index == product.colors.length ? product.colors.length-1 : 0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap:(){
                    String slig="";
                    for(int m=0;m<product.variations.length;m++){
                      if(product.variations[m].color==product.colors[index].id){
                        slig=product.variations[m].slug;
                        m=product.variations.length;
                      }
                    }
                    Navigator.pop(context);
                    print("slug="+slig);
                    NoomiKeys.productSlug=slig;
                    NoomiKeys.navKey.currentState.pushNamed("/product");
                 //   choiseOption="";
                 //   isSize2 = index;
                 //   variantColor=product.colors[index].name;
                 //   if(product.choiceOptions.length>0){
                 //     for(int t=0;t<product.choiceOptions.length;t++){
                 //       choiseOption="-"+product.choiceOptions[t]['options'][isSize[t]];
                 //     }
                 //   }
                   // changeFooter(product);
                   // print("chos="+choiseOption);
                    setState((){});
                  },
                  child: Container(
                    width: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSize2 == index
                            ? MyColors.toryBlue
                            : MyColors.dustyGray,
                        width: 2.5,
                      ),
                      color: HexColor(product.colors[index].hash)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 13),
                  ),
                ),
              ),
            ),
          ):Container(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 50,
                    child: Text(
                      "Цена от TINFIS: ",
                      style: TextStyle(
                        color:MyColors.customBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                ),
                Expanded(
                    flex: 50,
                    child: Column(
                      children: [
                        Text(
                          (product.priceLower < product.priceHigher &&
                              product.priceLower != 0)
                              ?
                          NumberFormat("#,##0 сум", "en_US").format(product.priceLower)
                    //NumberFormat.currency(locale: 'eu',symbol: "сум").format(product.priceLower)
                              : NumberFormat("#,##0 сум", "en_US").format(product.priceHigher),
                          //NumberFormat.currency(locale: 'eu',symbol: "сум").format(product.priceHigher) ,
                          style: TextStyle(
                            color: (product.priceHigher > product.priceLower)
                                ? MyColors.red
                                : MyColors.thunder,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 3),
                          child: Text(
                            (product.priceLower != 0 || product.priceLower != product.priceHigher )
                                ? NumberFormat("#,##0 сум", "en_US").format(product.priceHigher)
                                : "",
                            style: TextStyle(
                              color: MyColors.thunder,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: MyColors.red,
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 50,
                  child: Text(
                    "В рассрочку: ",
                    style: TextStyle(
                      color:MyColors.customBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                    flex: 50,
                    child: Column(
                      children: [
                        Text(
                          NumberFormat("#,##0 сум", "en_US").format(26250000+isSize3*3150000),
                          style: TextStyle(
                            color: MyColors.thunder,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 3),
                          child: Text(
                            "Предоплата: 0%",
                            style: TextStyle(
                              color: MyColors.thunder,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: InkWell(
              onTap: (){
                showPricedropDialog();
              },
              child: Container(
                padding: EdgeInsets.only(left: 18),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Узнать о снижении цены",
                              style: TextStyle(color: MyColors.customBlue,fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 8),
            child: InkWell(
              onTap: (){
                showDialog2();
              },
              child: Container(
                padding: EdgeInsets.only(left: 18),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Нашли дешевле?",
                              style: TextStyle(color: MyColors.customBlue,fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Container(
          width:double.infinity,
          child:Padding(
            padding: EdgeInsets.all( 18),
            child: InkWell(
              onTap:(){
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:MainAxisAlignment.start,
                children:[

                  Text(
                    "Условия доставки:",
                    style: TextStyle(
                      color:MyColors.customBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    // overflow: TextOverflow.ellipsis,
                    //maxLines: 1,
                    // softWrap: false,
                  ),
                  Text(
                    "Доставка со склада продавца",
                    style: TextStyle(color: MyColors.black),
                    // overflow: TextOverflow.ellipsis,
                    //maxLines: 1,
                    //  softWrap: false,
                  ),
                ],
              ),
            ),
          ),
        ),

    /*      InkWell(
            onTap: () => {},
            child: Container(
              padding: EdgeInsets.only(left: 18, top: 4, bottom: 4),
              child: Row(
                children: [
                  Icon(Icons.score_outlined),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text.rich(
                      TextSpan(
                        text: "750 баллов (5%)",
                       /* children: <TextSpan>[
                          TextSpan(
                            text: 'Ozon Card',
                            style: TextStyle(color: MyColors.chambray),
                          ),
                        ],*/
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),*/
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 0.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),

            leading: Icon(
              Icons.check_circle_outline,
              color: MyColors.blueCharcoal,
            ),
            title: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "В наличии",
                style: TextStyle(color: MyColors.blueCharcoal,fontSize: 15),
              ),
            ),
            trailing: Text(
              inStocknumber.toString()+" шт." ,
              style: TextStyle(color: MyColors.red,fontSize: 15),
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 0.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Icon(
              Icons.wallet_travel_outlined,
              color: MyColors.blueCharcoal,
            ),
            title: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Самовывоз",
                style: TextStyle(color: MyColors.blueCharcoal,fontSize: 15),
              ),
            ),
            trailing: Text(
              " Бесплатно" ,
              style: TextStyle(color: MyColors.red,fontSize: 15),
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 0.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Icon(
              Icons.home,
              color: MyColors.blueCharcoal,
            ),
            title: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Доставка на дом",
                style: TextStyle(color: MyColors.blueCharcoal,fontSize: 15),
              ),
            ),
            trailing: Text(
              " Бесплатно" ,
              style: TextStyle(color: MyColors.red,fontSize: 15),
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 0.0),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Icon(
              Icons.access_time,
              color: MyColors.blueCharcoal,
            ),
            title: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Период доставки",
                style: TextStyle(color: MyColors.blueCharcoal,fontSize: 15),
              ),
            ),
            trailing: Text(
              " 1 day" ,
              style: TextStyle(color: MyColors.red ,fontSize: 15),
            ),
          ),

          Padding(
            padding:EdgeInsets.all(18),
            child:Container(
              width: double.infinity,
              height:MediaQuery.of(context).size.width*4/9,
              child: Column(
                children: [
                  Container(
                    height:MediaQuery.of(context).size.width*1/9,
                    child:
                    ListTile(
                    /* */ leading: Container(
                      height: MediaQuery.of(context).size.width*1/9,
                      width: MediaQuery.of(context).size.width*1/9,
                      child: CacheImageWidget(
                        height: MediaQuery.of(context).size.width*1/9,
                        url: product.user.avatar,
                        shape: BoxShape.circle,
                      ),
                    ),
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Продавец: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width*0.34/9,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: product.user.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width*0.34/9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height:MediaQuery.of(context).size.width*1/9,
                    child: ListTile(
                      leading:Icon(Icons.credit_card,size:MediaQuery.of(context).size.width*0.74/9 ,),
                      title: Text(
                        "Безопасная оплата онлайн",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width*0.34/9,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height:MediaQuery.of(context).size.width*1/9,
                    child: ListTile(
                      leading:Icon(Icons.arrow_back,size:MediaQuery.of(context).size.width*0.74/9 ,),
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Гарантия возврата - 30 дней. ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.of(context).size.width*0.34/9,
                                fontWeight: FontWeight.normal,
                                //fontFamily: FontWeight.normal
                              ),),
                            TextSpan(
                                text: 'Политика возврата',
                                style: TextStyle(
                                  color: MyColors.customBlue,
                                  fontSize: MediaQuery.of(context).size.width*0.34/9,
                                  fontWeight: FontWeight.normal,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => UniversalPage(productSlug: "return-policy-page",)),
                                    );
                                  }),
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    color:MyColors.customBlue, //MyColors.athensGray,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 10),
            width: double.infinity,
            child: Text(
              "Другие предложения от продавцов",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          Padding(
            padding:EdgeInsets.all(18),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: product.selers.length,
              itemBuilder: (context, index1){
                return product.selers[index1]['is_current'] ==false ? Padding(padding: EdgeInsets.all(5),
                  child: Container(
                  child:InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      NoomiKeys.productSlug=product.selers[index1]['slug'];
                      NoomiKeys.navKey.currentState.pushNamed("/product");
                      },
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 50,
                                  child: Text(
                                    "Продавец: ",
                                    style: TextStyle(
                                      color:MyColors.customBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 50,
                                    child:  Text(
                                     product.selers[index1]['name'],
                                      style: TextStyle(
                                        color: MyColors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),)
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 50,
                                  child: Text(
                                    "Цена: ",
                                    style: TextStyle(
                                      color:MyColors.customBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 50,
                                    child:  Text(
                                        product.selers[index1]['base_price'].runtimeType.toString()=="int" ?NumberFormat.currency(locale: 'eu',symbol: "сум").format(product.selers[index1]['base_price']):
                                      product.selers[index1]['base_price'].toString(),
                                      style: TextStyle(
                                        color: MyColors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),)
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 50,
                                  child: Text(
                                    "Доставка: ",
                                    style: TextStyle(
                                      color:MyColors.customBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 50,
                                    child:  Text(
                                     " 1 день",
                                      style: TextStyle(
                                        color: MyColors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 25, left: 25),
                            width: double.infinity,
                            height:MediaQuery.of(context).size.height*0.45/9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  color: _selected ? MyColors.green :MyColors.customBlue,
                                  textColor: MyColors.white,
                                  onPressed: (){
                                    if(_selected==false){
                                      _selected=true;
                                      CartItem cartSave = CartItem();
                                      cartSave.slug=product.selers[index1]['slug'];
                                      // cartSave.pieces=state.response.data.photos!=null ? state.response.data.photos[0]:"null";
                                      cartSave.isWishlist=false;
                                      cartSave.pieces=1;
                                      sharedPref.save(cartSave, widget.updateCarts);

                                      setState((){});
                                    }

                                  },
                                  child: Text(
                                    "В корзину",
                                    style: TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,color: MyColors.red,))
                              ],
                            )
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 53, top: 8),
                            child: Divider(
                              height: 0,
                              color: MyColors.alto,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color:MyColors.customBlue,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),) : Container();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 18, right: 18,  bottom: 10),
            width: double.infinity,
            child: Center(
              child: Text(
                "Показать все",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16,color: MyColors.customBlue),
              ),
            )
          ),
          ProductCardsWidget(
            //showAll: false,
            updateCarts: widget.updateCarts,
            title: "Рекомендуем также",
            perCol: 3,
            url:product.links.related,
            type: "getOfRecomendedAlso",
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 45,
            child: TabBar(
              controller: _tabController,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(text: 'Описание'.toUpperCase()),
                Tab(text: 'Характеристики'.toUpperCase()),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: [
              Html(
                data: """ <div> ${product.description} </div> """,
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: product.characteristics.length,
                itemBuilder: (context, index1){
                  return Container(
                    //      margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    //      decoration: BoxDecoration(color: MyColors.athensGray),
                    child: Column(
                      children: [
                        Text(product.characteristics[index1].title,style: TextStyle(fontWeight: FontWeight.bold),),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: product.characteristics[index1].options.length,
                          itemBuilder: (context, index2){
                            return Container(
                              //      margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                //      decoration: BoxDecoration(color: MyColors.athensGray),
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                  children:[
                                    Expanded(
                                      flex: 5,
                                      child: Text(product.characteristics[index1].options[index2].attribute),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: product.characteristics[index1].options[index2].values.length,
                                            itemBuilder: (context, index3){
                                              return Text(product.characteristics[index1].options[index2].values[index3].name);
                                            }
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                            );
                          },
                        )
                      ],
                    )
                  //  Row(
                  //    mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                  //    children:[
                  //      Expanded(
                  //        flex: 5,
                  //        child: Text(product.characteristics.attrs[index].key.toString()),
                  //      ),
                  //      Expanded(
                  //        flex: 5,
                  //        child: Padding(
                  //          padding: EdgeInsets.only(left: 10),
                  //          child: Text(
                  //            product.characteristics.attrs[index].value.toString(),
                  //            style: TextStyle(
                  //              color: MyColors.raven,
                  //              fontWeight: FontWeight.w500,
                  //            ),
                  //          ),
                  //        ),
                  //      ),
                  //    ],
                  //  ),
                  );
                },
              )
            ][_tabIndex],
          ),
          Container(
            padding: EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 10),
            width: double.infinity,
            child: Text(
              "Отзывы и вопросы о товаре",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width/0.65,
            child:DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar:TabBar(
                  tabs: [
                    Tab(text: 'ОТЗЫВЫ О ТОВАРЕ'.toUpperCase()),
                    Tab(text: 'ВОПРОСЫ И ОТВЕТЫ О ТОВАРЕ'.toUpperCase()),
                  ],
                  labelColor: Colors.black,
                ),
                body:SizedBox(
                  height: MediaQuery.of(context).size.width/0.7,
                  child:Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    child: TabBarView(
                        children:<Widget>[
                        ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children:[
                          Text("Помогите другим пользователям с выбором — будьте первым, кто поделится своим мнением об этом товаре.",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 16)),
                      Container(
                        child:Row(
                          children:[
                            Expanded(
                              flex:8,
                              child: RatingBar.builder(
                                itemSize: 30,
                                initialRating: rating1,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: MyColors.customBlue,
                                ),
                                onRatingUpdate: (rating) {
                                  rating1=rating;
                                  setState(() {

                                  });
                                  print(rating);
                                },
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Text(rating1.toString()+"/5",textAlign: TextAlign.end,)
                            )
                          ]
                        )
                      ),
                          Divider(),
                          Container(
                            height: MediaQuery.of(context).size.width*1.6/9,
                            width: MediaQuery.of(context).size.width*1.6/9,
                            child:Padding(
                              padding: EdgeInsets.all(10),
                              child:InkWell(
                                child: Container(
                                  child: Center(
                                    child:Text(
                                      "Написть отзыв",
                                      style: TextStyle(color:Colors.white
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColors.customBlue,
                                      border: Border.all(color: Colors.black)
                                  ),
                                ),
                                onTap:(){
                                  isRegistorFromPhone=false;
                                  isRegistered=false;
                                  showDialog2();
                                },
                              ),
                            ),
                          ),

                        ]),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children:[
                              Text(
                                  "Задайте вопрос клиентам, купившим этот товар",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 18)
                              ),
                              Text(
                                  "После проверки ваш вопрос будет опубликован в этом разделе и отправлен пользователям, "
                                      "которые уже совершили покупку. Когда поступит ответ - вам придет уведомление.",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 16)
                              ),
                              Container(
                                  height:MediaQuery.of(context).size.width*0.7/9
                              ),
                              TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.teal)),
                                    // hintText: 'Tell us about yourself',
                                    labelText: 'Напишите свой вопрос',
                                    suffixStyle: const TextStyle(color: Colors.green)),
                              ),
                              Container(
                                  height:MediaQuery.of(context).size.width*0.4/9
                              ),
                              Container(
                                child: Center(
                                  child:RichText(
                                    text: TextSpan(
                                      style: defaultStyle,
                                      children: <TextSpan>[
                                        TextSpan(text: 'Вы оставляете отзыв как: '),
                                        TextSpan(
                                            text: 'Войти',
                                            style: linkStyle,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                isRegistorFromPhone=false;
                                                isRegistered=false;
                                                showDialog2();
                                              }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SwitchListTile(
                                title: const Text('Бесплатная доставка'),
                                value: _switchValue,
                                onChanged: (bool value) {
                                  setState(() {
                                    _switchValue = value;
                                  });
                                },
                              ),
                              Container(
                                height: MediaQuery.of(context).size.width*1.6/9,
                                width: MediaQuery.of(context).size.width*1.6/9,
                                child:Padding(
                                  padding: EdgeInsets.all(10),
                                  child:InkWell(
                                    child: Container(
                                      child: Center(
                                        child:Text(
                                          "Отправить вопрос",
                                          style: TextStyle(color:Colors.white
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: MyColors.customBlue,
                                          border: Border.all(color: Colors.black)
                                      ),
                                    ),
                                    onTap:(){},
                                  ),
                                ),
                              ),
                              Text(
                                  "Заданные вопросы, ответы на них и статус публикации вы можете отслеживать "
                                      "в разделе Мои вопросы и ответы личного кабинета. Перед отправкой вопроса, "
                                      "пожалуйста, ознакомьтесь справилами публикации",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 16)
                              ),
                            ],
                          ),
                        ]
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            decoration: BoxDecoration(color: MyColors.blackHaze),
            padding: EdgeInsets.all(15),
          )
        ],
      ),
    );
  }
  void showDialog2(){
    showDialog(
        context: context,
        builder: (BuildContext conte) => new AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(
                    Radius.circular(10.0))),
            content:  StatefulBuilder(
                builder: (BuildContext context, StateSetter setState2){
                  if(isRegistorFromPhone){
                    return Container(
                      width : MediaQuery.of(context).size.width*8/9,
                      height : MediaQuery.of(context).size.width*7.3/9,
                      child: Column(
                        children: [
                          Flexible(
                              child:Padding(
                                child:Container(
                                  height:MediaQuery.of(context).size.width*7.3/9 ,
                                  child: ListView(
                                    children:[
                                      Text(
                                          "Войдите или зарегистрируйтесь, чтобы продолжить",
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(fontWeight: FontWeight.bold,
                                              fontSize: 18)
                                      ),
                                      Container(
                                          height:MediaQuery.of(context).size.width*1.1/9
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: new InputDecoration(
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(color: Colors.teal)),
                                            // hintText: 'Tell us about yourself',
                                            labelText: 'Telefon',
                                            // prefixIcon: const Icon(
                                            //   Icons.confirmation_number_outlined,
                                            //   color: Colors.green,
                                            // ),
                                            prefixText: '+998',
                                            suffixStyle: const TextStyle(color: Colors.green)),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.width*1.6/9,
                                        width: MediaQuery.of(context).size.width*3.6/9,
                                        child:Padding(
                                          padding: EdgeInsets.all(10),
                                          child:InkWell(
                                            child: Container(
                                              child: Center(
                                                child:Text(
                                                  "Вход по почте",
                                                  style: TextStyle(color:MyColors.customBlue
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap:(){
                                              isRegistorFromPhone=false;
                                              isRegistered=false;
                                              setState2(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.width*1.6/9,
                                        width: MediaQuery.of(context).size.width*3.6/9,
                                        child:Padding(
                                          padding: EdgeInsets.all(10),
                                          child:InkWell(
                                            child: Container(
                                              child: Center(
                                                child:Text(
                                                  "Получить код",
                                                  style: TextStyle(color:Colors.white
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: MyColors.customBlue,
                                                  border: Border.all(color: Colors.black)
                                              ),
                                            ),
                                            onTap:(){

                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.all(15),
                              )
                          ),
                        ],
                      )
                  );
                  }else if(isRegistered){
                    return Container(
                        width : MediaQuery.of(context).size.width*8/9,
                        height : MediaQuery.of(context).size.width*11/9,
                        child: Column(
                          children: [
                            Flexible(
                                child:Padding(
                                  child:Container(
                                    height:MediaQuery.of(context).size.width*11/9 ,
                                    child: ListView(
                                      children:[
                                        Text(
                                            "Регистрация",
                                            textAlign: TextAlign.center,
                                            style: new TextStyle(fontWeight: FontWeight.bold,
                                                fontSize: 18)
                                        ),
                                        Container(
                                            height:MediaQuery.of(context).size.width*0.6/9
                                        ),
                                        TextField(
                                          keyboardType: TextInputType.text,
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(color: Colors.teal)),
                                              // hintText: 'Tell us about yourself',
                                              labelText: 'Имя',
                                              // prefixIcon: const Icon(
                                              //   Icons.confirmation_number_outlined,
                                              //   color: Colors.green,
                                              // ),
                                             // prefixText: '+998',
                                              suffixStyle: const TextStyle(color: Colors.green)),
                                        ),
                                        Container(
                                            height:MediaQuery.of(context).size.width*0.4/9
                                        ),
                                        TextField(
                                          keyboardType: TextInputType.emailAddress,
                                          //obscureText: true,
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(color: Colors.teal)),
                                              // hintText: 'Tell us about yourself',
                                              labelText: 'Электронная почта',
                                              // prefixIcon: const Icon(
                                              //   Icons.confirmation_number_outlined,
                                              //   color: Colors.green,
                                              // ),
                                             // prefixText: '+998',
                                              suffixStyle: const TextStyle(color: Colors.green)),
                                        ),
                                        Container(
                                            height:MediaQuery.of(context).size.width*0.4/9
                                        ),
                                        TextField(
                                          obscureText: true,
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(color: Colors.teal)),
                                              labelText: 'Пароль',

                                              suffixStyle: const TextStyle(color: Colors.green)),
                                        ),
                                        Container(
                                            height:MediaQuery.of(context).size.width*0.4/9
                                        ),
                                        TextField(
                                          obscureText: true,
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(color: Colors.teal)),
                                              labelText: 'Подтвердите пароль',

                                              suffixStyle: const TextStyle(color: Colors.green)),
                                        ),

                                        Container(
                                            height:MediaQuery.of(context).size.width*0.4/9
                                        ),
                                        Container(
                                          child: Center(
                                            child:RichText(
                                              text: TextSpan(
                                                style: defaultStyle,
                                                children: <TextSpan>[
                                                  TextSpan(text: 'Уже есть аккаунт? '),
                                                  TextSpan(
                                                      text: 'Войти',
                                                      style: linkStyle,
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () {
                                                          isRegistorFromPhone=false;
                                                          isRegistered=false;
                                                          setState2(() {});
                                                        }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height:MediaQuery.of(context).size.width*0.4/9
                                        ),
                                        Container(
                                          height: MediaQuery.of(context).size.width*1.6/9,
                                          width: MediaQuery.of(context).size.width*3.6/9,
                                          child:Padding(
                                            padding: EdgeInsets.all(10),
                                            child:InkWell(
                                              child: Container(
                                                child: Center(
                                                  child:Text(
                                                    "Зарегистрируйтесь",
                                                    style: TextStyle(color:Colors.white
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: MyColors.customBlue,
                                                    border: Border.all(color: Colors.black)
                                                ),
                                              ),
                                              onTap:(){

                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(15),
                                )
                            ),
                          ],
                        )
                    );
                  }else{
                    return Container(
                        width : MediaQuery.of(context).size.width*8/9,
                        height : MediaQuery.of(context).size.width*9.2/9,
                        child: Column(
                          children: [
                            Flexible(
                                child:Padding(
                                  child:Container(
                                    height:MediaQuery.of(context).size.width*9.2/9 ,
                                    child: ListView(
                                      children:[
                                        Text(
                                            "Войти в аккаунт",
                                            textAlign: TextAlign.center,
                                            style: new TextStyle(fontWeight: FontWeight.bold,
                                                fontSize: 18)
                                        ),
                                        Container(
                                            height:MediaQuery.of(context).size.width*0.6/9
                                        ),
                                        TextField(
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(color: Colors.teal)),
                                              // hintText: 'Tell us about yourself',
                                              labelText: 'Электронная почта',
                                              // prefixIcon: const Icon(
                                              //   Icons.confirmation_number_outlined,
                                              //   color: Colors.green,
                                              // ),
                                             // prefixText: '+998',
                                              suffixStyle: const TextStyle(color: Colors.green)),
                                        ),
                                        Container(
                                            height:MediaQuery.of(context).size.width*0.4/9
                                        ),
                                        TextField(
                                          obscureText: true,
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(color: Colors.teal)),
                                              // hintText: 'Tell us about yourself',
                                              labelText: 'Пароль',
                                              // prefixIcon: const Icon(
                                              //   Icons.confirmation_number_outlined,
                                              //   color: Colors.green,
                                              // ),
                                             // prefixText: '+998',
                                              suffixStyle: const TextStyle(color: Colors.green)),
                                        ),
                                        CheckboxListTile(
                                            controlAffinity: ListTileControlAffinity.leading,
                                            title: Text('Запомните меня'),
                                            value: monVal,
                                            onChanged: (bool value){
                                              setState2((){
                                                monVal = value;
                                              });
                                            },
                                          ),

                                        InkWell(
                                          child: Container(
                                            child: Center(
                                              child:Text(
                                                "Вход по номеру телефона",
                                                style: TextStyle(color:MyColors.customBlue
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap:(){
                                            isRegistered=false;
                                            isRegistorFromPhone=true;
                                            setState2(() {});
                                          },
                                        ),
                                        Container(
                                            height:MediaQuery.of(context).size.width*0.4/9
                                        ),
                                        Container(
                                          child: Center(
                                            child:RichText(
                                              text: TextSpan(
                                                style: defaultStyle,
                                                children: <TextSpan>[
                                                  TextSpan(text: 'У вас есть аккаунт? '),
                                                  TextSpan(
                                                      text: 'Зарегистрируйтесь',
                                                      style: linkStyle,
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () {
                                                          isRegistered=true;
                                                          isRegistorFromPhone=false;
                                                          setState2(() {});
                                                        }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height:MediaQuery.of(context).size.width*0.4/9
                                        ),
                                        Container(
                                          height: MediaQuery.of(context).size.width*1.6/9,
                                          width: MediaQuery.of(context).size.width*3.6/9,
                                          child:Padding(
                                            padding: EdgeInsets.all(10),
                                            child:InkWell(
                                              child: Container(
                                                child: Center(
                                                  child:Text(
                                                    "Получить код",
                                                    style: TextStyle(color:Colors.white
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: MyColors.customBlue,
                                                    border: Border.all(color: Colors.black)
                                                ),
                                              ),
                                              onTap:(){

                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(15),
                                )
                            ),
                          ],
                        )
                    );
                  }
                })
        )
    );
  }

  void showPricedropDialog(){
    showDialog(
        context: context,
        builder: (BuildContext conte) => new AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(
                    Radius.circular(10.0))),
            content:  StatefulBuilder(
                builder: (BuildContext context, StateSetter setState2){
                  return Container(
                      width : MediaQuery.of(context).size.width*8/9,
                      height : MediaQuery.of(context).size.height*3.5/9,
                      child: Column(
                        children: [
                          Flexible(
                              child:Padding(
                                child:Container(
                                  height:MediaQuery.of(context).size.height*6.1/9 ,
                                  child: ListView(
                                    children:[
                                      Container(
                                          height:MediaQuery.of(context).size.width*0.5/9
                                      ),
                                      Text(
                                          "Узнайте о снижении цены",
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(fontWeight: FontWeight.bold,
                                              fontSize: 18)
                                      ),
                                      Text(
                                          "Оставьте почту и мы напишем, когда цена товара снизится",
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontSize: 16)
                                      ),
                                      Container(
                                          height:MediaQuery.of(context).size.width*0.7/9
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: new InputDecoration(
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(color: Colors.teal)),
                                            // hintText: 'Tell us about yourself',
                                            labelText: 'Почта',
                                            suffixStyle: const TextStyle(color: Colors.green)),
                                      ),
                                      Container(
                                          height:MediaQuery.of(context).size.width*0.4/9
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.width*1.6/9,
                                        width: MediaQuery.of(context).size.width*3.6/9,
                                        child:Padding(
                                          padding: EdgeInsets.all(10),
                                          child:InkWell(
                                            child: Container(
                                              child: Center(
                                                child:Text(
                                                  "Готово",
                                                  style: TextStyle(color:Colors.white
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: MyColors.customBlue,
                                                  border: Border.all(color: Colors.black)
                                              ),
                                            ),
                                            onTap:(){},
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.all(15),
                              )
                          ),
                        ],
                      )
                  );
                })
        )
    );
  }

  Widget _getFooter(int price,bool isAvailable){
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: MyColors.mischka, width: 1)),
      ),
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child:clicked ? Row(
          children:[
            Expanded(
              flex:7,
              child:RaisedButton(
               // padding: EdgeInsets.all(12),
                color: MyColors.customBlue,
                textColor: MyColors.white,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage(updateCarts: widget.updateCarts,)),
                  );
                },//isAvailable ? (){}:null,
                child: Container(
                  margin: EdgeInsets.all(6),
                  child:Text(
                    "В корзине "+pieces.toString()+" шт.\n"+"Перейти в корзину",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ),
            ),Expanded(
              flex:3,
              child:RaisedButton(
                padding: EdgeInsets.all(12),
                color: MyColors.green,
                textColor: MyColors.white,
                onPressed: (){
                  pieces=pieces+1;
                  cartSave.pieces=pieces;
                  sharedPref.save(cartSave,widget.updateCarts);
                 // widget.updateCarts(0);
                  setState(() {

                  });
                },//isAvailable ? (){}:null,
                child:Text(
                    "+",
                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23),
                  ),
              ),
            ),

          ]
        ):RaisedButton(
          color: MyColors.customBlue,
          textColor: MyColors.white,
          onPressed: (){
            clicked=true;
            pieces=pieces+1;
            cartSave.pieces=pieces;
            sharedPref.save(cartSave,widget.updateCarts);

          },
          child: Text(
            "Добавить в корзину",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget __getAppBarButton(IconData icon, Function onTap,{color = Colors.white}){
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Icon(icon, color: color),
      ),
    );
  }

  void open(BuildContext context, final int index,galleryItems) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
          initialIndex: index,
          scrollDirection: verticalGallery ? Axis.vertical : Axis.horizontal,
        ),
      ),
    );
  }

  double calculatorPrice(double priceLower, double priceHigher) =>
      (priceLower / priceHigher * 100 * (-1));
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    @required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder loadingBuilder;
  final BoxDecoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final  galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
   int currentIndex ;//= widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
   @override
   void initState(){
     currentIndex = widget.initialIndex;
     super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyColors.bigStone,),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image ${currentIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index){
  //  final GalleryExampleItem item = widget.galleryItems[index];
    return true//item.isSvg
        ? PhotoViewGalleryPageOptions.customChild(
      child: CachedNetworkImage(
        imageUrl: Config.filesUrl + widget.galleryItems[index],
        fit: BoxFit.cover,
      ),
      childSize: const Size(300, 300),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
   //   heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    ) : PhotoViewGalleryPageOptions(
   //   imageProvider: AssetImage(item.resource),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
  //    heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}