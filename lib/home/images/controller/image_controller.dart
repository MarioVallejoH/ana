import 'package:customer_app/home/images/images.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// Controlador para las preguntas del checklist
class ImageController extends GetxController {
  /// Constructor
  ImageController();

  final RxBool _showAddCommentImage = false.obs;

  /// Métodos get y set para el condicional que muestra la caja de texto para añadir un comentario a la imagen
  bool get showAddCommentImage => _showAddCommentImage.value;
  set showAddCommentImage(bool value) => _showAddCommentImage.value = value;

  final Rx<XFile?> _photo = XFile('').obs;

  XFile? get photo => _photo.value;

  set photo(XFile? photo) {
    _photo.value = photo;
  }

  Future<String> imageB64() async {
    final photoData = await loadPhotos();

    return photoData['image_base64'];
  }
}
