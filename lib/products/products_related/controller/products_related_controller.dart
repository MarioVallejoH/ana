import 'package:customer_app/auth/models/user_data_model.dart';
import 'package:customer_app/products/products.dart';
import 'package:customer_app/products/products_related/service/products_related_service.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductsRelatedController extends GetxController with StateMixin<int> {
  ProductsRelatedController({required this.service, required this.user}) {
    change(null, status: RxStatus.loading());
  }

  final ProductsService service;

  final UserDataModel user;

  Future<void> loadData() async {
    // state.value = cartItems;
    change(null, status: RxStatus.loading());
    final categories = await service.getCategories();
    pCategories.addAll(categories);
    change(1, status: RxStatus.success());
    await Future.delayed(const Duration(seconds: 1));
    
    final taxRts = await service.getTaxRates();
    final productUnits = await service.loadProductUnits(
      user.companyData?.customerGroupId,
    );
    await Future.delayed(const Duration(seconds: 1));
    final prefsCategories = await service.getPreferencesCategories();
    await Future.delayed(const Duration(seconds: 1));
    final prefs = await service.getPreferences();

    taxRates.addAll(taxRts);
    productsUnits.addAll(productUnits);
    preferencesCategories.addAll(prefsCategories);
    preferences.addAll(prefs);

    
  }

  RxList<TaxRateModel> taxRates = List<TaxRateModel>.empty(growable: true).obs;

  RxList<ProductCategoryModel> pCategories =
      List<ProductCategoryModel>.empty(growable: true).obs;

  RxList<UnitsModel> productsUnits = List<UnitsModel>.empty(growable: true).obs;

  RxList<PreferencesCategories> preferencesCategories =
      List<PreferencesCategories>.empty(growable: true).obs;
  RxList<ProductPreference> preferences =
      List<ProductPreference>.empty(growable: true).obs;

  TaxRateModel? getProductTaxRateMethod(int? taxRateId) {
    // if (dataBloc.taxRates == null || (dataBloc.taxRates?.isEmpty ?? false)) {

    // dataBloc.setTaxRates(taxRates);
    // }
    try {
      final productTaxRateM =
          taxRates.where((element) => element.id == taxRateId).first;
      return productTaxRateM;
    } catch (e) {
      log(e);
    }
    return null;
  }

  UnitsModel? getUnit(int unitId) {
    try {
      return productsUnits.firstWhere((element) => element.id == unitId);
    } catch (e) {
      return null;
    }
  }

  PreferencesCategories? getPrefCategory(int prefCatId) {
    return preferencesCategories
        .firstWhere((element) => element.id == prefCatId);
  }
  ProductPreference? getProdPref(int pref) {
    return preferences
        .firstWhere((element) => element.id == pref);
  }

  ProductCategoryModel? getProductCategory(int catId) {
    try {
      return pCategories.firstWhere((element) => element.id == catId);
    } catch (e) {
      return null;
    }
  }
}
