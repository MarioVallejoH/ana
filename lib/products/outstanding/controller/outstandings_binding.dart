import 'package:customer_app/products/outstanding/controller/outstandings_controller.dart';
import 'package:customer_app/products/outstanding/service/outstandings_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class OutstandingBinding implements Bindings {
  @override
  void dependencies() {
    final OutstandingsService service = OutstandingsService();
    Get.put<OutstandingsController>(
      OutstandingsController(service: service),
    );
  }
}
