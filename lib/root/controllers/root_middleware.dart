// import 'package:customer_app/root/controllers/root_controller.dart';
import 'package:get/get.dart';

/// Middleware para root
class RootMiddleware extends GetMiddleware {
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    // Get.find<RootController>().loadData();
    return page;
  }
}
