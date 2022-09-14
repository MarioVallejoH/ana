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
    required this.referenceNo,
    required this.customerId,
    required this.customer,
    required this.billerId,
    required this.biller,
    required this.warehouseId,
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
    this.pos,
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
    this.reteIvaPercentage,
    this.reteIvaTotal,
    this.reteIvaAccount,
    this.reteIvaBase,
    this.reteIcaPercentage,
    this.reteIcaTotal,
    this.reteIcaAccount,
    this.reteIcaBase,
    this.reteOtherPercentage,
    this.reteOtherTotal,
    this.deliveryText,
    this.reteOtherAccount,
    this.deliveryDay,
    this.deliveryTimeId,
    this.reteOtherBase,
    this.resolucion,
    required this.documentTypeId,
    this.destinationReferenceNo,
    this.registrationDate,
    this.wmsPickingStatus,
    this.orderSaleOrigin = 3,
    this.wmsPackingStatus,
  });

  int? id;
  String? date;
  String? referenceNo;
  int customerId;
  String customer;
  int billerId;
  String biller;
  int warehouseId;
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
  String? deliveryDay;
  int? deliveryTimeId;
  int? pos;
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
  double? reteIvaPercentage;
  dynamic reteIvaTotal;
  dynamic reteIvaAccount;
  dynamic reteIvaBase;
  dynamic reteIcaPercentage;
  dynamic reteIcaTotal;
  dynamic reteIcaAccount;
  dynamic reteIcaBase;
  dynamic reteOtherPercentage;
  dynamic reteOtherTotal;
  dynamic reteOtherAccount;
  dynamic reteOtherBase;
  dynamic resolucion;
  int documentTypeId;
  dynamic destinationReferenceNo;
  String? registrationDate;
  dynamic wmsPickingStatus;
  dynamic wmsPackingStatus;
  int orderSaleOrigin;

  factory OrderModel.fromRawJson(String str) =>
      OrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        date: json["date"],
        referenceNo: json["reference_no"],
        customerId: json["customer_id"],
        customer: json["customer"],
        billerId: json["biller_id"],
        biller: json["biller"],
        warehouseId: json["warehouse_id"],
        note: json["note"],
        deliveryText: json['delivery_text'],
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
        deliveryDay: json["delivery_day"],
        deliveryTimeId: json["delivery_time_id"],
        pos: json["pos"],
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
        reteIvaPercentage: parsingToDoubleNullAble(json["rete_iva_percentage"]),
        reteIvaTotal: json["rete_iva_total"],
        reteIvaAccount: json["rete_iva_account"],
        reteIvaBase: json["rete_iva_base"],
        reteIcaPercentage: json["rete_ica_percentage"],
        reteIcaTotal: json["rete_ica_total"],
        reteIcaAccount: json["rete_ica_account"],
        reteIcaBase: json["rete_ica_base"],
        reteOtherPercentage: json["rete_other_percentage"],
        reteOtherTotal: json["rete_other_total"],
        reteOtherAccount: json["rete_other_account"],
        reteOtherBase: json["rete_other_base"],
        resolucion: json["resolucion"],
        documentTypeId: parsingToInt(json["document_type_id"]),
        destinationReferenceNo: json["destination_reference_no"],
        registrationDate: json["registration_date"],
        wmsPickingStatus: json["wms_picking_status"],
        orderSaleOrigin: parsingToInt(json["order_sale_origin"]),
        wmsPackingStatus: json["wms_packing_status"],
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
        "reference_no": referenceNo,
        "customer_id": customerId,
        "customer": customer,
        "biller_id": 2,
        "biller": biller,
        "warehouse_id": warehouseId,
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
        "pos": pos,
        "paid": paid,
        "return_id": returnId,
        "surcharge": surcharge,
        "attachment": attachment,
        "delivery_day": deliveryDay,
        "delivery_time_id": deliveryTimeId,
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
        "rete_iva_percentage": reteIvaPercentage,
        "rete_iva_total": reteIvaTotal,
        "rete_iva_account": reteIvaAccount,
        "rete_iva_base": reteIvaBase,
        "rete_ica_percentage": reteIcaPercentage,
        "rete_ica_total": reteIcaTotal,
        "rete_ica_account": reteIcaAccount,
        "rete_ica_base": reteIcaBase,
        "rete_other_percentage": reteOtherPercentage,
        "rete_other_total": reteOtherTotal,
        "rete_other_account": reteOtherAccount,
        "rete_other_base": reteOtherBase,
        "resolucion": resolucion,
        "document_type_id": documentTypeId,
        "destination_reference_no": destinationReferenceNo,
        "wms_picking_status": wmsPickingStatus,
        "wms_packing_status": wmsPackingStatus,
        "order_sale_origin": orderSaleOrigin
      };
    } else {
      return {
        "id": id,
        "delivery_text": deliveryText,
        "date": date,
        "reference_no": referenceNo,
        "customer_id": customerId,
        "customer": customer,
        "biller_id": billerId,
        "biller": biller,
        "warehouse_id": warehouseId,
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
        "pos": pos,
        "paid": paid,
        "delivery_day": deliveryDay,
        "delivery_time_id": deliveryTimeId,
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
        "rete_iva_percentage": reteIvaPercentage,
        "rete_iva_total": reteIvaTotal,
        "rete_iva_account": reteIvaAccount,
        "rete_iva_base": reteIvaBase,
        "rete_ica_percentage": reteIcaPercentage,
        "rete_ica_total": reteIcaTotal,
        "rete_ica_account": reteIcaAccount,
        "rete_ica_base": reteIcaBase,
        "rete_other_percentage": reteOtherPercentage,
        "rete_other_total": reteOtherTotal,
        "rete_other_account": reteOtherAccount,
        "rete_other_base": reteOtherBase,
        "resolucion": resolucion,
        "document_type_id": documentTypeId,
        "destination_reference_no": destinationReferenceNo,
        "registration_date": registrationDate,
        "wms_picking_status": wmsPickingStatus,
        "wms_packing_status": wmsPackingStatus,
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
  toString() => referenceNo ?? '';

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
        referenceNo: null,
        documentTypeId: parsingToInt(billerData.orderSalesDocumentTypeDefault),
        addressId: parsingToInt(selectedAddress?.id),
        pos: 0,
        surcharge: 0,
        api: 1,
        orderTax: 0,
        customerId: userData.companyData?.id ?? userData.companyId,
        total: orderTotals['total']!,
        grandTotal: orderTotals['grand_total']!,
        orderDiscount: orderTotals['order_discount']!,
        customer: userData.companyData?.name ?? userData.name,
        biller: '',
        billerId: parsingToInt(billerData.billerId),
        note: '',
        sellerId: parsingToInt(billerData.defaultSellerId),
        warehouseId: parsingToInt(billerData.defaultWarehouseId),
        createdBy: userData.id,
        deliveryDay: DateTime.now().toString(),
        // deliveryTimeId:,
        dueDate: null,
        // staffNote: orderBloc.getInternalNote ?? '',
        totalItems: orderTotals['total_items']!.toInt(),
        productTax: orderTotals['product_tax']!,
        paymentTerm: null,
        productDiscount: orderTotals['product_discount']!,
        totalDiscount: orderTotals['order_discount']!,
        deliveryTimeId: deliveryTyId,
        shop: 0,
        orderSaleOrigin: 3,
        staffNote: comment,
        payPartner: 0);
  }
}
