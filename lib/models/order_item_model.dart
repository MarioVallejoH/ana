// To parse this JSON data, do
//
//     final OrderSaleItemsModel = OrderSaleItemsModelFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/cart/models/cart_item_model.dart';
import 'package:customer_app/products/products_related/controller/products_related_controller.dart';
import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:customer_app/utils/parsing/numeric_paring.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'biller_data_model.dart';

class OrderSaleItemsModel {
  OrderSaleItemsModel({
    this.id,
    this.saleId,
    required this.productId,
    required this.productCode,
    required this.productName,
    required this.productType,
    this.optionId,
    required this.netUnitPrice,
    required this.unitPrice,
    required this.quantity,
    this.quantityToBill = 0,
    this.quantityDelivered = 0,
    required this.warehouseId,
    required this.itemTax,
    required this.taxRateId,
    required this.tax,
    this.itemTax2,
    this.taxRate2Id,
    this.tax2,
    this.discount,
    this.itemDiscount = 0,
    required this.subtotal,
    this.serialNo,
    this.realUnitPrice,
    this.saleItemId,
    this.productUnitId,
    this.productUnitCode,
    this.unitQuantity,
    this.comment,
    this.gst,
    this.cgst,
    this.sgst,
    this.igst,
    this.unitOrderDiscount,
    this.priceBeforeTax = 0.0,
    this.preferences,
    this.registrationDate,
  });

  String formatedSubtotal() {
    return getFormatedCurrency(subtotal, decimals: 1);
  }

  String formatedQtty() {
    return getRoundedQtty(quantity);
  }

  int? id;
  int? saleId;
  int productId;
  String productCode;
  String productName;
  String productType;
  int? optionId;
  double netUnitPrice;
  double unitPrice;
  double quantity;
  double quantityToBill;
  double quantityDelivered;
  int? warehouseId;
  double? itemTax;
  int? taxRateId;
  String? tax;
  double? itemTax2;
  int? taxRate2Id;
  String? tax2;
  String? discount;
  double? itemDiscount;
  double subtotal;
  String? serialNo;
  double? realUnitPrice;
  int? saleItemId;
  int? productUnitId;
  String? productUnitCode;
  double? unitQuantity;
  String? comment;
  String? gst;
  double? cgst;
  double? sgst;
  double? igst;
  double? unitOrderDiscount;
  double priceBeforeTax;
  String? preferences;
  String? registrationDate;

  factory OrderSaleItemsModel.fromRawJson(String str) =>
      OrderSaleItemsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderSaleItemsModel.fromJson(Map<String, dynamic> json) =>
      OrderSaleItemsModel(
        id: parsingToInt(json["id"]),
        saleId: parsingToInt(json["sale_id"]),
        productId: parsingToInt(json["product_id"]),
        productCode: json["product_code"],
        productName: json["product_name"],
        productType: json["product_type"],
        optionId: parsingToInt(json["option_id"]),
        netUnitPrice: parsingToDouble(json["net_unit_price"]),
        unitPrice: parsingToDouble(json["unit_price"]),
        quantity: parsingToDouble(json["quantity"]),
        quantityToBill: parsingToDouble(json["quantity_to_bill"]),
        quantityDelivered: parsingToDouble(json["quantity_delivered"]),
        warehouseId: parsingToInt(json["warehouse_id"]),
        itemTax: parsingToDoubleNullAble(json["item_tax"]),
        taxRateId: parsingToIntNullable(json["tax_rate_id"]),
        tax: json["tax"],
        itemTax2: parsingToDoubleNullAble(json["item_tax_2"]),
        taxRate2Id: parsingToIntNullable(json["tax_rate_2_id"]),
        tax2: json["tax_2"],
        discount: json["discount"],
        itemDiscount: parsingToDoubleNullAble(json["item_discount"]),
        subtotal: parsingToDouble(json["subtotal"]),
        serialNo: json["serial_no"],
        realUnitPrice: parsingToDoubleNullAble(json["real_unit_price"]),
        saleItemId: parsingToIntNullable(json["sale_item_id"]),
        productUnitId: parsingToIntNullable(json["product_unit_id"]),
        productUnitCode: json["product_unit_code"],
        unitQuantity: parsingToDoubleNullAble(json["unit_quantity"]),
        comment: json["comment"],
        gst: json["gst"],
        cgst: parsingToDoubleNullAble(json["cgst"]),
        sgst: parsingToDoubleNullAble(json["sgst"]),
        igst: parsingToDoubleNullAble(json["igst"]),
        unitOrderDiscount: parsingToDoubleNullAble(json["unit_order_discount"]),
        priceBeforeTax: parsingToDouble(json["price_before_tax"]),
        preferences: json["preferences"],
        registrationDate: json["registration_date"],
      );

  Map<String, dynamic> toJson() {
    return {
      "sale_id": saleId,
      "product_id": productId,
      "product_code": productCode,
      "product_name": productName,
      "product_type": productType,
      "option_id": optionId,
      "net_unit_price": netUnitPrice,
      "unit_price": unitPrice,
      "quantity": quantity,
      "quantity_to_bill": quantityToBill,
      "quantity_delivered": quantityDelivered,
      "warehouse_id": warehouseId,
      "item_tax": itemTax,
      "tax_rate_id": taxRateId,
      "tax": tax,
      "item_tax_2": itemTax2,
      "tax_rate_2_id": taxRate2Id,
      "tax_2": tax2,
      "discount": discount,
      "item_discount": itemDiscount,
      "subtotal": subtotal,
      "serial_no": serialNo,
      "real_unit_price": realUnitPrice,
      "sale_item_id": saleItemId,
      "product_unit_id": productUnitId,
      "product_unit_code": productUnitCode,
      "unit_quantity": unitQuantity,
      "comment": comment,
      "gst": gst,
      "cgst": cgst,
      "sgst": sgst,
      "igst": igst,
      "unit_order_discount": unitOrderDiscount,
      "price_before_tax": priceBeforeTax,
      "preferences": preferences,
      "registration_date": registrationDate,
    };
  }

  static List<OrderSaleItemsModel> fromJsonList(List list) {
    List<OrderSaleItemsModel> orders = [];
    Map<String, dynamic> temp = {};
    for (var item in list) {
      for (var i = 0; i < item.keys.length; i++) {
        temp[item.keys.toList()[i]] = item.values.toList()[i];
      }
      orders.add(OrderSaleItemsModel.fromJson(temp));
    }

    return orders;

    // prString(temp);
  }

  /// Build an instance of  OrderSaleItemsModel given a keys set to get products and units from
  /// order bloc
  static Future<List<Map<String, dynamic>>> buildOderSaleItems(
      List<CartItem> cartItems, BillerDataModel? billerData) async {
    List<Map<String, dynamic>> orderSaleItems = [];
    for (CartItem item in cartItems) {
      final product = item.product;
      final unit = item.unitsModel;
      double pIVA = 0;
      double pNoIVA = 0;
      final taxRate = Get.find<ProductsRelatedController>()
          .getProductTaxRateMethod(product.taxRate ?? 0);

      if (product.taxMethod == 1) {
        pIVA = item.price + item.price * (taxRate?.taxPercentVal ?? 0);
        pNoIVA = item.price;
      } else {
        pNoIVA = item.price / (1 + (taxRate?.taxPercentVal ?? 0));
        pIVA = item.price;
      }

      final taxValue = pIVA - pNoIVA;

      final orderSaleItem = OrderSaleItemsModel(
          productId: product.id,
          productCode: product.code,
          productName: product.name,
          productType: product.type,
          netUnitPrice: pNoIVA,
          priceBeforeTax: pNoIVA,
          unitPrice: pIVA,
          quantity: item.qtty,
          warehouseId: parsingToInt(billerData?.defaultWarehouseId),
          itemTax: taxValue,
          taxRateId: product.taxRate,
          productUnitCode: unit?.code,
          realUnitPrice: product.price,
          unitQuantity: product.quantity / (unit?.operationValue ?? 1),
          productUnitId: unit?.id,
          tax: taxRate?.name,
          preferences: item.getProductPrefsIds(),
          subtotal: pIVA * item.qtty);
      orderSaleItems.add(orderSaleItem.toJson());
    }
    return orderSaleItems;
  }

  String orderProductPrefs() {
    String prefsText = '';
    try {
      final Map<String,dynamic> prefs = jsonDecode(preferences ?? '');
      prefs.forEach((key, value) {
        final pCat = Get.find<ProductsRelatedController>()
            .getPrefCategory(parsingToInt(key));
        if (prefsText.isNotEmpty) {
          prefsText += ', ';
        }
        for (var element in (value as List)) {
          final pref = Get.find<ProductsRelatedController>()
            .getProdPref(parsingToInt(element));
          prefsText += '${pCat?.name}: ${pref?.name}';
        }
      });
    } catch (e) {
      prefsText = preferences ?? '';
      log(e);
    }

    return prefsText.replaceAll('  ', ' ').replaceAll('   ', ' ');
  }
}
