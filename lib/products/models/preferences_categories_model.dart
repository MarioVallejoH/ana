// To parse this JSON data, do
//
//     final preferencesCategories = preferencesCategoriesFromJson(jsonString);

import 'dart:convert';

class PreferencesCategories {
  PreferencesCategories({
    required this.id,
    this.name,
    this.selectionLimit,
    this.required,
  });

  final int id;
  final String? name;
  final int? selectionLimit;
  final int? required;

  factory PreferencesCategories.fromRawJson(String str) =>
      PreferencesCategories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PreferencesCategories.fromJson(Map<String, dynamic> json) =>
      PreferencesCategories(
        id: json["id"],
        name: json["name"],
        selectionLimit: json["selection_limit"],
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "selection_limit": selectionLimit,
        "required": required,
      };
  static List<PreferencesCategories> fromJsonList(List list) {
    List<PreferencesCategories> prefCat = [];

    for (var item in list) {
      prefCat.add(PreferencesCategories.fromJson(item));
    }

    return prefCat;

    // prString(temp);
  }
}
