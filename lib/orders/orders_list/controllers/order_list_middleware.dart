import 'package:customer_app/orders/orders_list/controllers/orders_list_controller.dart';
import 'package:get/get.dart';

/// Middleware para root
class OrdersListMiddleware extends GetMiddleware {
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    Get.find<OrdersListController>().loadData();
    return page;
  }
}
