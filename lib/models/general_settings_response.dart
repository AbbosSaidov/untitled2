import 'dart:convert';

class GeneralSettingsResponseModel {
  GeneralSettingsResponseModel({
    this.data,
    this.success,
    this.status,
  });

  List<GeneralSetting> data;
  bool success;
  int status;

  GeneralSettingsResponseModel copyWith({
    List<GeneralSetting> data,
    bool success,
    int status,
  }) =>
      GeneralSettingsResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        status: status ?? this.status,
      );

  factory GeneralSettingsResponseModel.fromJson(String str) =>
      GeneralSettingsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GeneralSettingsResponseModel.fromMap(Map<String, dynamic> json) =>
      GeneralSettingsResponseModel(
        data: List<GeneralSetting>.from(
            json["data"].map((x) => GeneralSetting.fromMap(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "success": success,
        "status": status,
      };
}

class GeneralSetting {
  GeneralSetting({
    this.logo,
    this.siteName,
    this.address,
    this.description,
    this.phone,
    this.email,
    this.facebook,
    this.twitter,
    this.instagram,
    this.youtube,
    this.googlePlus,
  });

  String logo;
  String siteName;
  String address;
  String description;
  String phone;
  String email;
  String facebook;
  String twitter;
  String instagram;
  String youtube;
  String googlePlus;

  factory GeneralSetting.fromJson(String str) =>
      GeneralSetting.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GeneralSetting.fromMap(Map<String, dynamic> json) => GeneralSetting(
        logo: json["logo"],
        siteName: json["site_name"],
        address: json["address"],
        description: json["description"],
        phone: json["phone"],
        email: json["email"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        youtube: json["youtube"],
        googlePlus: json["google_plus"],
      );

  Map<String, dynamic> toMap() => {
        "logo": logo,
        "site_name": siteName,
        "address": address,
        "description": description,
        "phone": phone,
        "email": email,
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "youtube": youtube,
        "google_plus": googlePlus,
      };
}
