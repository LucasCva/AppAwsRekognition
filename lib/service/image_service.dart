import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:aws_rekognition/models/image_response.dart';

class ImageService {
  static Future<ImageResponse> enviarImagem(File image) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("https://rekognition-app-production.up.railway.app/api/image"),
    );
    request.files.add(await http.MultipartFile.fromPath("file", image.path));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print(response.statusCode);
      final data = jsonDecode(responseBody);

      return ImageResponse.fromJson(data);
    } else {
      throw Exception("Erro ao enviar a imagem ${response.statusCode}");
    }
  }

  static Future<List<String>> fecthImagesUrl() async {
    final response = await http.get(
      Uri.parse("https://rekognition-app-production.up.railway.app/api/image"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data.toString());
      return List<String>.from(data["imagesUrl"]);
    } else {
      throw Exception('Erro ao carregar URLs das imagens');
    }
  }
}
