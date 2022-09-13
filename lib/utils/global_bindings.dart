import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/auth/services/auth_service.dart';
import 'package:customer_app/routes/controllers/app_settings_controller.dart';
import 'package:customer_app/routes/services/app_settings_service.dart';
import 'package:customer_app/utils/conectivity_controller.dart';
import 'package:get/get.dart';

/// Inicializa los controladores de manera global
class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    final AppSettingsService service = AppSettingsService();
    Get.put<AppSettingsController>(
      AppSettingsController(service: service),
    );

    Get.put<ConnectivityController>(
      ConnectivityController(),
    );
  }
}
