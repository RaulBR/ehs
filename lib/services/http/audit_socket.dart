import 'package:ehsfocus/services/http/http.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AuditSocketService extends HttpService {
  IO.Socket socket;
  connect() async {
    if (socket == null || socket.disconnected) {
      String _token = await localstorageService.getToken();
      String email = await localstorageService.getEmail();
      if (_token == null) {
        return;
      }
      socket = IO.io('$url/ws', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'extraHeaders': {"authorization": "Bearer $_token", "user": "$email"}
      });
    }
    return socket;
  }

  disconecct() {
    if (socket != null) if (socket.connected) {
      socket.disconnect();
    }
  }

  listen() {
    return socket;
  }
}
