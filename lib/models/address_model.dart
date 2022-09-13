// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import '../utils/formating/data_formating.dart';
import '../utils/parsing/numeric_paring.dart';

// import 'package:pos_wappsi/utils/text_formating/json_parsing.dart';

AddressModel addressModelFromJson(Map<String, dynamic> str) =>
    AddressModel.fromJson(str);

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel(
      {this.id,
      this.companyId,
      required this.sucursal,
      required this.direccion,
      this.country,
      this.state,
      this.email,
      this.customerAddressSellerIdAssigned,
      this.phone,
      this.line1,
      this.line2,
      this.postalCode,
      this.city,
      this.priceGroupId,
      this.customerGroupId,
      required this.vatNo,
      this.latitude,
      this.longitude,
      this.cityCode,
      this.location,
      this.subzone,
      this.customerGroupName,
      this.priceGroupName,
      this.code});
  int? id;
  String? sucursal;
  int? companyId;
  String? country;
  String? state;
  String? email;
  int? customerAddressSellerIdAssigned;
  String? phone;
  double? latitude;
  double? longitude;
  String? direccion;
  String? city;
  String? vatNo;
  String? location;

  String? code;
  String? line1;
  String? postalCode;
  String? line2;
  String? cityCode;
  int? customerGroupId;
  String? customerGroupName;
  String? priceGroupName;
  String? subzone;
  int? priceGroupId;

  factory AddressModel.fromJson(Map<dynamic, dynamic> json) => AddressModel(
        id: parsingToInt(json["id"]),
        customerAddressSellerIdAssigned: int.tryParse(
            json["customer_address_seller_id_assigned"]?.toString() ?? ''),
        sucursal: json["sucursal"] ?? '',
        companyId: parsingToInt(json["companyId"]),
        country: json["country"].toString(),
        state: json['state'].toString(),
        email: json['email'].toString(),
        phone: json['phone'].toString(),
        priceGroupName: json['price_group_name'].toString(),
        direccion: json["direccion"] ?? '',
        latitude: parsingToDoubleNullAble(json["latitude"]),
        longitude: parsingToDoubleNullAble(json["longitude"]),
        city: json["city"] ?? '',
        line1: json["line1"] ?? '',
        line2: json["line2"] ?? '',
        postalCode: json["postal_code"] ?? '',
        vatNo: json["vat_no"] ?? '',
        code: json["code"].toString(),
        location: json["location"],
        cityCode: json["city_code"].toString(),
        customerGroupId: parsingToIntNullable(json["customer_group_id"]),
        customerGroupName: json["customer_group_name"].toString(),
        priceGroupId: parsingToIntNullable(json["price_group_id"]),
      );

  static List<AddressModel> fromJsonList(List list) {
    List<AddressModel> products = [];
    Map temp = {};
    for (var item in list) {
      for (var i = 0; i < item.keys.length; i++) {
        temp[item.keys.toList()[i]] = item.values.toList()[i];
      }
      products.add(AddressModel.fromJson(temp));
    }

    return products;

    // prString(temp);
  }

  Map<String, dynamic> toJson({bool toCreate = false}) {
    if (toCreate) {
      return {
        "sucursal": sucursal,
        "subzone": subzone,
        "company_id": companyId,
        "country": country,
        "state": state,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "vat_no": vatNo,
        "email": email ?? '',
        "phone": phone ?? '',
        "code": code,
        "location": location,
        "city_code": cityCode,
        "customer_group_id": customerGroupId,
        "customer_group_name": customerGroupName,
        "price_group_name": priceGroupName,
        "price_group_id": priceGroupId,
        "postal_code": postalCode,
        "line1": line1,
        "line2": line2,
        "customer_address_seller_id_assigned": customerAddressSellerIdAssigned
      };
    } else {
      return {
        "id": id,
        "sucursal": sucursal,
        "company_id": companyId,
        "country": country,
        "state": state,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "city": city,
        "vat_no": vatNo,
        "email": email ?? '',
        "phone": phone ?? '',
        "code": code,
        "location": location,
        "city_code": cityCode,
        "customer_group_id": customerGroupId,
        "customer_group_name": customerGroupName,
        "price_group_name": priceGroupName,
        "price_group_id": priceGroupId,
        "postal_code": postalCode,
        "line1": line1,
        "line2": line2,
        "customer_address_seller_id_assigned": customerAddressSellerIdAssigned
      };
    }
  }

  String formatedContact() {
    String output = "";
    if (phone != null) {
      output += phone!;
    }
    if (email != null) {
      output += " - " + email!;
    }

    return capitalizeText(output);
  }

  String formatedDir() {
    String output = "";
    if (direccion != null) {
      output += direccion!;
    }
    // if (subzone != null) {
    //   output += " - " + subzone!;
    // }
    // if (subzone != null) {
    //   output += " - " + subzone!;
    // }

    return capitalizeText(output);
  }

  String formatedCityState() {
    String output = "";
    if (city != null) {
      output += city! + " - ";
    }
    if (state != null) {
      output += state!;
    }

    return capitalizeText(output);
  }

  @override
  String toString() {
    String dir = "";
    if (city != null) {
      dir += city! + " - ";
    }
    if (direccion != null) {
      dir += direccion! + " - ";
    }

    if (sucursal != null && (sucursal?.isNotEmpty ?? false)) {
      dir += sucursal!;
    }
    return capitalizeText(dir);
  }

  String toString2() {
    String dir = "";
    // if (city != null) {
    //   dir += city! + " ";
    // }
    if (direccion != null) {
      // dir += direccion! + " - ";
      dir += direccion!;
    }

    // if (sucursal != null && (sucursal?.isNotEmpty ?? false)) {
    //   dir += sucursal!;
    // }
    return capitalizeText(dir);
  }
}
