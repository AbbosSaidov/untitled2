import 'dart:convert';

class BannersResponseModel {
  BannersResponseModel({
    this.sliders,
    this.bannerHorizontal,
    this.bannerVertical,
    this.bannerSquare,
  });

  final Sliders sliders;
  final Banner bannerHorizontal;
  final Banner bannerVertical;
  final Banner bannerSquare;

  factory BannersResponseModel.fromJson(String str) =>
      BannersResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BannersResponseModel.fromMap(Map<String, dynamic> json) =>
      BannersResponseModel(
        sliders: Sliders.fromMap(json["sliders"]),
        bannerHorizontal: Banner.fromMap(json["bannerHorizontal"]),
        bannerVertical: Banner.fromMap(json["bannerVertical"]),
        bannerSquare: Banner.fromMap(json["bannerSquare"]),
      );

  Map<String, dynamic> toMap() => {
        "sliders": sliders.toMap(),
        "bannerHorizontal": bannerHorizontal.toMap(),
        "bannerVertical": bannerVertical.toMap(),
        "bannerSquare": bannerSquare.toMap(),
      };
}

class Banner {
  Banner({
    this.data,
  });

  final List<BannerHorizontalDatum> data;

  factory Banner.fromJson(String str) => Banner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Banner.fromMap(Map<String, dynamic> json) => Banner(
        data: List<BannerHorizontalDatum>.from(
            json["data"].map((x) => BannerHorizontalDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class BannerHorizontalDatum {
  BannerHorizontalDatum({
    this.photo,
    this.url,
    this.position,
  });

  final String photo;
  final String url;
  final int position;

  factory BannerHorizontalDatum.fromJson(String str) =>
      BannerHorizontalDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BannerHorizontalDatum.fromMap(Map<String, dynamic> json) =>
      BannerHorizontalDatum(
        photo: json["photo"],
        url: json["url"],
        position: json["position"],
      );

  Map<String, dynamic> toMap() => {
        "photo": photo,
        "url": url,
        "position": position,
      };
}

class Sliders {
  Sliders({
    this.data,
  });

  final List<SlidersDatum> data;

  factory Sliders.fromJson(String str) => Sliders.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Sliders.fromMap(Map<String, dynamic> json) => Sliders(
        data: List<SlidersDatum>.from(
            json["data"].map((x) => SlidersDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class SlidersDatum {
  SlidersDatum({
    this.photo,
    this.link,
  });

  final String photo;
  final String link;

  factory SlidersDatum.fromJson(String str) =>
      SlidersDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SlidersDatum.fromMap(Map<String, dynamic> json) => SlidersDatum(
        photo: json["photo"],
        link: json["link"],
      );

  Map<String, dynamic> toMap() => {
        "photo": photo,
        "link": link,
      };
}
