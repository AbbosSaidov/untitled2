import 'dart:convert';

class SettingsResponseModel {
  SettingsResponseModel({
    this.data,
    this.success,
    this.status,
  });

  final List<Setting> data;
  final bool success;
  final int status;

  SettingsResponseModel copyWith({
    List<Setting> data,
    bool success,
    int status,
  }) =>
      SettingsResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        status: status ?? this.status,
      );

  factory SettingsResponseModel.fromJson(String str) =>
      SettingsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SettingsResponseModel.fromMap(Map<String, dynamic> json) =>
      SettingsResponseModel(
        data: List<Setting>.from(json["data"].map((x) => Setting.fromMap(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "success": success,
        "status": status,
      };
}

class Setting {
  Setting({
    this.name,
    this.logo,
    this.facebook,
    this.twitter,
    this.instagram,
    this.youtube,
    this.googlePlus,
    this.currency,
    this.currencyFormat,
  });

  final String name;
  final String logo;
  final String facebook;
  final String twitter;
  final String instagram;
  final String youtube;
  final String googlePlus;
  final Currency currency;
  final String currencyFormat;

  Setting copyWith({
    String name,
    String logo,
    String facebook,
    String twitter,
    String instagram,
    String youtube,
    String googlePlus,
    Currency currency,
    String currencyFormat,
  }) =>
      Setting(
        name: name ?? this.name,
        logo: logo ?? this.logo,
        facebook: facebook ?? this.facebook,
        twitter: twitter ?? this.twitter,
        instagram: instagram ?? this.instagram,
        youtube: youtube ?? this.youtube,
        googlePlus: googlePlus ?? this.googlePlus,
        currency: currency ?? this.currency,
        currencyFormat: currencyFormat ?? this.currencyFormat,
      );

  factory Setting.fromJson(String str) => Setting.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Setting.fromMap(Map<String, dynamic> json) => Setting(
        name: json["name"],
        logo: json["logo"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        youtube: json["youtube"],
        googlePlus: json["google_plus"],
        currency: Currency.fromMap(json["currency"]),
        currencyFormat: json["currency_format"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "logo": logo,
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "youtube": youtube,
        "google_plus": googlePlus,
        "currency": currency.toMap(),
        "currency_format": currencyFormat,
      };
}

class Currency {
  Currency({
    this.name,
    this.symbol,
    this.exchangeRate,
    this.code,
  });

  final String name;
  final String symbol;
  final int exchangeRate;
  final String code;

  Currency copyWith({
    String name,
    String symbol,
    int exchangeRate,
    String code,
  }) =>
      Currency(
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        exchangeRate: exchangeRate ?? this.exchangeRate,
        code: code ?? this.code,
      );

  factory Currency.fromJson(String str) => Currency.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Currency.fromMap(Map<String, dynamic> json) => Currency(
        name: json["name"],
        symbol: json["symbol"],
        exchangeRate: json["exchange_rate"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "symbol": symbol,
        "exchange_rate": exchangeRate,
        "code": code,
      };
}
