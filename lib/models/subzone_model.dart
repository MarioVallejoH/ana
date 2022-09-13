// To parse this JSON data, do
//
//     final subZoneModel = subZoneModelFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/utils/formating/data_formating.dart';

SubZoneModel subZoneModelFromJson(String str) =>
    SubZoneModel.fromJson(json.decode(str));

String subZoneModelToJson(SubZoneModel data) => json.encode(data.toJson());

class SubZoneModel {
  SubZoneModel({
    required this.zoneCode,
    required this.subzoneName,
    required this.subzoneCode,
  });

  String zoneCode;
  String subzoneName;
  String subzoneCode;

  factory SubZoneModel.fromJson(Map json) => SubZoneModel(
        zoneCode: json["zone_code"],
        subzoneName: json["subzone_name"],
        subzoneCode: json["subzone_code"],
      );

  Map<String, dynamic> toJson() => {
        "zone_code": zoneCode,
        "subzone_name": subzoneName,
        "subzone_code": subzoneCode,
      };

  @override
  String toString() {
    return capitalizeText(subzoneName);
  }
}
