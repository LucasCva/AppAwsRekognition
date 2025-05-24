import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageController {
  // Pegar imagem da galeria
  static Future<File?> pegarImagemDaGaleria() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
