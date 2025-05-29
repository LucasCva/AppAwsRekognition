import 'package:get/get.dart';
import 'package:aws_rekognition/service/web_socket_service.dart';
import 'package:aws_rekognition/service/image_service.dart';

class HomePageController extends GetxController {
  RxList<String> imagesUrl = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    final webSocketService = WebSocketService();
    webSocketService.connect((newImageUrl) {
      imagesUrl.insert(0, newImageUrl);
      print("Imagem adicionada ao array");
    });

    loadInitialImages();
  }

  Future<void> loadInitialImages() async {
    try {
      final initialImages = await ImageService.fecthImagesUrl();
      imagesUrl.addAll(initialImages.reversed);
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possível carregar as imagens iniciais: $e');
    }
  }

  Future<void> refreshImages() async {
    imagesUrl.clear();
    await loadInitialImages();
  }
}
