import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/products/products.dart';

class ExploreService {
  Future<List<ProductModel>> getAll(
      {int page = 0, String? query, List<int>? categoriesFilter}) async {
    final body = {
      "page": page,
      "text": query,
      "limit": 15,
      "categories": categoriesFilter
    };

    final apiData = await DataProvider.postPetition(productSearchEndP, body);

    if (apiData['success'] ?? false) {
      final productList = ProductModel.fromJsonList(apiData['data']);

      return productList;
    } else {
      return [];
    }
  }
}
