import 'dart:convert';

import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/models/address_model.dart';
import 'package:customer_app/models/biller_data_model.dart';
import 'package:customer_app/orders/orders_list/models/order_model.dart';
import 'package:customer_app/auth/models/user_data_model.dart';
import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/products/product_details/services/products_data_service.dart';
import 'package:customer_app/products/products.dart';
import 'package:customer_app/products/products_related/controller/products_related_controller.dart';
import 'package:customer_app/utils/parsing/numeric_paring.dart';
// import 'package:customer_app/utils/parsing/string_to_map.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/order_item_model.dart';
import '../../models/cart_item_model.dart';

class CartService {
  Future<void> saveCart({List<CartItem>? cartData}) async {
    Map<String, dynamic> cartMap = {};
    List<String> prefData = [];
    for (CartItem cItem in cartData ?? []) {
      final cartItemData = {
        "product_data": cItem.product.toJson(),
        "unit_selected": cItem.unitsModel?.toJson(),
        // "has_preferences":,
        "quantity": cItem.qtty,
        "price": cItem.price
      };
      cartMap[cItem.id()] = cartItemData;
    }
    log('Removing previously saved cart');
    await removeKey('cart_data');
    await removeKey('cart_prefs_data');

    log('Saving new cart cart');
    final result = await setValue("cart_data", cartMap, print: false);
    final result2 = await setValue("cart_prefs_data", prefData, print: false);
    if (result) {
      log('Success on saving new cart cart');
    } else {
      log('Error on saving new cart cart');
    }
  }

  Future<List<CartItem>> loadCart() async {
    // await Future.delayed(const Duration(seconds: 4));
    final storedCartData = getJSONAsync("cart_data");
    final prefData = getStringListAsync("cart_prefs_data");
    log("Numero de items detectados: ${storedCartData.keys.length}");

    // final cartData = jsonDecode(storedCartData);
    // load product data for each cart item
    final items = await _loadCartFromSaved(
      storedCartData,
      prefData,
    );
    log("Numero de items cargado: ${items.length}");
    // CartBloc().setCart(items);
    return items;
  }

  Future<List<CartItem>> _loadCartFromSaved(
      Map<String, dynamic> cartData, List<String>? prefData,
      {int attempts = 1}) async {
    List<CartItem> cart = [];
    if (cartData.isNotEmpty) {
      try {
        cartData.values.forEachIndexed((element, index) {
          final cartItemData = element as Map;
          ProductModel? product;

          UnitsModel? unit;
          try {
            product = ProductModel.fromJson(cartItemData['product_data']);
            unit = UnitsModel.fromJson((cartItemData['unit_selected']));
          } catch (e) {
            log(e);
          }
          Map<PreferencesCategories, List<ProductPreference>> prefs = {};
          if ((prefData?[index]) != "") {
            final t = prefData?[index].split("~~");

            for (String e in t ?? []) {
              final t1 = e.split('|');
              PreferencesCategories? pCat;
              List<ProductPreference> pPrefs = [];
              t1.forEachIndexed((pData, index2) {
                if (index2.isEven) {
                  pCat = PreferencesCategories.fromJson(jsonDecode(pData));
                } else {
                  pPrefs = ProductPreference.fromJsonList(jsonDecode(pData));
                }
                if (pCat != null && pPrefs.isNotEmpty) {
                  prefs[pCat!] = pPrefs;
                }
              });
            }
          }
          final qtty = cartItemData['quantity'];
          if (product != null) {
            final price = parsingToDoubleNullAble(cartItemData['price']);
            try {
              cart.add(CartItem(
                product: product,
                unitsModel: unit,
                price: price!,
                qtty: qtty,
              ));
            } catch (e) {
              log(e);
            }
          }
        });
        // await Future.forEach(cartData.values, (element) async {});
      } catch (e) {
        log(e);
        // if (attempts < 2) {
        //   log('Intento de cargar el carrito guardado No ${attempts + 1}');
        //   await Future.delayed(const Duration(seconds: 2));
        //   return await _loadCartFromSaved(cartData, attempts: attempts + 1);
        // }
      }
    }
    return cart;
  }

  Future<double?> getProductPrice(
      int productId, UnitsModel unit, double qtty) async {
    // here we should ask for price policy, this is only for  price policy=10
    try {
      final unitPrices = await ProductsDataService().findProductUnitPrices(
        productId,
        null,
        unitId: unit.id,
      );
      final selUnitPrice = unitPrices.firstWhere((element) =>
          element.idProduct == productId && element.unitId == unit.id);
      final price = selUnitPrice.valorUnitario / unit.operationValue;
      return price * qtty;
    } catch (e) {
      log(e);
      return null;
    }
  }

  Future<Map<PreferencesCategories, List<ProductPreference>>> getProdPrefs(
      int productId, Map prefsData) async {
    final productPrefs =
        await ProductsDataService().findProductPreferences(productId);
    final Map<PreferencesCategories, List<ProductPreference>>
        prodPrefsSelected = {};
    prefsData.forEach((key, value) {
      final prefCat =
          Get.find<ProductsRelatedController>().getPrefCategory(key);
      if (prefCat != null) {
        final pPrefs = productPrefs[key]
            ?.where((element) => value.contains(element.id))
            .toList();
        if (pPrefs != null) {
          prodPrefsSelected[prefCat] = pPrefs;
        }
      }
    });
    return prodPrefsSelected;
  }

  Future<void> removeSavedCart() async {
    await removeKey('cart_data');
  }

  Future<Map<String, dynamic>> sendCart(
      List<CartItem> cart,
      UserDataModel userData,
      BillerDataModel billerData,
      AddressModel? selectedAddress,
      Map<String, double> orderTotals,
      int deliveryTyId,
      String deliveryDate,
      String comment) async {
    Map<String, dynamic> result = {};
    final orderItems = await OrderSaleItemsModel.buildOderSaleItems(
      cart,
      billerData,
    );
    final orderInfo = await OrderModel.buildOrder(
      userData,
      billerData,
      selectedAddress,
      orderTotals,
      deliveryTyId,
      deliveryDate,
      comment,
    );

    final info = {"order": orderInfo.toJson(), "order_items": orderItems};

    result = await DataProvider.postPetition(orderCreateEndP, info);

    //log(info);

    return result;
  }
}
