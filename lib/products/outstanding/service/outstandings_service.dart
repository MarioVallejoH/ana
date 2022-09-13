import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/products/models/product_model.dart';

class OutstandingsService{


  Future<List<ProductModel>> getOutstanding(
      {int page = 0, List<int>? categoriesFilter}) async {
    final body = {
      "page": page,
      "limit": 10,
      "outstanding": true,
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