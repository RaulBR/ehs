import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/audit_head_modal.dart';
import 'package:ehsfocus/services/http/audit_socket.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';
part 'audit_socket_event.dart';
part 'audit_socket_state.dart';

class AuditSocketBloc extends Bloc<AuditSocketEvent, AuditSocketState> {
  Socket _webSocket;
  int _reconnectCouter = 0;
  bool _isConnected = false;
  AuditSocketBloc() : super(AuditSocketInitial()) {
    if ((_webSocket != null && !_webSocket.connected) || _webSocket == null) {
      add(ConnectToSocketEvent());
    }
    print('BUILD HERE ');
  }
  AuditSocketService _autitWs = AuditSocketService();

  @override
  Stream<AuditSocketState> mapEventToState(
    AuditSocketEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ConnectToSocketEvent:
        if (_webSocket != null) _webSocket.close();
        _webSocket = await _autitWs.connect();

        _webSocket.on("connect", (_) {
          print('Connected ${_webSocket.id}');
          _reconnectCouter = 0;
          _isConnected = true;
          add(CheckConenctionEvent());
          _webSocket.emit('getAll');
        });
        _webSocket.on("myResponsibillity", (e) {
          notyfychange(e);
        });
        _webSocket.on("auditsFromMyArea", (e) {
          print("auditsFromMyArea $e");
          notyfyDistributionchange(e);
          // notyfychange(e);
        });
        _webSocket.on("myRejectedAspects", (e) {
          notyfyRejectedChange(e);
        });
        _webSocket.on("disconect", (_) {
          _reconnectCouter = _reconnectCouter + 1;
          print('Disconnected ${_webSocket.id}');
          if (_reconnectCouter < 5) {
            print('sockert retry $_reconnectCouter');
            add(ConnectToSocketEvent());
          }
        });
        break;
      case DisconnectFromSocketEvent:
        _reconnectCouter = 5;
        _webSocket = await _autitWs.disconecct();
        print('sockert disconnect ');
        break;
      case AspectAddedEvent:
        if (event is AspectAddedEvent) {
          yield new AuditCountState(auditCount: event.count);
        }

        break;
      case AuditDistributionCountEvent:
        if (event is AuditDistributionCountEvent) {
          yield new AuditDistributionCountState(
              distributeAuditCount: event.count);
        }
        break;
      case AuditRejectedCountEvent:
        if (event is AuditRejectedCountEvent) {
          yield new AuditRejectedCountState(distributeAuditCount: event.count);
        }
        break;
      case CheckConenctionEvent:
        Timer.periodic(new Duration(seconds: 60), (timer) {
          print('ws is: ${_webSocket.connected} => ${_webSocket.id} ');
          if (_webSocket.disconnected && _isConnected == true) {}
        });

        break;
      default:
    }
  }

  getAuditChange() {
    if (_webSocket.connected) {
      // _webSocket.emit('getAll');
      // _webSocket.emit('myResponsibillity');
      // _webSocket.emit('auditsFromMyArea');
      return;
    }
    _isConnected = false;
    connect();
  }

  emitAudit(AuditHead data) {
    if (data == null || data.id == null) {
      return;
    }
    _webSocket.emit('submitAudit', data);
  }

  notyfychange(count) {
    add(AspectAddedEvent(count));
  }

  notyfyDistributionchange(count) {
    add(AuditDistributionCountEvent(count));
  }

  connect() {
    if (!_isConnected) {
      add(ConnectToSocketEvent());
    }
  }

  void notyfyRejectedChange(count) {
    add(AuditRejectedCountEvent(count));
  }

  disconnect() {
    add(DisconnectFromSocketEvent());
  }
}
