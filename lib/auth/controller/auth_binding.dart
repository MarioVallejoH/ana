import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/auth/services/auth_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class AuthBinding implements Bindings {
  @override
  void dependencies() {
    final AuthService service = AuthService();
    Get.put<AuthController>(
      AuthController(service: service),
    );
  }
}
