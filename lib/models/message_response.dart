import 'dart:convert';

class MessageResponse {
  MessageResponse({
    this.message,
  });

  final String message;

  MessageResponse copyWith({
    String message,
  }) =>
      MessageResponse(
        message: message ?? this.message,
      );

  factory MessageResponse.fromJson(String str) =>
      MessageResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageResponse.fromMap(Map<String, dynamic> json) => MessageResponse(
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
      };
}
