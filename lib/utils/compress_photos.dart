import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;
import 'package:image/image.dart' as im;

/// Método para reducir el tamaño de las imágenes
Future<File> compressPhoto(XFile file) async {
  File f = File(file.path);
  return await _compressImage(f);
}

Future<File> _compressImage(File imageFile) async {
  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  int rand = math.Random().nextInt(10000);
  im.Image image = im.decodeImage(
    imageFile.readAsBytesSync(),
  )!;
  var compressedImage = File('$path/img_$rand.jpg')
    ..writeAsBytesSync(im.encodeJpg(image, quality: 25));
  return compressedImage;
}
