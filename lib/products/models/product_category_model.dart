// To parse this JSON data, do
//
//     final preferencesCategories = preferencesCategoriesFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/utils/parsing/numeric_paring.dart';

class ProductCategoryModel {
  ProductCategoryModel({
    required this.id,
    required this.code,
    required this.name,
    this.image,
    this.parentId,
    this.slug,
    this.printerId,
    this.preparerId,
    this.hide = 0,
    this.profitabilityMargin = 0.0,
    this.profitabilityMarginPriceBase = 0.0,
    this.exceptCategoryTaxes = 0,
    this.preparationAreaId,
  });

  final int id;
  final String code;
  final String name;
  final String? image;
  final int? parentId;
  final String? slug;
  final dynamic printerId;
  final dynamic preparerId;
  final int hide;
  final double profitabilityMargin;
  final double profitabilityMarginPriceBase;
  final int exceptCategoryTaxes;
  final dynamic preparationAreaId;

  factory ProductCategoryModel.fromRawJson(String str) =>
      ProductCategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        image: json["image"],
        parentId: json["parent_id"],
        slug: json["slug"],
        printerId: json["printer_id"],
        preparerId: json["preparer_id"],
        hide: json["hide"],
        profitabilityMargin: parsingToDouble(json["profitability_margin"]),
        profitabilityMarginPriceBase:
            parsingToDouble(json["profitability_margin_price_base"]),
        exceptCategoryTaxes: json["except_category_taxes"],
        preparationAreaId: json["preparation_area_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "image": image,
        "parent_id": parentId,
        "slug": slug,
        "printer_id": printerId,
        "preparer_id": preparerId,
        "hide": hide,
        "profitability_margin": profitabilityMargin,
        "profitability_margin_price_base": profitabilityMarginPriceBase,
        "except_category_taxes": exceptCategoryTaxes,
        "preparation_area_id": preparationAreaId,
      };

  static List<ProductCategoryModel> fromJsonList(List list) {
    List<ProductCategoryModel> prefCat = [];

    for (var item in list) {
      prefCat.add(ProductCategoryModel.fromJson(item));
    }

    return prefCat;

    // prString(temp);
  }
}
