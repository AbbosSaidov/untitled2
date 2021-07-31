class ShopBannerModel {
  int id;
  int sort;
  String name;
  String image;
  String link;

  ShopBannerModel({this.id, this.name, this.sort, this.image, this.link});
  factory ShopBannerModel.fromJson(Map<String, dynamic> json) {
    return ShopBannerModel(
      id: json['id'],
      sort: json['sort'],
      name: json['name'],
      image: json['image'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'sort': sort, 'name': name, 'image': image, 'link': link};
  }
}
