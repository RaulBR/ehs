import 'package:ehsfocus/services/http/audit_socket.dart';
import 'package:socket_io_client/socket_io_client.dart';

class WebSocetService {
  Socket _webSocket;
  AuditSocketService _autitWs = AuditSocketService();

  initSocket() async {
    _webSocket = await _autitWs.connect();
  }

  disconenctSocket() async {
    _webSocket = await _autitWs.disconecct();
  }

  getWevSocet() {
    return _webSocket;
  }
}
