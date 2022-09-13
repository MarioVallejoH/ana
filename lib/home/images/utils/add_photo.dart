import 'package:customer_app/home/images/images.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// Método para agregar fotografías al checklist
void setPhoto(
  XFile? file,
) {
  if (file != null) {
    Get.find<ImageController>().photo = file;
  }
}
