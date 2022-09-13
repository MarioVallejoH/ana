import 'package:customer_app/endpoints_dir.dart';

import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/products/products.dart';

class ProductDetailService {
  Future<Map<int, List<ProductPreference>>> getProductPreferences(
      int productId) async {
    final body = {"product_id": productId};

    final apiData = await DataProvider.postPetition(prodPrefEndP, body);

    if (apiData['success'] ?? false) {
      final prodPrefs = ProductPreference.fromJsonList(apiData['data']);
      Map<int, List<ProductPreference>> prefs = {};
      for (ProductPreference pP in prodPrefs) {
        if (prefs.containsKey(pP.preferenceCategoryId)) {
          prefs[pP.preferenceCategoryId]?.add(pP);
        } else {
          prefs[pP.preferenceCategoryId!] = [pP];
        }
      }
      return prefs;
    } else {
      return {};
    }
  }
}
