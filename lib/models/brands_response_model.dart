import 'dart:convert';

class BrandsResponseModel{
  BrandsResponseModel({
    this.data,
    this.success,
    this.status,
  });

  final List<Datum> data;
  final bool success;
  final int status;

  BrandsResponseModel copyWith({
    List<Datum> data,
    bool success,
    int status,
  }) =>
      BrandsResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        status: status ?? this.status,
      );

  factory BrandsResponseModel.fromJson(String str) =>
      BrandsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrandsResponseModel.fromMap(Map<String, dynamic> json) =>
      BrandsResponseModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "success": success,
        "status": status,
      };
}

class Datum {
  Datum({
    this.name,
    this.logo,
    this.links,
    this.slug,
  });

  final String name;
  final String logo;
  final String slug;
  final Links links;

  Datum copyWith({
    String name,
    String logo,
    String slug,
    Links links,
  }) =>
      Datum(
        name: name ?? this.name,
        logo: logo ?? this.logo,
        slug: slug ?? this.slug,
        links: links ?? this.links,
      );

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        name: json["name"],
        logo: json["logo"],
        slug: json["slug"],
        links: Links.fromMap(json["links"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "logo": logo,
        "slug": slug,
        "links": links.toMap(),
      };
}

class Links {
  Links({
    this.products,
  });

  final String products;

  Links copyWith({
    String products,
  }) =>
      Links(
        products: products ?? this.products,
      );

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        products: json["products"],
      );

  Map<String, dynamic> toMap() => {
        "products": products,
      };
}
