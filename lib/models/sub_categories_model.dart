import 'dart:convert';

import 'package:untitled2/models/category_response.dart';

class SubCategoriesModel{
  SubCategoriesModel({
  //  this.data,
    this.success,
    this.status,
  //  this.filter,
    this.category,
});
 // final List<CategoryModel> data;
  final bool success;
  final num status;
 // final Filter filter;
  final SubCategoryModel category;

  SubCategoriesModel copyWith({
    //  List<CategoryModel> data,
    bool success,
    num status,
    //  Filter filter,
    SubCategoryModel category,
  })=>SubCategoriesModel(
    //  data:data??this.data,
    success:success??this.success,
    status:status??this.status,
    //  filter:filter??this.filter,
    category:category??this.category,
  );
  
  factory SubCategoriesModel.fromJson(String str)=>
      SubCategoriesModel.fromMap(json.decode(str));
  
 // String toJson()=>json.encode(toMap());
  
  factory SubCategoriesModel.fromMap(Map<String, dynamic>json)=>
  SubCategoriesModel(
        // data:List<CategoryModel>.from(json["data"].map((x)=>CategoryModel.fromMap(x))),
        success: json["success"],
        status: json["status"],
        // filter:Filter.fromJson(json["filter"]) ,
        category: SubCategoryModel.fromMap(json["category"]) ,
      );
  Map<String, dynamic> toMap()=>{
   // "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "success": success,
    "status": status,
  //  "filter": filter,
    "category": category,
  };
}

class Filter{
  final headers;
  final original;
  final exception;

  Filter({this.headers, this.original, this.exception});

  Filter copyWith({
    headers,
    original,
    exception,
  })=>Filter(
    headers:headers??this.headers,
    original:original??this.original,
    exception:exception??this.exception,
  );
  factory Filter.fromJson(String str)=>
      Filter.fromMap(json.decode(str));

  String toJson()=>json.encode(toMap());

  factory Filter.fromMap(Map<String, dynamic>json)=>
      Filter(
        headers:json["headers"],
        original:Original.fromMap(json["original"]),
        exception:json["exception"] ,
      );
  Map<String, dynamic> toMap() => {
    "headers": headers,
    "original": original,
    "exception": exception,
  };
}
class Original{
  final products;
  final attributes;

  Original({this.products, this.attributes});

  Original copyWith({
    products,
    attributes,
  })=>Original(
    products:products??this.products,
    attributes:attributes??this.attributes,
  );
  factory Original.fromJson(String str)=>
      Original.fromMap(json.decode(str));

  String toJson()=>json.encode(toMap());

  factory Original.fromMap(Map<String, dynamic>json)=>
      Original(
       // products:json["products"],
        //attributes:Attributes.fromMap(json["attributes"]),
        attributes:List<Attributes>.from(json["attributes"].map((x)=>Attributes.fromMap(x))),
      );
  Map<String, dynamic> toMap() => {
    //"products": products,
    "attributes": attributes,
  };
}
class Attributes{
  final id;
  final values;
  final attr;

  Attributes({this.id, this.values, this.attr});

  Attributes copyWith({
    id,
    values,
    attr,
  })=>Attributes(
    id:id??this.id,
    values:values??this.values,
    attr:attr??this.attr,
  );
  factory Attributes.fromJson(String str)=>
      Attributes.fromMap(json.decode(str));

  String toJson()=>json.encode(toMap());

  factory Attributes.fromMap(Map<String, dynamic>json)=>
      Attributes(
        id:json["id"],
        values:json["values"],
        attr:Attr.fromMap(json["attr"]),
      );
  Map<String, dynamic> toMap() => {
    "id": id,
    "values": values,
    "attr": attr,
  };
}
class Attr{
  final id;
  final name;
  final created_at;
  final updated_at;

  Attr({this.id, this.name, this.created_at, this.updated_at});

  Attr copyWith({
    id,
    name,
    created_at,
    updated_at,
  })=>Attr(
    id:id??this.id,
    name:name??this.name,
    created_at:created_at??this.created_at,
    updated_at:updated_at??this.updated_at,
  );
  factory Attr.fromJson(String str)=>
      Attr.fromMap(json.decode(str));

  String toJson()=>json.encode(toMap());

  factory Attr.fromMap(Map<String, dynamic>json)=>
      Attr(
        id:json["id"],
        name:json["name"],
        created_at:json["created_at"],
        updated_at:json["updated_at"],
      );
  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "created_at": created_at,
    "updated_at": updated_at,
  };
}
class SubCategoryModel{
  final id;
  final parent_id;
  final level;
  final name;
  final commision_rate;
  final banner;
  final icon;
  final featured;
  final top;
  final digital;
  final slug;
  final meta_title;
  final meta_description;
  final created_at;
  final updated_at;
  final t_lft;
  final t_rgt;
  final tag;
  final brands;
  final min_price;
  final max_price;
  final breadcrumbs;

  SubCategoryModel({this.id, this.parent_id, this.level,
    this.name, this.commision_rate, this.banner, this.icon,
    this.featured,this.top,this.digital,this.slug
    ,this.meta_title,this.meta_description,this.created_at,this.updated_at
    ,this.t_lft,this.t_rgt,this.tag,this.brands,this.min_price,this.max_price,this.breadcrumbs
  });

  SubCategoryModel copyWith({
    id,
    parent_id,
    level,
    name,
    commision_rate,
    banner,
    icon,
    featured,
    top,
    digital,
    slug,
    meta_title,
    meta_description,
    created_at,
    updated_at,
    t_lft,
    t_rgt,
    tag,
    brands,
    min_price,
    max_price,
    breadcrumbs,
  })=>SubCategoryModel(
    id:id??this.id,
    parent_id:parent_id??this.parent_id,
    level:level??this.level,
    name:name??this.name,
    commision_rate:commision_rate??this.commision_rate,
    banner:banner??this.banner,
    icon:icon??this.icon,
    featured:featured??this.featured,
    top:top??this.top,
    digital:digital??this.digital,
    slug:slug??this.slug,
    meta_title:meta_title??this.meta_title,
    meta_description:meta_description??this.meta_description,
    created_at:created_at??this.created_at,
    updated_at:updated_at??this.updated_at,
    t_lft:t_lft??this.t_lft,
    t_rgt:t_rgt??this.t_rgt,
    tag:tag??this.tag,
    brands:brands??this.brands,
    min_price:min_price??this.min_price,
    max_price:max_price??this.max_price,
    breadcrumbs:breadcrumbs??this.breadcrumbs,
  );
  factory SubCategoryModel.fromJson(String str)=>
      SubCategoryModel.fromMap(json.decode(str));

  String toJson()=>json.encode(toMap());

  factory SubCategoryModel.fromMap(Map<String, dynamic>json)=>
      SubCategoryModel(
        id:json["id"],
        parent_id:json["parent_id"],
        level:json["level"],
        name:json["name"],
        commision_rate:json["commision_rate"],
        banner:json["banner"],
        icon:json["icon"],
        featured:json["featured"],
        top:json["top"],
        digital:json["digital"],
        slug:json["slug"],
        meta_title:json["meta_title"],
        created_at:json["created_at"],
        updated_at:json["updated_at"],
        t_lft:json["_lft"],
        t_rgt:json["_rgt"],
        tag:json["tag"],
        brands:json["brands"],
        min_price:json["min_price"],
        max_price:json["max_price"],
        breadcrumbs:json["breadcrumbs"],
      );
  Map<String, dynamic> toMap()=>{
    "id": id,
    "parent_id": parent_id,
    "level": level,
    "name": name,
    "commision_rate": commision_rate,
    "banner": banner,
    "icon": icon,
    "featured": featured,
    "top": top,
    "digital": digital,
    "slug": slug,
    "meta_title": meta_title,
    "meta_description": meta_description,
    "created_at": created_at,
    "updated_at": updated_at,
    "_lft": t_lft,
    "_rgt": t_rgt,
    "tag": tag,
    "brands": brands,
    "min_price": min_price,
    "breadcrumbs": breadcrumbs,
  };
}