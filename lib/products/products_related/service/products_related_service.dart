import 'package:customer_app/endpoints_dir.dart';

import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/products/products.dart';

class ProductsService {
  

  Future<List<UnitsModel>> loadProductUnits(int? customer_group) async {
    final apiData = await DataProvider.postPetition(unitsEndP, {'customer_group':customer_group});

    if (apiData['success'] ?? false) {
      final units = UnitsModel.fromJsonList(apiData['data']);

      return units;
    } else {
      return [];
    }
  }

  Future<List<TaxRateModel>> getTaxRates() async {
    final apiData = await DataProvider.getPetition(taxRatesEndP);

    if (apiData['success'] ?? false) {
      final taxRates = TaxRateModel.fromJsonList(apiData['data']);

      return taxRates;
    } else {
      return [];
    }
  }

  Future<List<UnitPrice>> findProductUnitPrices(int productId) async {
    final body = {"product_id": productId};

    final apiData = await DataProvider.postPetition(unitsPricesEndP, body);

    if (apiData['success'] ?? false) {
      final unitPrice = UnitPrice.fromJsonList(apiData['data']);

      return unitPrice;
    } else {
      return [];
    }
  }

  Future<List<ProductCategoryModel>> getCategories() async {
    final apiData = await DataProvider.getPetition(categoriesEndP);

    if (apiData['success'] ?? false) {
      final categories = ProductCategoryModel.fromJsonList(apiData['data']);

      return categories;
    } else {
      return [];
    }
  }

  Future<List<PreferencesCategories>> getPreferencesCategories() async {
    final apiData = await DataProvider.getPetition(prefCatEndP);

    if (apiData['success'] ?? false) {
      final pCategories = PreferencesCategories.fromJsonList(apiData['data']);

      return pCategories;
    } else {
      return [];
    }
  }
  Future<List<ProductPreference>> getPreferences() async {
    final apiData = await DataProvider.getPetition(prefEndP);

    if (apiData['success'] ?? false) {
      final preferences = ProductPreference.fromJsonList(apiData['data']);

      return preferences;
    } else {
      return [];
    }
  }
}
