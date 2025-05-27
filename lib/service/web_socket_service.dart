import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketService {
  late StompClient _stompClient;

  void connect(Function(String) onUpdates) {
    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'http://192.168.1.8:8080/ws',
        onConnect: (StompFrame frame) {
          print("🟢 Conectado ao servidor");
          _stompClient.subscribe(
            destination: '/topic/images',
            callback: (frame) {
              if (frame.body != null) {
                print("Body: ${frame.body}");
                onUpdates(frame.body!);
              }
            },
          );
        },
        onWebSocketError: (dynamic error) => print("Erro: $error"),
      ),
    );

    _stompClient.activate();
  }

  void disconnect() {
    _stompClient.deactivate();
  }
}
