import 'dart:convert';

class CartItem{
   CartItem({
      this.slug,
      this.pieces,
      this.image,
      this.isWishlist,
      this.price,
      this.name,
   });
   String slug;
   String name;
   int pieces;
   double price;
   String image;
   bool isWishlist;

   CartItem copyWith({
      slug,
      pieces,
      name,
      price,
      image,
      isWishlist,
   }) =>
       CartItem(
          slug: slug ?? this.slug,
          pieces: pieces ?? this.pieces,
          name: name ?? this.name,
          price: price ?? this.price,
          image: image ?? this.image,
          isWishlist: isWishlist ?? this.isWishlist,
       );
   factory CartItem.fromJson(String str) => CartItem.fromMap(json.decode(str));

   String toJson() => json.encode(toMap());

   factory CartItem.fromMap(Map<String, dynamic> json) => CartItem(
      slug: json["slug"],
      pieces: json["pieces"],
      name: json["name"],
      price: json["price"],
      image: json["image"],
      isWishlist: json["isWishlist"],
   );

   Map<String, dynamic> toMap()=>{
      "slug": slug,
      "pieces": pieces,
      "name": name,
      "price": price,
      "image": image,
      "isWishlist": isWishlist,
   };
}