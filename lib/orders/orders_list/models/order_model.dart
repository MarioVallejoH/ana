// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/models/address_model.dart';
import 'package:customer_app/models/biller_data_model.dart';
import 'package:customer_app/utils/parsing/numeric_paring.dart';
import '../../../utils/formating/data_formating.dart';
import '../../../auth/models/user_data_model.dart';

// import 'package:pos_wappsi/bloc/orders_bloc.dart';
// import 'package:pos_wappsi/models/user_model.dart';

class OrderModel {
  OrderModel({
    this.id,
    this.date,
    required this.customerId,
    required this.customer,
    this.note,
    this.staffNote,
    required this.total,
    required this.productDiscount,
    this.orderDiscountId,
    required this.totalDiscount,
    required this.orderDiscount,
    required this.productTax,
    this.orderTaxId,
    required this.orderTax,
    required this.totalTax,
    this.shipping,
    required this.grandTotal,
    required this.saleStatus,
    this.paymentStatus,
    this.paymentTerm,
    required this.dueDate,
    required this.createdBy,
    this.updatedBy,
    this.updatedAt,
    required this.totalItems,
    this.paid = 0,
    this.returnId,
    this.surcharge,
    this.attachment,
    this.returnSaleRef,
    this.saleId,
    this.returnSaleTotal = 0,
    this.rounding,
    this.suspendNote,
    this.api,
    required this.shop,
    required this.sellerId,
    required this.addressId,
    this.reserveId,
    this.hash,
    this.manualPayment,
    this.cgst,
    this.sgst,
    this.igst,
    this.paymentMethod,
    required this.payPartner,
    this.reteFuentePercentage,
    this.reteFuenteTotal,
    this.reteFuenteAccount,
    this.reteFuenteBase,
    required this.documentTypeId,
    this.registrationDate,
    this.orderSaleOrigin = 3,
  });

  int? id;
  String? date;
  int customerId;
  String customer;
  dynamic note;
  dynamic staffNote;
  double? total;
  double productDiscount;
  dynamic orderDiscountId;
  double totalDiscount;
  double orderDiscount;
  double productTax;
  dynamic orderTaxId;
  int orderTax;
  double totalTax;
  double? shipping;
  double grandTotal;
  String saleStatus;
  dynamic paymentStatus;
  dynamic paymentTerm;
  String? dueDate;
  String? deliveryText;
  int createdBy;
  dynamic updatedBy;
  dynamic updatedAt;
  int totalItems;
  int paid;
  dynamic returnId;
  int? surcharge;
  dynamic attachment;
  dynamic returnSaleRef;
  dynamic saleId;
  int? returnSaleTotal;
  dynamic rounding;
  dynamic suspendNote;
  int? api;
  int shop;
  int sellerId;
  int addressId;
  dynamic reserveId;
  String? hash;
  dynamic manualPayment;
  dynamic cgst;
  dynamic sgst;
  dynamic igst;
  String? paymentMethod;
  int? payPartner;
  int? reteFuentePercentage;
  int? reteFuenteTotal;
  int? reteFuenteAccount;
  dynamic reteFuenteBase;
  int documentTypeId;
  String? registrationDate;
  int orderSaleOrigin;

  factory OrderModel.fromRawJson(String str) =>
      OrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        date: json["date"],
        customerId: json["customer_id"],
        customer: json["customer"],
        note: json["note"],
        staffNote: json["staff_note"],
        total: double.tryParse(json["total"].toString()),
        productDiscount:
            double.tryParse(json["product_discount"].toString()) ?? 0.0,
        orderDiscountId: json["order_discount_id"],
        totalDiscount:
            double.tryParse(json["total_discount"].toString()) ?? 0.0,
        orderDiscount:
            double.tryParse(json["order_discount"].toString()) ?? 0.0,
        productTax: double.tryParse(json["product_tax"].toString()) ?? 0.0,
        orderTaxId: json["order_tax_id"],
        orderTax: parsingToInt(json["order_tax"]),
        totalTax: double.tryParse(json["total_tax"].toString()) ?? 0.0,
        shipping: double.tryParse(json["shipping"].toString()),
        grandTotal: double.tryParse(json["grand_total"].toString()) ?? 0.0,
        saleStatus: json["sale_status"],
        paymentStatus: json["payment_status"],
        paymentTerm: json["payment_term"],
        dueDate: json["due_date"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"],
        totalItems: json["total_items"],
        paid: parsingToInt(json["paid"]),
        returnId: json["return_id"],
        surcharge: parsingToIntNullable(json["surcharge"]),
        attachment: json["attachment"],
        returnSaleRef: json["return_sale_ref"],
        saleId: json["sale_id"],
        returnSaleTotal: parsingToInt(json["return_order_total"]),
        rounding: json["rounding"],
        suspendNote: json["suspend_note"],
        api: parsingToInt(json["api"]),
        shop: parsingToInt(json["shop"]),
        sellerId: parsingToInt(json["seller_id"]),
        addressId: parsingToInt(json["address_id"]),
        reserveId: parsingToInt(json["reserve_id"]),
        hash: json["hash"],
        manualPayment: json["manual_payment"],
        cgst: json["cgst"],
        sgst: json["sgst"],
        igst: json["igst"],
        paymentMethod: json["payment_method"],
        payPartner: parsingToIntNullable(json["pay_partner"]),
        reteFuentePercentage:
            parsingToIntNullable(json["rete_fuente_percentage"]),
        reteFuenteTotal: parsingToIntNullable(json["rete_fuente_total"]),
        reteFuenteAccount: parsingToIntNullable(json["rete_fuente_account"]),
        reteFuenteBase: json["rete_fuente_base"],
        documentTypeId: parsingToInt(json["document_type_id"]),
        registrationDate: json["registration_date"],
        
        orderSaleOrigin: parsingToInt(json["order_sale_origin"]),
      );

  String formatedGrandTotal() {
    return getFormatedCurrency(grandTotal);
  }

  String formatedSubtotal() {
    return getFormatedCurrency(total ?? 0);
  }

  String formatedDiscount() {
    return getFormatedCurrency(totalDiscount);
  }

  String formatedTax() {
    return getFormatedCurrency(totalTax);
  }

  String formatedShipping() {
    return getFormatedCurrency(shipping ?? 0);
  }

  Map<String, dynamic> toJson({bool toCreateOrder = true}) {
    if (toCreateOrder) {
      return {
        "customer_id": customerId,
        "customer": customer,
        "note": note,
        "staff_note": staffNote,
        "total": total,
        "product_discount": productDiscount,
        "order_discount_id": orderDiscountId,
        "total_discount": totalDiscount,
        "order_discount": orderDiscount,
        "product_tax": productTax,
        "order_tax_id": orderTaxId,
        "order_tax": orderTax,
        "total_tax": totalTax,
        "shipping": shipping,
        "grand_total": grandTotal,
        "sale_status": saleStatus,
        "payment_status": paymentStatus,
        "payment_term": paymentTerm,
        "due_date": dueDate,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "updated_at": updatedAt,
        "total_items": totalItems,
        "paid": paid,
        "return_id": returnId,
        "surcharge": surcharge,
        "attachment": attachment,
        "return_sale_ref": returnSaleRef,
        "sale_id": saleId,
        "return_sale_total": returnSaleTotal,
        "rounding": rounding,
        "suspend_note": suspendNote,
        "api": api,
        "shop": shop,
        "seller_id": sellerId,
        "address_id": addressId,
        "reserve_id": reserveId,
        "hash": hash,
        "manual_payment": manualPayment,
        "cgst": cgst,
        "sgst": sgst,
        "igst": igst,
        "payment_method": paymentMethod,
        "pay_partner": payPartner,
        "rete_fuente_percentage": reteFuentePercentage,
        "rete_fuente_total": reteFuenteTotal,
        "rete_fuente_account": reteFuenteAccount,
        "rete_fuente_base": reteFuenteBase,
        "document_type_id": documentTypeId,
        "order_sale_origin": orderSaleOrigin
      };
    } else {
      return {
        "id": id,
        "delivery_text": deliveryText,
        "date": date,
        "customer_id": customerId,
        "customer": customer,
        "note": note,
        "staff_note": staffNote,
        "total": total,
        "product_discount": productDiscount,
        "order_discount_id": orderDiscountId,
        "total_discount": totalDiscount,
        "order_discount": orderDiscount,
        "product_tax": productTax,
        "order_tax_id": orderTaxId,
        "order_tax": orderTax,
        "total_tax": totalTax,
        "shipping": shipping,
        "grand_total": grandTotal,
        "sale_status": saleStatus,
        "payment_status": paymentStatus,
        "payment_term": paymentTerm,
        "due_date": dueDate,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "updated_at": updatedAt,
        "total_items": totalItems,
        "paid": paid,
        "return_id": returnId,
        "surcharge": surcharge,
        "attachment": attachment,
        "return_sale_ref": returnSaleRef,
        "sale_id": saleId,
        "return_sale_total": returnSaleTotal,
        "rounding": rounding,
        "suspend_note": suspendNote,
        "api": api,
        "shop": shop,
        "seller_id": sellerId,
        "address_id": addressId,
        "reserve_id": reserveId,
        "hash": hash,
        "manual_payment": manualPayment,
        "cgst": cgst,
        "sgst": sgst,
        "igst": igst,
        "payment_method": paymentMethod,
        "pay_partner": payPartner,
        "rete_fuente_percentage": reteFuentePercentage,
        "rete_fuente_total": reteFuenteTotal,
        "rete_fuente_account": reteFuenteAccount,
        "rete_fuente_base": reteFuenteBase,
        "document_type_id": documentTypeId,
        "registration_date": registrationDate,
        "order_sale_origin": orderSaleOrigin
      };
    }
  }

  static List<OrderModel> fromJsonList(List list) {
    List<OrderModel> orders = [];
    Map<String, dynamic> temp = {};
    for (var item in list) {
      for (var i = 0; i < item.keys.length; i++) {
        temp[item.keys.toList()[i]] = item.values.toList()[i];
      }
      orders.add(OrderModel.fromJson(temp));
    }

    return orders;

    // prString(temp);
  }

  @override

  /// Build an instance of OrderModel given productDetails, user, customer and
  /// customerAddress
  static Future<OrderModel> buildOrder(
    UserDataModel userData,
    BillerDataModel billerData,
    AddressModel? selectedAddress,
    Map<String, double> orderTotals,
    int deliveryTyId,
    String deliveryDate,
    String comment,
  ) async {
    return OrderModel(
        // here we add order tax if needed
        totalTax: orderTotals['total_tax']!,
        saleStatus: 'pending',
        documentTypeId: parsingToInt(billerData.orderSalesDocumentTypeDefault),
        addressId: parsingToInt(selectedAddress?.id),
        surcharge: 0,
        api: 1,
        orderTax: 0,
        customerId: userData.companyData?.id ?? userData.companyId,
        total: orderTotals['total']!,
        grandTotal: orderTotals['grand_total']!,
        orderDiscount: orderTotals['order_discount']!,
        customer: userData.companyData?.name ?? userData.name,
        note: '',
        sellerId: parsingToInt(billerData.defaultSellerId),
        createdBy: userData.id,
        // deliveryTimeId:,
        dueDate: null,
        // staffNote: orderBloc.getInternalNote ?? '',
        totalItems: orderTotals['total_items']!.toInt(),
        productTax: orderTotals['product_tax']!,
        paymentTerm: null,
        productDiscount: orderTotals['product_discount']!,
        totalDiscount: orderTotals['order_discount']!,
        shop: 0,
        orderSaleOrigin: 3,
        staffNote: comment,
        payPartner: 0);
  }
}
