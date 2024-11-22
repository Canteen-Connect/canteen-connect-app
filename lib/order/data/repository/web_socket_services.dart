import 'package:foodies/core/secrets/constants/constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  Function(Map<String, dynamic>)? onInitiatePayment;
  void connect(String userId) {
    socket = IO.io(SOCKET_URL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
    socket.emit('user_connected', userId);

    socket.onConnect((_) {
      print('Connected to WebSocket');
      print('Socket ID: ${socket.id}');
    });

    socket.onDisconnect((_) {
      print('Disconnected from WebSocket');
    });

    socket.on('initiate_payment', (data) {
      print('Initiate Payment Event Received: $data');
      if (onInitiatePayment != null) {
        onInitiatePayment!(data);
      }
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
