import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/auth/models/user_data_model.dart';
import 'package:customer_app/cart/edit_cart_item/service/edit_cart_item_service.dart';
import 'package:customer_app/cart/models/cart_item_model.dart';
import 'package:customer_app/products/product_details/services/products_data_service.dart';
import 'package:customer_app/products/products.dart';
import 'package:customer_app/products/products_related/controller/products_related_controller.dart';
import 'package:get/get.dart';

class EditCartItemController extends GetxController with StateMixin<int> {
  EditCartItemController(
      {required this.service,
      required this.cartItemSelected,
      required this.productsService}) {
    change(null, status: RxStatus.loading());
  }

  final UserDataModel user =Get.find<AuthController>().state!;


  Future<void> loadData() async {
    change(0, status: RxStatus.loading());
    _preferences.value = cartItem.preferences ?? {};
    _unitSelected.value = cartItem.unitsModel;
    _price.value = cartItem.price;
    _quantity.value = cartItem.qtty;
    final data = await Future.wait([
      productsService.findProductPreferences(cartItem.product.id),
      productsService.findProductUnitPrices(cartItem.product.id, user.companyData?.customerGroupId, unitId: 0),
    ]);
    productPreferences.addAll(data[0] as Map<int, List<ProductPreference>>);
    unitPrices.addAll(data[1] as List<UnitPrice>);
    taxRateMethod = Get.find<ProductsRelatedController>()
        .getProductTaxRateMethod(cartItem.product.taxRate);
    change(1, status: RxStatus.success());
  }

  final EditCartItemService service;

  final ProductsDataService productsService;

  final Rx<CartItem> cartItemSelected;

  final List<UnitPrice> unitPrices = List<UnitPrice>.empty(growable: true);

  Map<int, List<ProductPreference>> productPreferences = {};

  final RxMap<PreferencesCategories, List<ProductPreference>> _preferences =
      <PreferencesCategories, List<ProductPreference>>{}.obs;

  final RxDouble _price = 0.0.obs;

  final RxDouble _quantity = 0.0.obs;

  TaxRateModel? taxRateMethod;

  final Rx<UnitsModel?> _unitSelected =
      UnitsModel(id: 0, code: '', name: '', unitValue: 0.0).obs;

  CartItem get cartItem => cartItemSelected.value;

  // set cartItem(CartItem cartItem) => cartItemSelected.value = cartItem;

  UnitsModel? get selectedUnit => _unitSelected.value;

  set selectedUnit(UnitsModel? unit) {
    _unitSelected.value = unit;
    cartItemSelected.value.unitsModel = unit;
    cartItemSelected.value = cartItemSelected.value;
  }

  double get price => _price.value;

  set price(double value) {
    _price.value = value;
    cartItemSelected.value.price = value;
  }

  double get quantity => _quantity.value;

  set quantity(double value) {
    _quantity.value = value;
    cartItemSelected.value.qtty = value;
  }

  void addPreference(
      PreferencesCategories prefCat, ProductPreference preference) {
    if (_preferences[prefCat]?.isEmpty ?? true) {
      _preferences[prefCat] = [];
    }
    _preferences[prefCat]!.add(preference);
  }

  void removePreference(
      PreferencesCategories prefCat, ProductPreference preference) {
    if (_preferences[prefCat]?.isNotEmpty ?? false) {
      _preferences[prefCat]!
          .removeWhere((element) => element.id == preference.id);
    }
  }

  void removePreferenceByIndex(PreferencesCategories prefCat, int index) {
    if (_preferences[prefCat]?.isNotEmpty ?? false) {
      _preferences[prefCat]!.removeAt(index);
    }
  }

  Map<PreferencesCategories, List<ProductPreference>> get preferences =>
      _preferences;
}
