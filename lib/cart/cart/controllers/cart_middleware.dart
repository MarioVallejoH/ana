import 'package:customer_app/cart/cart/controllers/cart_controller.dart';

import 'package:get/get.dart';

/// Middleware para los tipos de checklist
class CartMiddleware extends GetMiddleware {
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    Get.find<CartController>().loadData();
    return page;
  }
}
