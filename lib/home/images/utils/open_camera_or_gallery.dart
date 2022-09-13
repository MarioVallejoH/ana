import 'package:customer_app/home/images/utils/add_photo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Método para abrir la cámara o la galería del dispositivo
Future<void> openCameraOrGallery(BuildContext context, bool isCamera) async {
  final ImagePicker picker = ImagePicker();
  final XFile? photo;
  if (isCamera) {
    photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
      maxHeight: 800,
      maxWidth: 800,
    );
  } else {
    photo = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
      maxHeight: 800,
      maxWidth: 800,
    );
  }
  setPhoto(photo);
  return;
}
