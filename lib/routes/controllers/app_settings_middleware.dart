import 'package:customer_app/routes/controllers/app_settings_controller.dart';
import 'package:get/get.dart';

/// Middleware para los tipos de checklist
class AppSettingsMiddleware extends GetMiddleware {
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    Get.find<AppSettingsController>().getAppSettings();
    return page;
  }
}
