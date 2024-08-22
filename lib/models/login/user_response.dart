// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

class UserResponse {
  int id;
  String? fullName;
  String? email;
  String? cellPhoneNumber;
  bool? isActive;
  String? registryDate;
  bool? saved;

  UserResponse({
    required this.id,
    this.fullName,
    this.email,
    this.cellPhoneNumber,
    this.isActive,
    this.registryDate,
    this.saved,
  });

  factory UserResponse.fromRawJson(String str) =>
      UserResponse.fromJson(json.decode(str));

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        fullName: json["fullName"],
        email: json["email"],
        cellPhoneNumber: json["cellPhoneNumber"],
        isActive: json["isActive"],
        registryDate: json["registryDate"],
        saved: json["saved"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "cellPhoneNumber": cellPhoneNumber,
        "isActive": isActive,
        "registryDate": registryDate,
        "saved": saved,
      };
}
