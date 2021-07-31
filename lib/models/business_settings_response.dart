import 'dart:convert';

class BusinessSettingsResponseModel {
  BusinessSettingsResponseModel({
    this.data,
    this.success,
    this.status,
  });

  final List<BusinessSettingModel> data;
  final bool success;
  final int status;

  BusinessSettingsResponseModel copyWith({
    List<BusinessSettingModel> data,
    bool success,
    int status,
  }) =>
      BusinessSettingsResponseModel(
        data: data ?? this.data,
        success: success ?? this.success,
        status: status ?? this.status,
      );

  factory BusinessSettingsResponseModel.fromJson(String str) =>
      BusinessSettingsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessSettingsResponseModel.fromMap(Map<String, dynamic> json) =>
      BusinessSettingsResponseModel(
        data: List<BusinessSettingModel>.from(
            json["data"].map((x) => BusinessSettingModel.fromMap(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "success": success,
        "status": status,
      };
}

class BusinessSettingModel {
  BusinessSettingModel({
    this.type,
    this.value,
  });

  final String type;
  final dynamic value;

  BusinessSettingModel copyWith({
    String type,
    dynamic value,
  }) =>
      BusinessSettingModel(
        type: type ?? this.type,
        value: value ?? this.value,
      );

  factory BusinessSettingModel.fromJson(String str) =>
      BusinessSettingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessSettingModel.fromMap(Map<String, dynamic> json) =>
      BusinessSettingModel(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "value": value,
      };
}

class ValueElement {
  ValueElement({
    this.type,
    this.label,
  });

  String type;
  String label;

  ValueElement copyWith({
    String type,
    String label,
  }) =>
      ValueElement(
        type: type ?? this.type,
        label: label ?? this.label,
      );

  factory ValueElement.fromJson(String str) =>
      ValueElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ValueElement.fromMap(Map<String, dynamic> json) => ValueElement(
        type: json["type"],
        label: json["label"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "label": label,
      };
}
