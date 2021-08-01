import 'dart:convert';

class ProductDetailResponse{
  ProductDetailResponse({
    this.data,
    this.success,
    this.status,
  });

  final ProductDetailModel data;
  final bool success;
  final int status;

  ProductDetailResponse copyWith({
    ProductDetailModel data,
    bool success,
    int status,
  }) =>
      ProductDetailResponse(
        data: data ?? this.data,
        success: success ?? this.success,
        status: status ?? this.status,
      );

  factory ProductDetailResponse.fromJson(String str) =>
      ProductDetailResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDetailResponse.fromMap(Map<String, dynamic> json) =>
      ProductDetailResponse(
        data: ProductDetailModel.fromMap(json["data"]),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toMap()=>{
        "data": data,
        "success": success,
        "status": status,
      };
}
class ProductDetailModel {
  ProductDetailModel({
    this.id,
    this.name,
    this.addedBy,
    this.user,
    this.brand,
    this.variations,
    this.photos,
    this.colorNumber,
    this.thumbnailImage,
    this.tag,
    this.priceLower,
    this.priceHigher,
    this.choiceOptions,
    this.selers,
    this.variant,
    this.colors,
    this.todaysDeal,
    this.featured,
    this.currentStock,
    this.characteristics,
    this.unit,
    this.discount,
    this.discountType,
    this.tax,
    this.taxType,
    this.shippingType,
    this.shippingCost,
    this.numberOfSales,
    this.rating,
    this.ratingCount,
    this.description,
    this.reviews,
    this.links,
  });

  final int id;
  final int colorNumber;
  final String name;
  final String addedBy;
  final User user;
  final Brand brand;
  final List<Variation> variations;
  final List<String> photos;
  final String thumbnailImage;
  final List<String> tag;
  final double priceLower;
  final double priceHigher;
  final List<dynamic> choiceOptions;
  final List<dynamic> selers;
  final dynamic variant;
  final List<Color> colors;
  final int todaysDeal;
  final int featured;
  final int currentStock;
  final String unit;
  final double discount;
  final String discountType;
  final List<Characteristics> characteristics;
  final int tax;
  final String taxType;
  final  shippingType;
  final  shippingCost;
  final int numberOfSales;
  final int rating;
  final int ratingCount;
  final String description;
  final Reviews reviews;
  final ProductDetailModelLinks links;

  ProductDetailModel copyWith({
    int id,
    int colorNumber,
    String name,
    String addedBy,
    User user,
    Brand brand,
    List<Variation> variations,
    List<String> photos,
    String thumbnailImage,
    List<String> tag,
    double priceLower,
    double priceHigher,
    List<dynamic> choiceOptions,
    List<dynamic> selers,
    dynamic variant,
    List<Color> colors,
    int todaysDeal,
    int featured,
    int currentStock,
    String unit,
    double discount,
    String discountType,
    Characteristics characteristics,
    int tax,
     taxType,
     shippingType,
    int shippingCost,
    int numberOfSales,
    int rating,
    int ratingCount,
    String description,
    Reviews reviews,
    ProductDetailModelLinks links,
  }) =>
      ProductDetailModel(
        id: id ?? this.id,
        colorNumber: colorNumber ?? this.colorNumber,
        name: name ?? this.name,
        addedBy: addedBy ?? this.addedBy,
        user: user ?? this.user,
        brand: brand ?? this.brand,
        variations: variations ?? this.variations,
        photos: photos ?? this.photos,
        thumbnailImage: thumbnailImage ?? this.thumbnailImage,
        tag: tag ?? this.tag,
        priceLower: priceLower ?? this.priceLower,
        priceHigher: priceHigher ?? this.priceHigher,
        choiceOptions: choiceOptions ?? this.choiceOptions,
        selers: selers ?? this.selers,
        variant: variant ?? this.variant,
        colors: colors ?? this.colors,
        todaysDeal: todaysDeal ?? this.todaysDeal,
        featured: featured ?? this.featured,
        currentStock: currentStock ?? this.currentStock,
        unit: unit ?? this.unit,
        discount: discount ?? this.discount,
        characteristics: characteristics ?? this.characteristics,
        discountType: discountType ?? this.discountType,
        tax: tax ?? this.tax,
        taxType: taxType ?? this.taxType,
        shippingType: shippingType ?? this.shippingType,
        shippingCost: shippingCost ?? this.shippingCost,
        numberOfSales: numberOfSales ?? this.numberOfSales,
        rating: rating ?? this.rating,
        ratingCount: ratingCount ?? this.ratingCount,
        description: description ?? this.description,
        reviews: reviews ?? this.reviews,
        links: links ?? this.links,
      );

  factory ProductDetailModel.fromJson(String str) =>
      ProductDetailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDetailModel.fromMap(Map<String, dynamic> json) =>
      ProductDetailModel(
        id: json["id"],
        colorNumber: json["variant"]["color"],
        name: json["name"],
        addedBy: json["added_by"],
        user: User.fromMap(json["user"]),
        brand: Brand.fromMap(json["brand"]),
        variations: List<Variation>.from(json["variations"].map((x) => Variation.fromMap(x))),
        photos: List<String>.from(json["variant"]["photos"].map((x) => x)),
        thumbnailImage: json["thumbnail_image"],
        tag: List<String>.from(json["tag"].map((x) => x)),
        priceLower: json["price_lower"].toDouble(),
        priceHigher: json["price_higher"].toDouble(),
        choiceOptions: List<dynamic>.from(json["choice_options"].map((x) => x)),
        selers: List<dynamic>.from(json["selers"].map((x) => x)),
        variant: json["variant"],
        colors: List<Color>.from(json["colors"].map((x) => Color.fromMap(x))),
        todaysDeal: json["todays_deal"],
        featured: json["featured"],
        currentStock: json["current_stock"],
        unit: json["unit"],
        discount: json["discount"].toDouble(),
        discountType: json["discount_type"],
        tax: json["tax"],
         characteristics: List<Characteristics>.from(json["characteristics"].map((x) => Characteristics.fromMap(x))),//Characteristics.fromMap(json["characteristics"]),
        taxType: json["tax_type"],
         shippingType: json["shipping_type"]!=null ? json["shipping_type"]:null,
         shippingCost: json["shipping_cost"]!=null ? json["shipping_cost"] :null,
        numberOfSales: json["number_of_sales"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
        description: json["description"],
        reviews: Reviews.fromMap(json["reviews"]),
        links: ProductDetailModelLinks.fromMap(json["links"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "added_by": addedBy,
        "user": user.toMap(),
        "brand": brand.toMap(),
        "variations": List<dynamic>.from(variations.map((x) => x.toMap())),
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "thumbnail_image": thumbnailImage,
        "tag": List<dynamic>.from(tag.map((x) => x)),
        "price_lower": priceLower,
        "price_higher": priceHigher,
        "choice_options": List<dynamic>.from(choiceOptions.map((x) => x)),
        "selers": List<dynamic>.from(selers.map((x) => x)),
        "variant": variant,
        "colors": List<dynamic>.from(colors.map((x) => x.toMap())),
        "todays_deal": todaysDeal,
        "featured": featured,
        "current_stock": currentStock,
        "unit": unit,
        "discount": discount,
        "discount_type": discountType,
        "characteristics": characteristics,
        "tax": tax,
        "tax_type": taxType,
        "shipping_type": shippingType,
        "shipping_cost": shippingCost,
        "number_of_sales": numberOfSales,
        "rating": rating,
        "rating_count": ratingCount,
        "description": description,
        "reviews": reviews.toMap(),
        "links": links.toMap(),
      };
}
class Brand {
  Brand({
    this.name,
    this.logo,
    this.links,
    this.slug,
  });

  final dynamic name;
  final dynamic logo;
  final dynamic slug;
  final BrandLinks links;

  Brand copyWith({
    dynamic name,
    dynamic logo,
    dynamic slug,
    BrandLinks links,
  }) =>
      Brand(
        name: name ?? this.name,
        logo: logo ?? this.logo,
        slug: slug ?? this.slug,
        links: links ?? this.links,
      );

  factory Brand.fromJson(String str) => Brand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
        name: json["name"],
        logo: json["logo"],
    slug: json["slug"],
        links: BrandLinks.fromMap(json["links"]),
      );

  Map<String, dynamic> toMap()=>{
        "name": name,
        "logo": logo,
        "slug": slug,
        "links": links.toMap(),
      };
}
class Characteristics{
  Characteristics({
    this.id,
    this.title,
    this.options,
  });

  final  id;
  final  title;
  final  options;

  Characteristics copyWith({
    id,
    title,
    options,
  }) =>
      Characteristics(
        id: id ?? this.id,
        title: title ?? this.title,
        options: options ?? this.options,
      );

  factory Characteristics.fromJson(String str) => Characteristics.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Characteristics.fromMap(Map<String, dynamic> json) => Characteristics(
    options: List<Options>.from(json["options"].map((x) => Options.fromMap(x))),
    id: json["id"],
    title: json["title"],
      );

  Map<String, dynamic> toMap()=>{
        "id": id,
        "title": title,
        "options": options,
      };
}
class Options{
  Options({
    this.id,
    this.attribute,
    this.values,
  });

  final  id;
  final  attribute;
  final  values;

  Options copyWith({
    id,
    attribute,
    values,
  }) =>
      Options(
        id: id ?? this.id,
        attribute: attribute ?? this.attribute,
        values: values ?? this.values,
      );

  factory Options.fromJson(String str) => Options.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Options.fromMap(Map<String, dynamic> json) => Options(
    id: json["id"],
    attribute: json["attribute"],
    values: List<Values>.from(json["values"].map((x) => Values.fromMap(x))),

      );

  Map<String, dynamic> toMap()=>{
        "id": id,
        "attribute": attribute,
        "values": values,
      };
}
class Values{
  Values({
    this.id,
    this.name,
  });

  final  id;
  final  name;

  Values copyWith({
    id,
    name,
  }) =>
      Values(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Values.fromJson(String str) => Values.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Values.fromMap(Map<String, dynamic> json) => Values(
    id: json["id"],
    name: json["name"],
      );

  Map<String, dynamic> toMap()=>{
        "id": id,
        "name": name,
      };
}
class BrandLinks {
  BrandLinks({
    this.products,
  });

  final dynamic products;

  BrandLinks copyWith({
    dynamic products,
  }) =>
      BrandLinks(
        products: products ?? this.products,
      );

  factory BrandLinks.fromJson(String str) =>
      BrandLinks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrandLinks.fromMap(Map<String, dynamic> json) => BrandLinks(
        products: json["products"],
      );

  Map<String, dynamic> toMap() => {
        "products": products,
      };
}
class Color {
  Color({
    this.id,
    this.hash,
    this.name,
  });

  final int id;
  final String hash;
  final String name;

  Color copyWith({
    String id,
    String hash,
    String name,
  }) =>
      Color(
        id: id ?? this.id,
        hash: hash ?? this.hash,
        name: name ?? this.name,
      );

  factory Color.fromJson(String str) => Color.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Color.fromMap(Map<String, dynamic> json) => Color(
    id: json["id"],
        hash: json["hash"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "hash": hash,
        "name": name,
      };
}
class ProductDetailModelLinks {
  ProductDetailModelLinks({
    this.reviews,
    this.related,
  });

  final String reviews;
  final String related;

  ProductDetailModelLinks copyWith({
    String reviews,
    String related,
  }) =>
      ProductDetailModelLinks(
        reviews: reviews ?? this.reviews,
        related: related ?? this.related,
      );

  factory ProductDetailModelLinks.fromJson(String str) =>
      ProductDetailModelLinks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDetailModelLinks.fromMap(Map<String, dynamic> json) =>
      ProductDetailModelLinks(
        reviews: json["reviews"],
        related: json["related"],
      );

  Map<String, dynamic> toMap() => {
        "reviews": reviews,
        "related": related,
      };
}
class Reviews {
  Reviews({
    this.data,
  });

  final List<dynamic> data;

  Reviews copyWith({
    List<dynamic> data,
  }) =>
      Reviews(
        data: data ?? this.data,
      );

  factory Reviews.fromJson(String str) => Reviews.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Reviews.fromMap(Map<String, dynamic> json) => Reviews(
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
class User {
  User({
    this.name,
    this.email,
    this.avatar,
    this.avatarOriginal,
    this.shopName,
    this.shopLogo,
    this.shopLink,
  });

  final String name;
  final String email;
  final dynamic avatar;
  final String avatarOriginal;
  final String shopName;
  final String shopLogo;
  final String shopLink;

  User copyWith({
    String name,
    String email,
    dynamic avatar,
    String avatarOriginal,
    String shopName,
    String shopLogo,
    String shopLink,
  }) =>
      User(
        name: name ?? this.name,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        avatarOriginal: avatarOriginal ?? this.avatarOriginal,
        shopName: shopName ?? this.shopName,
        shopLogo: shopLogo ?? this.shopLogo,
        shopLink: shopLink ?? this.shopLink,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        avatarOriginal: json["avatar_original"],
        shopName: json["shop_name"],
        shopLogo: json["shop_logo"],
        shopLink: json["shop_link"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "avatar": avatar,
        "avatar_original": avatarOriginal,
        "shop_name": shopName,
        "shop_logo": shopLogo,
        "shop_link": shopLink,
      };
}
/*class Variation {
  Variation({
    this.id,
    this.productId,
    this.variant,
    this.sku,
    this.price,
    this.qty,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int productId;
  final String variant;
  final dynamic sku;
  final int price;
  final int qty;
  final DateTime createdAt;
  final DateTime updatedAt;

  Variation copyWith({
    int id,
    int productId,
    String variant,
    dynamic sku,
    int price,
    int qty,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Variation(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        variant: variant ?? this.variant,
        sku: sku ?? this.sku,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Variation.fromJson(String str) => Variation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Variation.fromMap(Map<String, dynamic> json) => Variation(
        id: json["id"],
        productId: json["product_id"],
        variant: json["variant"],
        sku: json["sku"],
        price: json["price"],
        qty: json["qty"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "product_id": productId,
        "variant": variant,
        "sku": sku,
        "price": price,
        "qty": qty,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}*/
class Variation {
  Variation({
    this.slug,
    this.attributes,
    this.color,
  });

  final String slug;
  final List<int> attributes;
  final int color;

  Variation copyWith({
    int slug,
    int attributes,
    String color,
  }) =>
      Variation(
        slug: slug ?? this.slug,
        attributes: attributes ?? this.attributes,
        color: color ?? this.color,
      );

  factory Variation.fromJson(String str) => Variation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Variation.fromMap(Map<String, dynamic> json) => Variation(
    slug: json["slug"],
    attributes: List<int>.from(json["attributes"].map((x) => x)),
    color: json["color"],
  );

  Map<String, dynamic> toMap() => {
    "slug": slug,
    "attributes": attributes,
    "color": color,
  };
}
