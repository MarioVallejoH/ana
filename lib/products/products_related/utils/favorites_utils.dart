import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/favorites/services/favorites_service.dart';
import 'package:get/get.dart';

Future<bool> addProductToFav(int? productId) async {
  int? userId = Get.find<AuthController>().state?.id;
  return await FavoritesService().addFavorite(productId, userId);
}

Future<bool> removeProductToFav(int? productId) async {
  int? userId = Get.find<AuthController>().state?.id;
  return await FavoritesService().removeFavorite(productId, userId);
}
