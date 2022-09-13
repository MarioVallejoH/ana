// To parse this JSON data, do
//
//     final taxRateModel = taxRateModelFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/utils/parsing/numeric_paring.dart';
import 'package:customer_app/utils/parsing/tax_to_percent.dart';

class TaxRateModel {
  TaxRateModel({
    required this.id,
    required this.name,
    this.code,
    required this.rate,
    required this.type,
    this.taxClass = 1,
    required this.codeFe,
    this.taxIndicator,
    this.lastUpdate,
  });

  final int id;
  final String name;
  final String? code;
  final double rate;
  final String type;
  final int taxClass;
  final String codeFe;
  final dynamic taxIndicator;
  final String? lastUpdate;

  factory TaxRateModel.fromRawJson(String str) =>
      TaxRateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxRateModel.fromJson(Map<String, dynamic> json) => TaxRateModel(
        id: parsingToInt(json["id"]),
        name: json["name"],
        code: json["code"],
        rate: parsingToDouble(json["rate"]),
        type: json["type"],
        taxClass: parsingToInt(json["tax_class"], defaultValue: 1),
        codeFe: json["code_fe"],
        taxIndicator: json["tax_indicator"],
        lastUpdate: json["last_update"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "rate": rate,
        "type": type,
        "tax_class": taxClass,
        "code_fe": codeFe,
        "tax_indicator": taxIndicator,
        "last_update": lastUpdate,
      };

  static List<TaxRateModel> fromJsonList(List list) {
    List<TaxRateModel> taxRates = [];
    Map<String, dynamic> temp = {};
    for (var item in list) {
      for (var i = 0; i < item.keys.length; i++) {
        temp[item.keys.toList()[i]] = item.values.toList()[i];
      }
      taxRates.add(TaxRateModel.fromJson(temp));
    }

    return taxRates;

    // prString(temp);
  }

  double get taxPercentVal => taxPercent(rate);
}
