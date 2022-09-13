// To parse this JSON data, do
//
//     final documentTypes = documentTypesFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:customer_app/utils/parsing/numeric_paring.dart';

class DocumentTypesModel {
  DocumentTypesModel({
    required this.id,
    required this.nombre,
    required this.abreviacion,
    required this.codigoDoc,
  });

  final int id;
  final String nombre;
  final String abreviacion;
  final int codigoDoc;

  factory DocumentTypesModel.fromRawJson(String str) =>
      DocumentTypesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DocumentTypesModel.fromJson(Map json) => DocumentTypesModel(
        id: parsingToInt(json["id"]),
        nombre: json["nombre"],
        abreviacion: json["abreviacion"],
        codigoDoc: parsingToInt(json["codigo_doc"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "abreviacion": abreviacion,
        "codigo_doc": codigoDoc,
      };

  static List<DocumentTypesModel> fromJsonList(List list) {
    List<DocumentTypesModel> docTypes = [];

    for (var item in list) {
      docTypes.add(DocumentTypesModel.fromJson(item));
    }

    return docTypes;

    // prString(temp);
  }

  @override
  String toString() {
    return capitalizeText(nombre);
  }

  String toString2() {
    return (abreviacion);
  }
}
