import 'package:get/get.dart';

import 'image_controller.dart';

/// Binding para inicializar controlador de las imágenes
class ImageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ImageController>(ImageController());
  }
}
