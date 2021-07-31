import 'dart:convert';

class RecommendedProductsResponseModel {
  RecommendedProductsResponseModel({
    this.data,
    this.success,
    this.status,
  });

  final List<RecomendedProductModel> data;
  final bool success;
  final num  status;

  RecommendedProductsResponseModel copyWith({
    List<RecomendedProductModel> data,
    bool success,
    num status,
  }) =>
      RecommendedProductsResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        status: status ?? this.status,
      );

  factory RecommendedProductsResponseModel.fromJson(String str) =>
      RecommendedProductsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecommendedProductsResponseModel.fromMap(Map<String, dynamic> json) =>
      RecommendedProductsResponseModel(
        data: List<RecomendedProductModel>.from(json["data"].map((x) => RecomendedProductModel.fromMap(x))),
        success: json["success"].toString()=="null"? json["success"]:true,
        status:json["status"].toString()=="null"? json["status"] :200,
      );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "success": success,
    "status": status,
  };
}

class RecomendedProductModel {
  RecomendedProductModel({
    this.id,
    this.title,
    this.start_date,
    this.end_date,
    this.status,
    this.featured,
    this.background_color,
    this.dark,
    this.banner,
    this.slug,
    this.created_at,
    this.updated_at,
    this.user_id,
    this.on_moderation,
  });

  final num id;
  final String title;
  final num start_date;
  final num end_date;
  final num status;
  final num featured;
  final String background_color;
  final String dark;
  final String banner;
  final String slug;
  final String created_at;
  final String updated_at;
  final num user_id;
  final num on_moderation;


  RecomendedProductModel copyWith({
    num id,
    String title,
    num start_date,
    num end_date,
    num status,
    num featured,
    String background_color,
    String dark,
    String banner,
    String slug,
    String created_at,
    String updated_at,
    num user_id,
    num on_moderation,
  }) =>
      RecomendedProductModel(
        id: id ?? this.id,
        title: title ?? this.title,
        start_date: start_date ?? this.start_date,
        end_date: end_date ?? this.end_date,
        status: status ?? this.status,
        featured: featured ?? this.featured,
        background_color: background_color ?? this.background_color,
        dark: dark ?? this.dark,
        banner: banner ?? this.banner,
        slug: slug ?? this.slug,
        created_at: created_at ?? this.created_at,
        updated_at: updated_at ?? this.updated_at,
        user_id: user_id ?? this.user_id,
        on_moderation: on_moderation ?? this.on_moderation,
      );

  factory RecomendedProductModel.fromJson(String str) =>
      RecomendedProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecomendedProductModel.fromMap(Map<String, dynamic> json) => RecomendedProductModel(
    id: json["id"],
    title: json["title"],
    start_date: json["start_date"],
    end_date: json["end_date"],
    status: json["status"],
    featured: json["featured"],
    background_color: json["background_color"],
    dark: json["dark"],
    banner: json["banner"],
    slug: json["slug"],
    created_at:json["created_at"] ,
    updated_at: json["updated_at"],
    user_id: json["user_id"],
    on_moderation: json["on_moderation"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "start_date": start_date,
    "end_date": end_date,
    "status": status,
    "featured": featured,
    "background_color": background_color,
    "dark": dark,
    "banner": banner,
    "slug": slug,
    "created_at": created_at,
    "updated_at": updated_at,
    "user_id": user_id,
    "on_moderation": on_moderation,
  };
}


