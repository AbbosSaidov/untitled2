import 'dart:convert';

class SignupRequest {
  SignupRequest({
    this.name,
    this.email,
    this.password,
    this.passowrdConfirmation,
  });

  String name;
  String email;
  String password;
  String passowrdConfirmation;

  factory SignupRequest.fromJson(String str) =>
      SignupRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignupRequest.fromMap(Map<String, dynamic> json) => SignupRequest(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        passowrdConfirmation: json["passowrd_confirmation"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        "passowrd_confirmation": passowrdConfirmation,
      };
}
