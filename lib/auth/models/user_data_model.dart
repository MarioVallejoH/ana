// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/models/address_model.dart';
import 'package:customer_app/utils/parsing/numeric_paring.dart';
import 'package:flutter/cupertino.dart';

import '../../models/companies_model.dart';

class UserDataModel {
  UserDataModel(
      {required this.id,
      this.lastIpAddress,
      required this.ipAddress,
      required this.username,
      this.salt,
      required this.email,
      this.activationCode,
      this.forgottenPasswordCode,
      this.forgottenPasswordTime,
      this.rememberCode,
      this.createdOn,
      this.lastLogin,
      required this.active,
      this.firstName,
      this.lastName,
      this.company,
      this.phone,
      this.avatar,
      this.gender,
      this.groupId = 0,
      this.warehouseId = 0,
      this.billerId = 0,
      this.documentTypeId = 0,
      required this.companyId,
      this.showCost,
      this.showPrice,
      this.awardPoints,
      this.viewRight,
      this.editRight,
      this.allowDiscount,
      this.loginHour,
      this.loginStatus,
      this.sellerId,
      this.logOutOrder,
      this.loginCode,
      this.dashboardId,
      this.registerCashMovementsWithAnotherUser,
      this.cantFinishPosInvoice,
      this.userPcSerial,
      this.mainAdministrator,
      required this.termsAndConditionsAccepted,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  final int id;
  final String? lastIpAddress;
  final String ipAddress;
  final String username;
  final dynamic salt;
  final String email;
  final dynamic activationCode;
  final dynamic forgottenPasswordCode;
  final dynamic forgottenPasswordTime;
  final dynamic rememberCode;
  final int? createdOn;
  final int? lastLogin;
  final int active;
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? phone;
  final String? avatar;
  final String? gender;
  final int groupId;
  final int warehouseId;
  final int billerId;
  final int documentTypeId;
  final int companyId;
  final dynamic showCost;
  final int? showPrice;
  final int? awardPoints;
  final int? viewRight;
  final int? editRight;
  final int? allowDiscount;
  final dynamic loginHour;
  final int? loginStatus;
  final int? sellerId;
  final int? logOutOrder;
  final String? loginCode;
  final int? dashboardId;
  final int? registerCashMovementsWithAnotherUser;
  final int? cantFinishPosInvoice;
  final String? userPcSerial;
  final dynamic mainAdministrator;
  final int? termsAndConditionsAccepted;
  final dynamic emailVerifiedAt;
  final dynamic createdAt;
  final dynamic updatedAt;
  CompanyModel? companyData;
  ValueNotifier<AddressModel?> selectedAddressListenable = ValueNotifier(null);

  AddressModel? get selectedAddress => selectedAddressListenable.value;

  setSelectedAddress(AddressModel? address) {
    selectedAddressListenable.value = address;
  }

  factory UserDataModel.fromRawJson(String str) =>
      UserDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        id: json["id"],
        lastIpAddress: json["last_ip_address"],
        ipAddress: json["ip_address"],
        username: json["username"],
        salt: json["salt"],
        email: json["email"],
        activationCode: json["activation_code"],
        forgottenPasswordCode: json["forgotten_password_code"],
        forgottenPasswordTime: json["forgotten_password_time"],
        rememberCode: json["remember_code"],
        createdOn: json["created_on"],
        lastLogin: json["last_login"],
        active: parsingToInt(json["active"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        phone: json["phone"],
        avatar: json["avatar"],
        gender: json["gender"],
        groupId: json["group_id"],
        warehouseId: parsingToInt(json["warehouse_id"]),
        billerId: parsingToInt(json["biller_id"]),
        documentTypeId: parsingToInt(json["document_type_id"]),
        companyId: parsingToInt(json["company_id"]),
        showCost: json["show_cost"],
        showPrice: json["show_price"],
        awardPoints: json["award_points"],
        viewRight: json["view_right"],
        editRight: json["edit_right"],
        allowDiscount: json["allow_discount"],
        loginHour: json["login_hour"],
        loginStatus: json["login_status"],
        sellerId: json["seller_id"],
        logOutOrder: json["log_out_order"],
        loginCode: json["login_code"],
        dashboardId: json["dashboard_id"],
        registerCashMovementsWithAnotherUser:
            json["register_cash_movements_with_another_user"],
        cantFinishPosInvoice: json["cant_finish_pos_invoice"],
        userPcSerial: json["user_pc_serial"],
        mainAdministrator: json["main_administrator"],
        termsAndConditionsAccepted: json["terms_and_conditions_accepted"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_ip_address": lastIpAddress,
        "ip_address": ipAddress,
        "username": username,
        "salt": salt,
        "email": email,
        "activation_code": activationCode,
        "forgotten_password_code": forgottenPasswordCode,
        "forgotten_password_time": forgottenPasswordTime,
        "remember_code": rememberCode,
        "created_on": createdOn,
        "last_login": lastLogin,
        "active": active,
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "phone": phone,
        "avatar": avatar,
        "gender": gender,
        "group_id": groupId,
        "warehouse_id": warehouseId,
        "biller_id": billerId,
        "document_type_id": documentTypeId,
        "company_id": companyId,
        "show_cost": showCost,
        "show_price": showPrice,
        "award_points": awardPoints,
        "view_right": viewRight,
        "edit_right": editRight,
        "allow_discount": allowDiscount,
        "login_hour": loginHour,
        "login_status": loginStatus,
        "seller_id": sellerId,
        "log_out_order": logOutOrder,
        "login_code": loginCode,
        "dashboard_id": dashboardId,
        "register_cash_movements_with_another_user":
            registerCashMovementsWithAnotherUser,
        "cant_finish_pos_invoice": cantFinishPosInvoice,
        "user_pc_serial": userPcSerial,
        "main_administrator": mainAdministrator,
        "terms_and_conditions_accepted": termsAndConditionsAccepted,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  String get name => (firstName ?? '');
}
