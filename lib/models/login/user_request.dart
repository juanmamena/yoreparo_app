// To parse this JSON data, do
//
//     final userRequest = userRequestFromJson(jsonString);

import 'dart:convert';

class UserRequest {
  String fullName;
  String email;
  String? cellPhoneNumber;

  UserRequest({
    required this.fullName,
    required this.email,
  });

  factory UserRequest.fromRawJson(String str) =>
      UserRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        fullName: json["fullName"],
        email: json["email"],
      );

  Map<String, String> toJson() => {
        "fullName": fullName,
        "email": email,
      };
}
