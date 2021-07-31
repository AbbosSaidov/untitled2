// To parse this JSON data, do
//
//     final wishlistModel = wishlistModelFromJson(jsonString);

import 'dart:convert';

import 'package:untitled2/models/products_response.dart';


class WishlistModel{
  WishlistModel({
    this.id,
    this.product_id,
    this.name,
    this.slug,
    this.thumbnail_image,
    this.base_price,
    this.base_discounted_price,
    this.exchange_rate,
    this.rating,
    this.currency_code,
    this.unit,
    this.links,
  });

  final num id;
  final num product_id;
  final String name;
  final String slug;
  final String thumbnail_image;
  final num base_price;
  final num base_discounted_price;
  final num exchange_rate;
  final num rating;
  final String currency_code;
  final String unit;
  final Links links;

  WishlistModel copyWith({
    num id,
    num product_id,
    String name,
    String slug,
    String thumbnail_image,
    num base_price,
    num base_discounted_price,
    num exchange_rate,
    num rating,
    String currency_code,
    String unit,
    Links links,
  }) =>
      WishlistModel(
        id: id ?? this.id,
        product_id: product_id ?? this.product_id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        thumbnail_image: thumbnail_image ?? this.thumbnail_image,
        base_price: base_price ?? this.base_price,
        base_discounted_price: base_discounted_price ?? this.base_discounted_price,
        exchange_rate: exchange_rate ?? this.exchange_rate,
        rating: rating ?? this.rating,
        currency_code: currency_code ?? this.currency_code,
        unit: unit ?? this.unit,
        links: links ?? this.links,
      );

  factory WishlistModel.fromJson(String str) =>
      WishlistModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WishlistModel.fromMap(Map<String, dynamic> json) =>
      WishlistModel(
        id: json["id"],
        product_id: json["product_id"],
        name:json["name"],
        slug:json["slug"],
        thumbnail_image:json["thumbnail_image"],
        base_price:json["base_price"],
        base_discounted_price:json["base_discounted_price"],
        exchange_rate:json["exchange_rate"],
        rating:json["rating"],
        currency_code:json["currency_code"],
        unit:json["unit"],
        links: Links.fromMap(json["links"]),
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": product_id,
    "name": name,
    "slug": slug,
    "thumbnail_image": thumbnail_image,
    "base_price": base_price,
    "base_discounted_price": base_discounted_price,
    "exchange_rate": exchange_rate,
    "rating": rating,
    "currency_code": currency_code,
    "unit": unit,
    "links": links,
  };
}


