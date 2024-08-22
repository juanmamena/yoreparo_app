// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

class CategoriesResponse {
  List<Category> categories;

  CategoriesResponse({
    required this.categories,
  });

  factory CategoriesResponse.fromRawJson(String str) =>
      CategoriesResponse.fromJson(jsonDecode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  String description;
  String imageIcon;
  bool isActive;
  String registryDate;

  Category({
    required this.id,
    required this.imageIcon,
    required this.description,
    required this.isActive,
    required this.registryDate,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        description: json["description"],
        imageIcon: json["imageIcon"],
        isActive: json["isActive"],
        registryDate: json["registryDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "imageIcon": imageIcon,
        "isActive": isActive,
        "registryDate": registryDate,
      };
}
