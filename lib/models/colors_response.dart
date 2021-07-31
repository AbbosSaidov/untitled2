import 'dart:convert';

class ColorsResponseModel {
  ColorsResponseModel({
    this.data,
    this.success,
    this.status,
  });

  List<Color> data;
  bool success;
  int status;

  ColorsResponseModel copyWith({
    List<Color> data,
    bool success,
    int status,
  }) =>
      ColorsResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        status: status ?? this.status,
      );

  factory ColorsResponseModel.fromJson(String str) =>
      ColorsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ColorsResponseModel.fromMap(Map<String, dynamic> json) =>
      ColorsResponseModel(
        data: List<Color>.from(json["data"].map((x) => Color.fromMap(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "success": success,
        "status": status,
      };
}

class Color {
  Color({
    this.name,
    this.code,
  });

  String name;
  String code;

  Color copyWith({
    String name,
    String code,
  }) =>
      Color(
        name: name ?? this.name,
        code: code ?? this.code,
      );

  factory Color.fromJson(String str) => Color.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Color.fromMap(Map<String, dynamic> json) => Color(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
      };
}
