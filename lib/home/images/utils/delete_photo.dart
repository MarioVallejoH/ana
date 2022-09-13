import 'package:customer_app/home/images/images.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// Método para eliminar fotografías del checklist
Future<void> deletePhoto(
  int index,
) async {
  await Future.delayed(const Duration(milliseconds: 300));
   Get.find<ImageController>().photo = XFile('');
}
