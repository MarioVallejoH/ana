import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/cart/cart/services/cart_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class CartBinding implements Bindings {
  @override
  void dependencies() {
    final CartService service = CartService();
    Get.put<CartController>(
      CartController(service: service),
    );
  }
}
