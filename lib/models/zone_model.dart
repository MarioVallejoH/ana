// To parse this JSON data, do
//
//     final zoneModel = zoneModelFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/utils/formating/data_formating.dart';

ZoneModel zoneModelFromJson(String str) => ZoneModel.fromJson(json.decode(str));

String zoneModelToJson(ZoneModel data) => json.encode(data.toJson());

class ZoneModel {
  ZoneModel({
    required this.codigoCiudad,
    required this.zoneName,
    required this.zoneCode,
  });

  String codigoCiudad;
  String zoneName;
  String zoneCode;

  factory ZoneModel.fromJson(Map json) => ZoneModel(
        codigoCiudad: json["codigo_ciudad"],
        zoneName: json["zone_name"],
        zoneCode: json["zone_code"],
      );

  Map<String, dynamic> toJson() => {
        "codigo_ciudad": codigoCiudad,
        "zone_name": zoneName,
        "zone_code": zoneCode,
      };

  @override
  String toString() {
    return capitalizeText(zoneName);
  }
}
