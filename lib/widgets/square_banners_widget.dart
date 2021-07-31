import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/widgets/cache_image_widget.dart';

import 'package:untitled2/service/banner/banner_repository.dart';
import 'package:untitled2/service/banner/cubit/banner_cubit.dart';

import 'package:shimmer/shimmer.dart';

class SquareBannersWidget extends StatelessWidget {
  SquareBannersWidget({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  final bannersRepository = BannersRepository();

  @override
  Widget build(BuildContext context){
    return Column(children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: MyColors.mirage,
          ),
        ),
      ),
      BlocProvider<BannerCubit>(
        create: (context) => BannerCubit(bannersRepository)..fetchBanners(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<BannerCubit, BannerState>(
            builder: (context, state){
              // final BannerCubit shopBannerCubit = context.watch<BannerCubit>();
              if (state is BannerInitial || state is BannerLoadingState){
                return Wrap(
                  children: List.generate(
                    3,
                    (index) => Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width / 3.2,
                          height: MediaQuery.of(context).size.width / 3.2,
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
                      ],
                    ),
                  ),
                );
              }else
                if(state is BannerLoadedState){
                 // print("WR="+state.runtimeType.toString());
                var banners = state.banner.bannerSquare.data;
                for(int c=0;c<banners.length;c++){
                  //   print("banners="+state.banner.toJson().toString());
                  print("banners2="+banners[c].url+banners[c].photo);
                }
                return Wrap(
                  children: List.generate(
                    banners.length,
                    (index) => Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width / 3.2,
                          height: MediaQuery.of(context).size.width / 3.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              child: CacheImageWidget(
                                url: banners[index].url+"/"+banners[index].photo,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }else{
                print("WrapError");
                return Wrap(
                  children: List.generate(
                    15,
                        (index) => Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width / 3.2,
                          height: MediaQuery.of(context).size.width / 3.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              child: Container(color: MyColors.customBlue,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    ]);
  }
}
