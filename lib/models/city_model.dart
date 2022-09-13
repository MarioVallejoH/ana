// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/utils/formating/data_formating.dart';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
    required this.pais,
    required this.coddepartamento,
    required this.departamento,
    required this.codigo,
    required this.descripcion,
  });

  String pais;
  String coddepartamento;
  String departamento;
  String codigo;
  String descripcion;

  factory CityModel.fromJson(Map json) => CityModel(
        pais: json["PAIS"],
        coddepartamento: json["CODDEPARTAMENTO"],
        departamento: json["DEPARTAMENTO"],
        codigo: json["CODIGO"],
        descripcion: json["DESCRIPCION"],
      );

  Map<String, dynamic> toJson() => {
        "PAIS": pais,
        "CODDEPARTAMENTO": coddepartamento,
        "DEPARTAMENTO": departamento,
        "CODIGO": codigo,
        "DESCRIPCION": descripcion,
      };
  @override
  String toString() {
    return capitalizeText(descripcion);
  }
}
