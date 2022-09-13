import 'package:customer_app/register/controller/register_controller.dart';
import 'package:customer_app/register/services/register_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    final RegisterService service = RegisterService();
    Get.put<RegisterController>(
      RegisterController(service: service),
    );
  }
}
