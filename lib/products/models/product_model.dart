// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

// ignore_for_file: unnecessary_null_in_if_null_operators

import 'dart:convert';

import 'package:customer_app/utils/parsing/numeric_paring.dart';

class ProductModel {
  ProductModel(
      {required this.id,
      required this.code,
      required this.name,
      this.unit,
      this.cost,
      this.avgCost,
      required this.price,
      required this.alertQuantity,
      required this.image,
      required this.categoryId,
      this.subcategoryId,
      this.cf1,
      this.cf2,
      this.cf3,
      this.cf4,
      this.cf5,
      this.cf6,
      this.quantity = 1,
      this.taxRate,
      this.trackQuantity = 1,
      this.details,
      this.warehouse,
      this.barcodeSymbology = 'code128',
      this.file,
      this.productDetails,
      this.taxMethod = 0,
      this.type = 'standart',
      this.supplier1,
      this.supplier1Price,
      this.supplier2,
      this.supplier2Price,
      this.supplier3,
      this.supplier3Price,
      this.supplier4,
      this.supplier4Price,
      this.supplier5,
      this.supplier5Price,
      this.promotion,
      this.promoPrice,
      this.startDate,
      this.endDate,
      this.supplier1PartNo,
      this.supplier2PartNo,
      this.supplier3PartNo,
      this.supplier4PartNo,
      this.supplier5PartNo,
      this.saleUnit,
      this.purchaseUnit,
      this.brand,
      this.slug,
      this.featured,
      this.weight,
      this.hsnCode,
      this.views = 0,
      this.hideDetal = 0,
      this.hidePos = 0,
      this.hideOnlineStore = 0,
      this.secondName,
      this.reference,
      this.hasMultipleUnits,
      this.profitabilityMargin = 0.0,
      this.ignoreHideParameters = 0,
      this.consumptionSaleTax = 0,
      this.consumptionPurchaseTax = 0,
      this.discontinued = 0,
      this.attributes = 0,
      this.supplier1PriceDate,
      this.supplier2PriceDate,
      this.supplier3PriceDate,
      this.supplier4PriceDate,
      this.supplier5PriceDate,
      this.registrationDate});

  int id;
  String code;
  String name;
  int? unit;
  double? cost;
  double? avgCost;
  double price;
  int alertQuantity;
  String image;
  int categoryId;
  int? subcategoryId;
  dynamic cf1;
  dynamic cf2;
  dynamic cf3;
  dynamic cf4;
  dynamic cf5;
  dynamic cf6;
  double quantity;
  int? taxRate;
  int trackQuantity;
  String? details;
  int? warehouse;
  String barcodeSymbology;
  String? file;
  String? productDetails;
  int taxMethod;
  String type;
  int? supplier1;
  dynamic supplier1Price;
  dynamic supplier2;
  dynamic supplier2Price;
  dynamic supplier3;
  dynamic supplier3Price;
  dynamic supplier4;
  dynamic supplier4Price;
  dynamic supplier5;
  dynamic supplier5Price;
  int? promotion;
  double? promoPrice;
  DateTime? startDate;
  DateTime? endDate;
  String? supplier1PartNo;
  dynamic supplier2PartNo;
  dynamic supplier3PartNo;
  dynamic supplier4PartNo;
  dynamic supplier5PartNo;
  int? saleUnit;
  int? purchaseUnit;
  int? brand;
  String? slug;
  int? featured;
  String? weight;
  dynamic hsnCode;
  int views;
  int hideDetal;
  int hidePos;
  int hideOnlineStore;
  String? secondName;
  String? reference;
  int? hasMultipleUnits;
  double? profitabilityMargin;
  int ignoreHideParameters;
  int consumptionSaleTax;
  int consumptionPurchaseTax;
  int discontinued;
  int attributes;
  dynamic supplier1PriceDate;
  dynamic supplier2PriceDate;
  dynamic supplier3PriceDate;
  dynamic supplier4PriceDate;
  dynamic supplier5PriceDate;
  DateTime? registrationDate;

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map json) => ProductModel(
      id: json["id"],
      code: json["code"],
      name: json["name"],
      unit: json["unit"],
      cost: parsingToDoubleNullAble(json["cost"]),
      avgCost: parsingToDoubleNullAble(json["avg_cost"]),
      price: parsingToDouble(json["price"]),
      alertQuantity: parsingToInt(json["alert_quantity"]),
      image: json["image"],
      categoryId: json["category_id"],
      subcategoryId: json["subcategory_id"],
      cf1: json["cf1"],
      cf2: json["cf2"],
      cf3: json["cf3"],
      cf4: json["cf4"],
      cf5: json["cf5"],
      cf6: json["cf6"],
      quantity: parsingToDouble(json["quantity"]),
      taxRate: json["tax_rate"],
      trackQuantity: json["track_quantity"],
      details: json["details"],
      warehouse: json["warehouse"],
      barcodeSymbology: json["barcode_symbology"],
      file: json["file"],
      productDetails: json["product_details"],
      taxMethod: json["tax_method"],
      type: json["type"],
      supplier1: json["supplier1"],
      supplier1Price: json["supplier1price"],
      supplier2: json["supplier2"],
      supplier2Price: json["supplier2price"],
      supplier3: json["supplier3"],
      supplier3Price: json["supplier3price"],
      supplier4: json["supplier4"],
      supplier4Price: json["supplier4price"],
      supplier5: json["supplier5"],
      supplier5Price: json["supplier5price"],
      promotion: json["promotion"],
      promoPrice: json["promo_price"],
      startDate: DateTime.tryParse(json["start_date"] ?? ''),
      endDate: json["end_date"] == null
          ? null
          : DateTime.tryParse(json["end_date"] ?? ''),
      supplier1PartNo: json["supplier1_part_no"],
      supplier2PartNo: json["supplier2_part_no"],
      supplier3PartNo: json["supplier3_part_no"],
      supplier4PartNo: json["supplier4_part_no"],
      supplier5PartNo: json["supplier5_part_no"],
      saleUnit: json["sale_unit"],
      purchaseUnit: json["purchase_unit"],
      brand: json["brand"],
      slug: json["slug"],
      featured: json["featured"],
      weight: json["weight"],
      hsnCode: json["hsn_code"],
      views: json["views"],
      hideDetal: json["hide_detal"],
      hidePos: json["hide_pos"],
      hideOnlineStore: json["hide_online_store"],
      secondName: json["second_name"],
      reference: json["reference"],
      hasMultipleUnits: json["has_multiple_units"],
      profitabilityMargin:
          parsingToDoubleNullAble(json["profitability_margin"]),
      ignoreHideParameters: json["ignore_hide_parameters"],
      consumptionSaleTax: json["consumption_sale_tax"],
      consumptionPurchaseTax: json["consumption_purchase_tax"],
      discontinued: json["discontinued"],
      attributes: json["attributes"],
      supplier1PriceDate: json["supplier1price_date"],
      supplier2PriceDate: json["supplier2price_date"],
      supplier3PriceDate: json["supplier3price_date"],
      supplier4PriceDate: json["supplier4price_date"],
      supplier5PriceDate: json["supplier5price_date"],
      registrationDate: DateTime.tryParse(json["registration_date"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "unit": unit,
        "cost": cost,
        "avg_cost": avgCost,
        "price": price,
        "alert_quantity": alertQuantity,
        "image": image,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "cf1": cf1,
        "cf2": cf2,
        "cf3": cf3,
        "cf4": cf4,
        "cf5": cf5,
        "cf6": cf6,
        "quantity": quantity,
        "tax_rate": taxRate,
        "track_quantity": trackQuantity,
        "details": details,
        "warehouse": warehouse,
        "barcode_symbology": null ?? barcodeSymbology,
        "file": file,
        "product_details": productDetails,
        "tax_method": taxMethod,
        "type": type,
        "supplier1": supplier1,
        "supplier1price": supplier1Price,
        "supplier2": supplier2,
        "supplier2price": supplier2Price,
        "supplier3": supplier3,
        "supplier3price": supplier3Price,
        "supplier4": supplier4,
        "supplier4price": supplier4Price,
        "supplier5": supplier5,
        "supplier5price": supplier5Price,
        "promotion": promotion,
        "promo_price": promoPrice,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "supplier1_part_no": supplier1PartNo,
        "supplier2_part_no": supplier2PartNo,
        "supplier3_part_no": supplier3PartNo,
        "supplier4_part_no": supplier4PartNo,
        "supplier5_part_no": supplier5PartNo,
        "sale_unit": saleUnit,
        "purchase_unit": purchaseUnit,
        "brand": brand,
        "slug": slug,
        "featured": featured,
        "weight": weight,
        "hsn_code": hsnCode,
        "views": views,
        "hide_detal": hideDetal,
        "hide_pos": hidePos,
        "hide_online_store": hideOnlineStore,
        "second_name": secondName,
        "reference": reference,
        "has_multiple_units": hasMultipleUnits,
        "profitability_margin": profitabilityMargin,
        "ignore_hide_parameters": ignoreHideParameters,
        "consumption_sale_tax": consumptionSaleTax,
        "consumption_purchase_tax": consumptionPurchaseTax,
        "discontinued": discontinued,
        "attributes": attributes,
        "supplier1price_date": supplier1PriceDate,
        "supplier2price_date": supplier2PriceDate,
        "supplier3price_date": supplier3PriceDate,
        "supplier4price_date": supplier4PriceDate,
        "supplier5price_date": supplier5PriceDate,
        "registration_date": registrationDate?.toIso8601String()
      };
  static List<ProductModel> fromJsonList(List list) {
    List<ProductModel> products = [];

    for (var item in list) {
      products.add(ProductModel.fromJson(item));
    }

    return products;

    // prString(temp);
  }
}
