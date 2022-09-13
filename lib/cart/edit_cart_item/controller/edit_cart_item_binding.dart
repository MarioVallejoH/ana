import 'package:customer_app/cart/cart/controllers/cart_controller.dart';
import 'package:customer_app/cart/edit_cart_item/controller/edit_cart_item_controller.dart';
import 'package:customer_app/cart/edit_cart_item/service/edit_cart_item_service.dart';
import 'package:customer_app/products/product_details/services/products_data_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class EditCartItemBinding implements Bindings {
  @override
  void dependencies() {
    final EditCartItemService service = EditCartItemService();
    final ProductsDataService pService = ProductsDataService();
    Get.put<EditCartItemController>(
      EditCartItemController(
          service: service,
          productsService: pService,
          cartItemSelected: Get.find<CartController>().selectedCartItem!.obs),
    );
  }
}
