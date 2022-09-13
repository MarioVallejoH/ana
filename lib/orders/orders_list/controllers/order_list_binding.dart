import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/orders/orders_list/controllers/orders_list_controller.dart';
import 'package:customer_app/orders/orders_list/services/orders_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class OrdersListBinding implements Bindings {
  @override
  void dependencies() {
    final OrdersService service = OrdersService();
    Get.put<OrdersListController>(
      OrdersListController(
        service: service,
        company: Get.find<AuthController>().state?.companyData,
      ),
    );
  }
}
