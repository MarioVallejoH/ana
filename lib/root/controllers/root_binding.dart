
import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:customer_app/root/services/rooot_page_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class RootBinding implements Bindings {
  @override
  void dependencies() {
    final RootPageService serviceRoot = RootPageService();
    Get.put<RootController>(
      RootController(service: serviceRoot),
    );

    
  }
}
