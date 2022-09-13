// To parse this JSON data, do
//
//     final productPreference = productPreferenceFromJson(jsonString);

import 'dart:convert';

class ProductPreference {
  ProductPreference({
    required this.id,
    required this.productId,
    this.name,
    this.preferenceId,
    this.preferenceCategoryId,
  });

  final int id;
  final int productId;
  final String? name;
  final int? preferenceId;
  final int? preferenceCategoryId;

  factory ProductPreference.fromRawJson(String str) =>
      ProductPreference.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductPreference.fromJson(Map<String, dynamic> json) =>
      ProductPreference(
        id: json["id"],
        productId: json["product_id"],
        name: json["name"],
        preferenceId: json["preference_id"],
        preferenceCategoryId: json["preference_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "name": name,
        "preference_id": preferenceId,
        "preference_category_id": preferenceCategoryId,
      };

  static List<ProductPreference> fromJsonList(List list) {
    List<ProductPreference> prodPref = [];

    for (var item in list) {
      prodPref.add(ProductPreference.fromJson(item));
    }

    return prodPref;

    // prString(temp);
  }
}
