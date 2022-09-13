import 'package:customer_app/endpoints_dir.dart';
import 'package:customer_app/providers/data_provider.dart';
import 'package:customer_app/products/products.dart';

class FavoritesService {
  Future<List<ProductModel>> getFavorites(
      {int page = 0,
      String? query,
      List<int>? categoriesFilter,
      int? userId}) async {
    final body = {
      "page": page,
      "text": query,
      "limit": 100,
      "favorites": true,
      "user_id": userId,
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

  Future<bool> addFavorite(int? productId, int? userId) async {
    final ordersData = await DataProvider.postPetition(
        addWishList, {"product_id": productId, 'user_id': userId});

    if (ordersData['success'] ?? false) {
      return true;
    }
    return false;
  }

  Future<bool> removeFavorite(int? productId, int? userId) async {
    final ordersData = await DataProvider.postPetition(
        removeWishList, {"product_id": productId, 'user_id': userId});

    if (ordersData['success'] ?? false) {
      return true;
    }
    return false;
  }
}
