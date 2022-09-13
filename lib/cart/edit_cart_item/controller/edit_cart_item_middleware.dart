import 'package:customer_app/cart/edit_cart_item/controller/edit_cart_item_controller.dart';

import 'package:get/get.dart';

/// Middleware para los tipos de checklist
class EditCartItemMiddleware extends GetMiddleware {
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    Get.find<EditCartItemController>().loadData();
    return page;
  }
}
