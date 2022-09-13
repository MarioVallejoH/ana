// To parse this JSON data, do
//
//     final unitPrice = unitPriceFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/utils/parsing/numeric_paring.dart';

class UnitPrice {
  UnitPrice(
      {required this.id,
      required this.code,
      required this.valorUnitario,
      required this.label,
      required this.unidad,
      required this.cantidad,
      required this.unitId,
      this.idProduct,
      this.priceGroupId});

  final int id;
  final int code;
  final double valorUnitario;
  final String label;
  final String unidad;
  final double cantidad;
  final int unitId;
  final int? idProduct;
  final int? priceGroupId;

  factory UnitPrice.fromRawJson(String str) =>
      UnitPrice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnitPrice.fromJson(Map<String, dynamic> json) => UnitPrice(
      id: json["id"],
      code: json["code"],
      valorUnitario: parsingToDouble(json["valor_unitario"]),
      label: json["label"],
      unidad: json["unidad"],
      cantidad: parsingToDouble(json["cantidad"]),
      unitId: json["unit_id"],
      idProduct: json["id_product"],
      priceGroupId: json["price_group_id"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "valor_unitario": valorUnitario,
        "label": label,
        "unidad": unidad,
        "cantidad": cantidad,
        "unit_id": unitId,
        "id_product": idProduct,
        "price_group_id": priceGroupId
      };
  static List<UnitPrice> fromJsonList(List list) {
    List<UnitPrice> unitP = [];
    Map<String, dynamic> temp = {};
    for (var item in list) {
      for (var i = 0; i < item.keys.length; i++) {
        temp[item.keys.toList()[i]] = item.values.toList()[i];
      }
      unitP.add(UnitPrice.fromJson(temp));
    }

    return unitP;

    // prString(temp);
  }
}
