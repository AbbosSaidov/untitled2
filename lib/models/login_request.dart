import 'dart:convert';

class LoginRequestModel {
  LoginRequestModel({
    this.email,
    this.password,
    this.rememberMe,
  });

  String email;
  String password;
  bool rememberMe;

  LoginRequestModel copyWith({
    String email,
    String password,
    bool rememberMe,
  }) =>
      LoginRequestModel(
        email: email ?? this.email,
        password: password ?? this.password,
        rememberMe: rememberMe ?? this.rememberMe,
      );

  factory LoginRequestModel.fromJson(String str) =>
      LoginRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromMap(Map<String, dynamic> json) =>
      LoginRequestModel(
        email: json["email"],
        password: json["password"],
        rememberMe: json["remember_me"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
        "remember_me": rememberMe,
      };
}
