import 'package:customer_app/auth/controller/auth_controller.dart';
import 'package:customer_app/favorites/controllers/favorites_controller.dart';
import 'package:get/get.dart';

/// Middleware para root
class FavoritesMiddleware extends GetMiddleware {
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    Get.find<FavoritesController>()
        .loadData(Get.find<AuthController>().state?.id);
    return page;
  }
}
