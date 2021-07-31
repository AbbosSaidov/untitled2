import 'dart:convert';

import 'package:untitled2/models/sub_categories_model.dart';

class CategoryResponseModel{
  CategoryResponseModel({
    this.data,
    this.success,
    this.status,
    this.category,
    this.filter,
  });

  final List<CategoryModel> data;
  final bool success;
  final int status;
  final SubCategoryModel category;
  final Filter filter;

  CategoryResponseModel copyWith({
    List<CategoryModel> data,
    bool success,
    int status,
    SubCategoryModel category,
    Filter filter,
  }) =>
      CategoryResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        status: status ?? this.status,
        category: category ?? this.category,
        filter: filter ?? this.filter,
      );

  factory CategoryResponseModel.fromJson(String str) =>
      CategoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryResponseModel.fromMap(Map<String, dynamic> json) =>
      CategoryResponseModel(
        data: List<CategoryModel>.from(
            json["data"].map((x) => CategoryModel.fromMap(x))),
        success: json["success"],
        status: json["status"],
        category: json["category"]!=null ? SubCategoryModel.fromMap(json["category"]):null ,
        filter: json["filter"]!=null ? Filter.fromMap(json["filter"]):null ,
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "success": success,
        "status": status,
        "category": status,
      };
}

class CategoryModel{
  CategoryModel({
    this.id,
    this.name,
    this.banner,
    this.icon,
    this.links,
    this.slug,
    this.featured,
  });

  final int id;
  final String name;
  final String banner;
  final String slug;
  final String icon;
  final Links links;
  final num featured;

  CategoryModel copyWith({
    int id,
    String name,
    String banner,
    String slug,
    String icon,
    Links links,
    num featured,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        banner: banner ?? this.banner,
        icon: icon ?? this.icon,
        links: links ?? this.links,
        featured: featured ?? this.featured,
      );

  factory CategoryModel.fromJson(String str) =>
      CategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        banner: json["banner"],
        icon: json["icon"],
    featured: json["featured"],
        links: json["links"]!=null ? Links.fromMap(json["links"]):null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "slug": slug,
        "banner": banner,
        "icon": icon,
        "featured": featured,
        "links": links.toMap(),
      };
}

class Links {
  Links({
    this.products,
    this.subCategories,
  });

  final String products;
  final String subCategories;

  Links copyWith({
    String products,
    String subCategories,
  }) =>
      Links(
        products: products ?? this.products,
        subCategories: subCategories ?? this.subCategories,
      );

  factory Links.fromJson(String str)=>Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        products: json["products"],
        subCategories: json["sub_categories"],
      );

  Map<String, dynamic> toMap() => {
        "products": products,
        "sub_categories": subCategories,
      };
}
