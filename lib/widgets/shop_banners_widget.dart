import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/widgets/cache_image_widget.dart';
import 'package:untitled2/service/banner/banner_repository.dart';
import 'package:untitled2/service/banner/cubit/banner_cubit.dart';

import 'package:shimmer/shimmer.dart';

class ShopBannersWidget extends StatefulWidget{
  ShopBannersWidget({Key key,@required this.type,this.slug}) : super(key: key);
  final String type;
  final String slug;
  @override
  _ShopBannersWidgetState createState() => _ShopBannersWidgetState();
}

class _ShopBannersWidgetState extends State<ShopBannersWidget>{
  int _currentBanner = 0;
  final bannersRepository = BannersRepository();

  @override
  Widget build(BuildContext context){
    return BlocProvider<BannerCubit>(
      create: (context) => _initType(),
      child: Container(
        padding: EdgeInsets.all(10),
        child: BlocBuilder<BannerCubit, BannerState>(
          builder: (context, state){
            //print("st="+state.runtimeType.toString());
            // final BannerCubit shopBannerCubit = context.watch<BannerCubit>();
            if (state is BannerInitial || state is BannerLoadingState){
              return Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 150,
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason){
                        setState((){
                          _currentBanner = index;
                        });
                      },
                    ),
                    items: List.generate(
                      3,
                          (index) => Container(
                        width: double.infinity,
                        child: Shimmer.fromColors(
                          baseColor: MyColors.shimmerBaseColor,
                          highlightColor: MyColors.shimmerHighlightColor,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                              (index) => Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 2,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentBanner == index
                                  ? MyColors.white
                                  : MyColors.iron,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else
            if(state is BannerLoadedState){
              var banners = state.banner.sliders.data;
              //  for(int c=0;c<banners.length;c++){
              //    //   print("banners="+state.banner.toJson().toString());
              //   // print("bannershori="+banners[c].url+banners[c].photo);
              //  }
              return Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 160,
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                      onPageChanged:(index, reason){
                        setState((){
                          _currentBanner = index;
                        });
                      },
                    ),
                    items: List.generate(
                      banners.length,
                          (index) => Container(
                        width: double.infinity,
                       child: InkWell(
                         child: CacheImageWidget(
                           url: banners[index].photo,
                           fit: BoxFit.fill,
                         ),
                       ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          6,
                              (index) => Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 2,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentBanner == index
                                  ? MyColors.white
                                  : MyColors.iron,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else if(state is BannerMainState){
             // print("photourl="+state.banner["data"].toString());
                return Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 120,
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        onPageChanged:(index, reason){
                          setState((){
                            _currentBanner = index;
                          });
                        },
                      ),
                      items: List.generate(
                        state.banner["data"][0]["sliders"].length,
                            (index) => Container(
                          width: double.infinity,
                          child: InkWell(
                            child: CacheImageWidget(
                                url: state.banner["data"][0]["sliders"][index].toString(),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width,
                      bottom: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            state.banner["data"][0]["sliders"].length,
                                (index) => Container(
                              width: 8,
                              height: 8,
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 2,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentBanner == index
                                    ? MyColors.white
                                    : MyColors.iron,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }else{
              return Container();
            }
          },
        ),
      ),
    );
  }
  BannerCubit _initType(){
    BannerCubit repo = BannerCubit(bannersRepository);
    //print("type="+repo.state.runtimeType.toString());
    print("type1="+widget.type.toString());

    switch (widget.type){
      case 'fetchBanners':
        return repo..fetchBanners();
      case 'fetchBannersMain':
        return repo..fetchBannersMain(widget.slug);
      default:
        return repo;
    }
  }
}
