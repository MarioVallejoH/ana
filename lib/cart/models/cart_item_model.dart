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
      this.preferences,
      required this.price,
      required this.qtty});

  ProductModel product;
  UnitsModel? unitsModel;
  Map<PreferencesCategories, List<ProductPreference>>? preferences;
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
    final prefsId = _prefId();
    return id + prefsId;
  }

  String _prefId() {
    String prefsKey = '';
    if ((preferences ?? {}).isNotEmpty) {
      final List<int> prefsId = [];
      for (var prefCat in preferences!.keys) {
        preferences![prefCat]?.forEach((pref) {
          prefsId.add(pref.id);
          // prefsKey += pref.id ?? '';
        });
      }
      prefsId.sort();
      prefsKey = prefsId.join();
    }

    return prefsKey;
  }

  double subTotal() {
    return price * qtty;
  }

  String formatedPrice() {
    return getFormatedCurrency(subTotal());
  }

  /// Generate a prefs text description to show
  String prefsText() {
    String prefsText = '';
    if (preferences != null && (preferences?.isNotEmpty ?? false)) {
      preferences!.forEach((key, value) {
        // String keyText = key.name ?? '';
        String text = '';
        for (ProductPreference element in value) {
          if (element == value.last) {
            text += '' + element.name!;
          } else {
            text += '' + element.name! + ', ';
          }
        }
        if (text.isNotEmpty) {
          if (prefsText.isNotEmpty) {
            prefsText += " / " + text;
          } else {
            prefsText += text;
          }
        }
      });
    }
    return prefsText;
  }

  String getProductPrefsText() {
    String prefsText = '';
    try {
      for (PreferencesCategories prefCat in (preferences?.keys ?? [])) {
        if (prefCat.name != null) {
          if (prefsText.isNotEmpty) {
            prefsText += ', ';
          }
          prefsText += '<b>' + prefCat.name! + ':</b> ';
        } else {
          prefsText += '';
        }

        for (ProductPreference pref in preferences?[prefCat] ?? []) {
          prefsText += pref != preferences?[prefCat]?.last
              ? ((pref.name ?? '') + ', ')
              : (pref.name ?? '');
        }
      }
    } catch (e) {
      log(e);
    }
    return prefsText;
  }

  String getProductPrefsIds() {
    Map<String, List<int>> prefsText = {};
    try {
      for (PreferencesCategories prefCat in (preferences?.keys ?? [])) {
        List<int> prodPrefIds = [];

        for (ProductPreference pref in preferences?[prefCat] ?? []) {
          prodPrefIds.add(pref.id);
        }
        prefsText[prefCat.id.toString()] = (prodPrefIds);
      }
    } catch (e) {
      log(e);
    }
    // log(prefsText);
    return jsonEncode(prefsText);
  }
}
