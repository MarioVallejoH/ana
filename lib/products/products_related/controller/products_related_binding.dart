import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/products/products_related/controller/products_related_controller.dart';
import 'package:customer_app/products/products_related/service/products_related_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class ProductsRelatedBinding implements Bindings {
  @override
  void dependencies() {
    final ProductsService service = ProductsService();
    Get.put<ProductsRelatedController>(
      ProductsRelatedController(service: service, user: Get.find<AuthController>().state!),
    );
  }
}
