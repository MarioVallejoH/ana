import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/user/controllers/user_controller.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class UserBinding implements Bindings {
  @override
  void dependencies() {
    final userData = Get.find<AuthController>().state;
    Get.put<UserController>(
      UserController(userData: userData),
    );
  }
}
