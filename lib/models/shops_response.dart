import 'dart:convert';

class ShopsResponseModel {
  ShopsResponseModel({
    this.data,
    this.success,
    this.status,
  });

  final List<Shop> data;
  final bool success;
  final int status;

  ShopsResponseModel copyWith({
    List<Shop> data,
    bool success,
    int status,
  }) =>
      ShopsResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        status: status ?? this.status,
      );

  factory ShopsResponseModel.fromJson(String str) =>
      ShopsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShopsResponseModel.fromMap(Map<String, dynamic> json) =>
      ShopsResponseModel(
        data: json["data"] !=null ? List<Shop>.from(json["data"].map((x) => Shop.fromMap(x))):null,
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "success": success,
        "status": status,
      };
}

class Shop {
  Shop({
    this.name,
    this.user,
    this.logo,
    this.sliders,
    this.address,
    this.facebook,
    this.google,
    this.twitter,
    this.slug,
    this.youtube,
    this.instagram,
    this.links,
  });

  final String name;
  final User user;
  final String logo;
  final List<String> sliders;
  final String address;
  final String slug;
  final String facebook;
  final String google;
  final String twitter;
  final String youtube;
  final dynamic instagram;
  final Links links;

  Shop copyWith({
    String name,
    User user,
    String logo,
    List<String> sliders,
    String address,
    String facebook,
    String slug,
    String google,
    String twitter,
    String youtube,
    dynamic instagram,
    Links links,
  }) =>
      Shop(
        name: name ?? this.name,
        user: user ?? this.user,
        logo: logo ?? this.logo,
        sliders: sliders ?? this.sliders,
        address: address ?? this.address,
        facebook: facebook ?? this.facebook,
        slug: slug ?? this.slug,
        google: google ?? this.google,
        twitter: twitter ?? this.twitter,
        youtube: youtube ?? this.youtube,
        instagram: instagram ?? this.instagram,
        links: links ?? this.links,
      );

  factory Shop.fromJson(String str) => Shop.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Shop.fromMap(Map<String, dynamic> json) => Shop(
        name: json["name"],
        user: User.fromMap(json["user"]),
        logo: json["logo"],
         slug: json["slug"],
        sliders: List<String>.from(json["sliders"].map((x) => x)),
        address: json["address"],
        facebook: json["facebook"],
        google: json["google"],
        twitter: json["twitter"],
        youtube: json["youtube"],
        instagram: json["instagram"],
        links: Links.fromMap(json["links"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "user": user.toMap(),
        "logo": logo,
        "slug": slug,
        "sliders": List<dynamic>.from(sliders.map((x) => x)),
        "address": address,
        "facebook": facebook,
        "google": google,
        "twitter": twitter,
        "youtube": youtube,
        "instagram": instagram,
        "links": links.toMap(),
      };
}

class Links {
  Links({
    this.featured,
    this.top,
    this.linksNew,
    this.all,
    this.brands,
  });

  final String featured;
  final String top;
  final String linksNew;
  final String all;
  final String brands;

  Links copyWith({
    String featured,
    String top,
    String linksNew,
    String all,
    String brands,
  }) =>
      Links(
        featured: featured ?? this.featured,
        top: top ?? this.top,
        linksNew: linksNew ?? this.linksNew,
        all: all ?? this.all,
        brands: brands ?? this.brands,
      );

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        featured: json["featured"],
        top: json["top"],
        linksNew: json["new"],
        all: json["all"],
        brands: json["brands"],
      );

  Map<String, dynamic> toMap() => {
        "featured": featured,
        "top": top,
        "new": linksNew,
        "all": all,
        "brands": brands,
      };
}

class User {
  User({
    this.name,
    this.email,
    this.avatar,
    this.avatarOriginal,
  });

  final String name;
  final String email;
  final String avatar;
  final dynamic avatarOriginal;

  User copyWith({
    String name,
    String email,
    String avatar,
    dynamic avatarOriginal,
  }) =>
      User(
        name: name ?? this.name,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        avatarOriginal: avatarOriginal ?? this.avatarOriginal,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        avatarOriginal: json["avatar_original"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "avatar": avatar,
        "avatar_original": avatarOriginal,
      };
}
