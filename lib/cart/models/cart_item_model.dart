// To parse this JSON data, do
//
//     final CartItem = CartItemFromJson(jsonString);

import 'dart:convert';

import 'package:customer_app/products/products.dart';
import 'package:customer_app/utils/formating/data_formating.dart';
import 'package:customer_app/utils/parsing/numeric_paring.dart';
import 'package:nb_utils/nb_utils.dart';

List<CartItem> cartItemFromJson(String str) =>
    List<CartItem>.from(json.decode(str).map((x) => CartItem.fromJson(x)));

String cartItemToJson(List<CartItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItem {
  CartItem(
      {required this.product,
      // this.unitPrice,
      this.unitsModel,
      required this.price,
      required this.qtty});

  ProductModel product;
  UnitsModel? unitsModel;
  // UnitPrice? unitPrice;
  double price;
  double qtty;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
      product: ProductModel.fromJson(json['product'] ?? {}),
      price: parsingToDouble(json['price']),
      qtty: parsingToDouble(json['qtty']));

  Map<String, dynamic> toJson() => {"product": product.toJson()};

  Map<String, dynamic> toJsonToSave() => {
        "product": product.id,
        "unit": unitsModel?.id,
        "price": price,
        "qtty": qtty
      };

  /// Generate a unique Id for product with selected unit and selected prefs
  String id() {
    String id = product.id.toString() + (unitsModel?.id.toString() ?? '');
    return id;
  }



  double subTotal() {
    return price * qtty;
  }

  String formatedPrice() {
    return getFormatedCurrency(subTotal());
  }

}
