import 'dart:convert';

class CurrenciesResponse {
  CurrenciesResponse({
    this.data,
    this.success,
    this.status,
  });

  List<Currency> data;
  bool success;
  int status;

  CurrenciesResponse copyWith({
    List<Currency> data,
    bool success,
    int status,
  }) =>
      CurrenciesResponse(
        data: data ?? this.data,
        success: success ?? this.success,
        status: status ?? this.status,
      );

  factory CurrenciesResponse.fromJson(String str) =>
      CurrenciesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CurrenciesResponse.fromMap(Map<String, dynamic> json) =>
      CurrenciesResponse(
        data: List<Currency>.from(json["data"].map((x) => Currency.fromMap(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "success": success,
        "status": status,
      };
}

class Currency {
  Currency({
    this.name,
    this.code,
    this.symbol,
    this.exchangeRate,
  });

  String name;
  String code;
  String symbol;
  double exchangeRate;

  Currency copyWith({
    String name,
    String code,
    String symbol,
    double exchangeRate,
  }) =>
      Currency(
        name: name ?? this.name,
        code: code ?? this.code,
        symbol: symbol ?? this.symbol,
        exchangeRate: exchangeRate ?? this.exchangeRate,
      );

  factory Currency.fromJson(String str) => Currency.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Currency.fromMap(Map<String, dynamic> json) => Currency(
        name: json["name"],
        code: json["code"],
        symbol: json["symbol"],
        exchangeRate: json["exchange_rate"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
        "symbol": symbol,
        "exchange_rate": exchangeRate,
      };
}
