import 'package:customer_app/products/products_related/controller/products_related_controller.dart';

import 'package:get/get.dart';

/// Middleware para los datos relacionados a los productos
class ProductsRelatedMiddleware extends GetMiddleware {
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    Get.find<ProductsRelatedController>().loadData();
    return page;
  }
}