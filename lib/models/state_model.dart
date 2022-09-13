// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/utils/formating/data_formating.dart';

StateModel stateModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    required this.coddepartamento,
    required this.departamento,
    required this.pais,
    required this.desadicional,
  });

  String coddepartamento;
  String departamento;
  String pais;
  String desadicional;

  factory StateModel.fromJson(Map json) => StateModel(
        coddepartamento: json["CODDEPARTAMENTO"],
        departamento: json["DEPARTAMENTO"],
        pais: json["PAIS"],
        desadicional: json["DESADICIONAL"],
      );

  Map<String, dynamic> toJson() => {
        "CODDEPARTAMENTO": coddepartamento,
        "DEPARTAMENTO": departamento,
        "PAIS": pais,
        "DESADICIONAL": desadicional,
      };

  @override
  String toString() {
    return capitalizeText(departamento);
  }
}
