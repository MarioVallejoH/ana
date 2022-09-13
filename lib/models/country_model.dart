// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:customer_app/utils/parsing/numeric_paring.dart';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    required this.codigo,
    required this.nombre,
    required this.indicativo,
    required this.moneda,
    required this.codigoIso,
  });

  String codigo;
  String nombre;
  String indicativo;
  int moneda;
  String codigoIso;

  factory CountryModel.fromJson(Map json) => CountryModel(
        codigo: json["CODIGO"],
        nombre: json["NOMBRE"],
        indicativo: json["INDICATIVO"],
        moneda: parsingToInt(json["MONEDA"]),
        codigoIso: json["codigo_iso"],
      );

  Map<String, dynamic> toJson() => {
        "CODIGO": codigo,
        "NOMBRE": nombre,
        "INDICATIVO": indicativo,
        "MONEDA": moneda,
        "codigo_iso": codigoIso,
      };
  static List<CountryModel> fromJsonList(List list) {
    List<CountryModel> countries = [];

    for (var item in list) {
      countries.add(CountryModel.fromJson(item));
    }

    return countries;

    // prString(temp);
  }

  @override
  String toString() {
    return capitalizeText(nombre);
  }
}
