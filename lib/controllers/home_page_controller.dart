import 'package:get/get.dart';
import 'package:rekognition_app/service/web_socket_service.dart';

class HomePageController extends GetxController {
  RxList<String> imagesUrl = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    final webSocketService = WebSocketService();

    webSocketService.connect((newImageUrl) {
      imagesUrl.add(newImageUrl);
      print("Imagem adicionada ao array");
    });
  }
}
