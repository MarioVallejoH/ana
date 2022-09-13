import 'package:customer_app/home/controllers/home_controller.dart';
import 'package:customer_app/home/services/home_data_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    final HomeDataService
     service = HomeDataService();
    Get.put<HomeController>(
      HomeController(service: service),
    );
  }
}
