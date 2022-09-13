

import 'package:customer_app/favorites/controllers/favorites_controller.dart';
import 'package:customer_app/favorites/services/favorites_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class FavoritesBinding implements Bindings {
  @override
  void dependencies() {
    final FavoritesService service = FavoritesService();
    Get.put<FavoritesController>(
      FavoritesController(service: service),
    );
  }
}
