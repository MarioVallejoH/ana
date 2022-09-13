
import 'package:customer_app/explore/controllers/explore_controller.dart';
import 'package:customer_app/explore/services/explore_service.dart';

import 'package:get/get.dart';

/// Binding para inicializar controlador de los tipos de checklist
class ExploreBinding implements Bindings {
  @override
  void dependencies() {
    final ExploreService service = ExploreService();
    Get.put<ExploreController>(
      ExploreController(service: service),
    );
  }
}
