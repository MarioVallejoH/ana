import 'package:customer_app/cart/models/cart_item_model.dart';
import 'package:customer_app/cart/cart/services/cart_service.dart';
import 'package:customer_app/models/delivery_time_model.dart';

import 'package:customer_app/home/controllers/home_controller.dart';
import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/products/products_related/controller/products_related_controller.dart';
import 'package:customer_app/routes/controllers/app_settings_controller.dart';
import 'package:customer_app/utils/formating/date_to_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class CartController extends GetxController with StateMixin<List<CartItem>> {
  CartController({required this.service}) {
    change([], status: RxStatus.loading());
  }

  final CartService service;
  Future<void> loadData() async {
    final cartItems = await service.loadCart();
    change(cartItems, status: RxStatus.success());
  }
  // @override
  // void onInit() {
  //   controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 5),
  //   );
  //   // controller.repeat(reverse: true)
  //   super.onInit();
  // }

  // late AnimationController controller;

  final GlobalKey<FormState> orderDetailsFormKey = GlobalKey<FormState>();

  // final RxList<CartItem> state = List<CartItem>.empty(growable: true).obs;

  CartItem? lastDeleted;

  final RxList<DeliveryTime> _deliveryTimes =
      List<DeliveryTime>.empty(growable: true).obs;

  final Rx<TextEditingController> _dateTextController =
      TextEditingController().obs;

  final Rx<TextEditingController> _commentTextController =
      TextEditingController().obs;

  final RxBool _creatingOrder = false.obs;

  final Rx<DateTime?> _selectedDate = DateTime.now().obs;

  CartItem? selectedCartItem;

  final Rx<DeliveryTime?> _selectedTime = DeliveryTime(
          id: 0,
          day: '',
          time1: const TimeOfDay(hour: 0, minute: 0),
          time2: const TimeOfDay(hour: 0, minute: 0))
      .obs;

  bool get creatingOrder => _creatingOrder.value;

  set creatingOrder(bool value) {
    _creatingOrder.value = value;
  }

  DateTime? get deliveryDate => _selectedDate.value;

  DeliveryTime? get deliveryTime =>
      _selectedTime.value?.id == 0 ? null : _selectedTime.value;

  TextEditingController get dateTextController => _dateTextController.value;

  TextEditingController get commentTextController =>
      _commentTextController.value;

  // ignore: invalid_use_of_protected_member
  List<DeliveryTime> get deliveryTimes => _deliveryTimes.value;

  void updateCart({bool setNull = false}) {
    if (setNull) {
      state?.clear();
    }
    change(setNull ? [] : state, status: RxStatus.success());
    saveCurrrentCart();
  }

  Future<void> getNewDeliveryTimes() async {
    final delvTimes = await service.getAvaibleDelivTimes(
        _selectedDate.value?.toIso8601String() ?? '',
        Get.find<HomeController>().selectedAddrss?.location ?? '');
    // ignore: invalid_use_of_protected_member
    _deliveryTimes.value.clear();
    _deliveryTimes.addAll(delvTimes);
    setDeliveryTime(null);
  }

  Future<void> setDeliveryDate(DateTime? selectedDate) async {
    _selectedDate.value = selectedDate;
    _dateTextController.value.text = formatedDeliveryDate;
    await getNewDeliveryTimes();
  }

  void setDeliveryTime(DeliveryTime? selectedTime) {
    if (selectedTime == null) {
      _selectedTime.value = DeliveryTime(
          id: 0,
          day: '',
          time1: const TimeOfDay(hour: 0, minute: 0),
          time2: const TimeOfDay(hour: 0, minute: 0));
    } else {
      _selectedTime.value = selectedTime;
    }
  }

  String get formatedDeliveryDate =>
      parseDateStrES(deliveryDate?.toIso8601String() ?? "");

  Future<Map<String, dynamic>> createOrder() async {
    if (_selectedTime.value == null || _selectedTime.value?.id == 0) {
      return {
        "message": "Debes seleccionar una franja horaria para continuar",
        "only_title": true
      };
    }
    final userData = Get.find<AuthController>().state!;
    final billerData = Get.find<AppSettingsController>().state!.billerData!;
    final selAddress = Get.find<HomeController>().selectedAddrss!;
    final result = await service.sendCart(
        state!,
        userData,
        billerData,
        selAddress,
        getCartTotals(),
        (_selectedTime.value?.id ?? 0),
        (_selectedDate.value?.toIso8601String() ?? ''),
        _commentTextController.value.text);
    return result;
  }

  double getCartSubtotal() {
    double total = 0;
    for (CartItem item in state!) {
      total += item.price * item.qtty;
    }

    return total;
  }

  Map<String, double> getCartTotals() {
    double productTax = 0;

    double total = 0;

    double totalDiscount = 0;

    double orderDiscount = 0;

    double productDiscount = 0;

    double totalItems = 0;

    for (CartItem item in state!) {
      final product = item.product;
      // future: we need to calculate total = subtotal without discount and grand total
      // which include discounts
      total += item.price * item.qtty;

      totalItems += item.qtty;

      final taxRateM = Get.find<ProductsRelatedController>()
          .getProductTaxRateMethod(product.taxRate);
      if (product.taxMethod == 0) {
        productTax +=
            item.price - (item.price / (1 + (taxRateM?.taxPercentVal ?? 0)));
      } else {
        productTax += item.price * (taxRateM?.taxPercentVal ?? 0);
      }
    }

    return {
      'total': total,
      'total_tax': productTax,
      'grand_total': total,
      'total_discount': totalDiscount,
      "product_discount": productDiscount,
      'product_tax': productTax,
      'total_items': totalItems,
      'order_discount': orderDiscount
    };
  }

  double getCartTotal() {
    double total = 0;

    for (CartItem cartItem in (state!)) {
      total += cartItem.price * cartItem.qtty;
    }
    return total;
  }

  CartItem getCartItemById(String id) {
    return (state!).firstWhere((element) => element.id() == id);
  }

  CartItem getCartItemByIndex(int index) {
    return state![index];
  }

  Future<void> addProductToCart(CartItem item) async {
    // ignore: unnecessary_null_comparison
    // if ((state!) == null) {
    //   DataBloc().setCart([]);
    // }

    if ((state!).isNotEmpty) {
      final items = (state!).where((element) => element.id() == item.id());
      if (items.isEmpty) {
        (state!).add(item);
      } else {
        (state!).firstWhere((element) => element.id() == item.id()).qtty +=
            item.qtty;
      }
    } else {
      (state!).add(item);
    }
    await saveCurrrentCart();
    updateCart();
  }

  modifyProductToCart(String oldItemId, CartItem modifiedItem) {
    // ignore: unnecessary_null_comparison
    // if ((state!) == null) {
    //   DataBloc().setCart([]);
    // }

    if ((state!).isNotEmpty) {
      try {
        final index =
            (state!).indexWhere((element) => element.id() == oldItemId);
        (state!)[index] = modifiedItem;
      } catch (e) {
        log(e);
      }
    } else {
      (state!).add(modifiedItem);
    }
    updateCart();
  }

  removeProduct(String id) {
    try {
      lastDeleted = (state!).firstWhere((element) => element.id() == id);
    } catch (e) {
      log(e);
    }
    (state!).removeWhere((element) => element.id() == id);
    updateCart();
  }

  addQtty(String id, double qtty, {bool override = true}) {
    if (override) {
      (state!).firstWhere((element) => element.id() == id).qtty = qtty;
    } else {
      (state!).firstWhere((element) => element.id() == id).qtty += qtty;
    }
    updateCart();
  }

  rmQtty(String id, double qtty, {bool override = true}) {
    if (override) {
      (state!).firstWhere((element) => element.id() == id).qtty = qtty;
    } else {
      (state!).firstWhere((element) => element.id() == id).qtty -= qtty;
    }
    updateCart();
  }

  Future<void> deleteCurrentCart() async {
    change(null, status: RxStatus.success());
    await service.removeSavedCart();
    updateCart(setNull: true);
  }

  Future<void> saveCurrrentCart() async {
    // change(null, status: RxStatus.success());
    await service.saveCart(cartData: state);
  }

  Future<void> removeSavedCart() async {
    await service.removeSavedCart();
  }
}
