import 'package:customer_app/products/product_details/controller/product_details_controller.dart';
import 'package:customer_app/products/product_details/services/product_details_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class ProductDetailsBinding implements Bindings {
  @override
  void dependencies() {
    final ProductDetailService service = ProductDetailService();
    Get.put<ProductDetailsController>(
      ProductDetailsController(service: service),
    );
  }
}
