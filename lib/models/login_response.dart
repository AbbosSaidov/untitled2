import 'dart:convert';

class LoginResponseModel {
  LoginResponseModel({
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
  });

  String accessToken;
  String tokenType;
  DateTime expiresAt;
  UserModel user;

  LoginResponseModel copyWith({
    String accessToken,
    String tokenType,
    DateTime expiresAt,
    UserModel user,
  }) =>
      LoginResponseModel(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        expiresAt: expiresAt ?? this.expiresAt,
        user: user ?? this.user,
      );

  factory LoginResponseModel.fromJson(String str) =>
      LoginResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) =>
      LoginResponseModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresAt: DateTime.parse(json["expires_at"]),
        user: UserModel.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt.toIso8601String(),
        "user": user.toMap(),
      };
}

class UserModel {
  UserModel({
    this.id,
    this.type,
    this.name,
    this.email,
    this.avatar,
    this.avatarOriginal,
    this.address,
    this.country,
    this.city,
    this.postalCode,
    this.phone,
  });

  int id;
  String type;
  String name;
  String email;
  dynamic avatar;
  dynamic avatarOriginal;
  dynamic address;
  dynamic country;
  dynamic city;
  dynamic postalCode;
  dynamic phone;

  UserModel copyWith({
    int id,
    String type,
    String name,
    String email,
    dynamic avatar,
    dynamic avatarOriginal,
    dynamic address,
    dynamic country,
    dynamic city,
    dynamic postalCode,
    dynamic phone,
  }) =>
      UserModel(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        avatarOriginal: avatarOriginal ?? this.avatarOriginal,
        address: address ?? this.address,
        country: country ?? this.country,
        city: city ?? this.city,
        postalCode: postalCode ?? this.postalCode,
        phone: phone ?? this.phone,
      );

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        avatarOriginal: json["avatar_original"],
        address: json["address"],
        country: json["country"],
        city: json["city"],
        postalCode: json["postal_code"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "name": name,
        "email": email,
        "avatar": avatar,
        "avatar_original": avatarOriginal,
        "address": address,
        "country": country,
        "city": city,
        "postal_code": postalCode,
        "phone": phone,
      };
}
