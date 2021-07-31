import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/utils/colors.dart';
import 'package:untitled2/config.dart';
import 'package:shimmer/shimmer.dart';

class CacheImageWidget extends StatelessWidget {
  CacheImageWidget({
    Key key,
    this.url = "",
    this.height,
    this.fit,
    this.shape,
  }) : super(key: key);

  final String url;
  final double height;
  final BoxFit fit;
  final BoxShape shape;

  @override
  Widget build(BuildContext context){
    final defaultImg = 'assets/default-image.png';
    if (url != null && url.isNotEmpty){
      return CachedNetworkImage(
        height: height,
        imageUrl:url.contains("http")?url: "${Config.filesUrl}$url",
        errorWidget: (context, url, error) => Image.asset(
          defaultImg,
          height: height,
          fit: BoxFit.cover,
        ),
        imageBuilder:(context, imageProvider)=>Container(
          decoration: BoxDecoration(
            shape:shape != null ? shape :BoxShape.rectangle,
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        placeholder:(context, url) => Shimmer.fromColors(
          baseColor: MyColors.shimmerBaseColor,
          highlightColor: MyColors.shimmerHighlightColor,
          child: Container(color: Colors.white),
        ),
      );
    }else{
      print("eroroimage="+shape.toString());
      if(shape != null){
        return Container(
          height: height,
          width: height,

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: Image.asset(
                  defaultImg,
                  fit: BoxFit.contain,
                ).image,
                fit: BoxFit.cover
            ),
          ),
        );
      }else{
        return Container(
          height: height,
          width: height,

          child: Image.asset(
            defaultImg,
            fit: BoxFit.cover,
          ),
          decoration: BoxDecoration(
            color: Colors.red,
            shape:shape != null ? shape :BoxShape.rectangle,
          ),
        );
      }

    }
  }
}
