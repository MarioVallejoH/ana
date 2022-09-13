import 'dart:convert';

import 'package:customer_app/home/images/images.dart';
import 'package:customer_app/utils/compress_photos.dart';
import 'package:get/get.dart';

/// Método para reducir el tamaño de las imágenes y definir el nombre y los comentarios en la imagen
Future<Map<String, dynamic>> loadPhotos() async {
  Map<String, dynamic> photoData;

  final photoCompress = await compressPhoto(
    Get.find<ImageController>().photo!,
  );
  final bytes = photoCompress.readAsBytesSync();
  String base64Image = base64Encode(bytes);
  photoData = {
    'image_name': photoCompress.path.split('/').last,
    'image_base64': base64Image,
  };

  return photoData;
}
