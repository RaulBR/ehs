import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/audit_head_modal.dart';
import 'package:ehsfocus/services/http/audit_socket.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';
part 'audit_socket_event.dart';
part 'audit_socket_state.dart';

class AuditSocketBloc extends Bloc<AuditSocketEvent, AuditSocketState> {
  Socket ws;
  AuditSocketBloc() : super(AuditSocketInitial()) {
    if ((ws != null && !ws.connected) || ws == null) {
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
        ws = await _autitWs.connect();
        ws.on("connect", (_) {
          print('Connected ${ws.id}');
          ws.emit('myResponsibillity');
          ws.emit('auditsFromMyArea');
        });
        ws.on("myResponsibillity", (e) {
          notyfychange(e);
        });
        ws.on("auditsFromMyArea", (e) {
          print("auditsFromMyArea $e");
          notyfyDistributionchange(e);
          // notyfychange(e);
        });
        break;
      case DisconnectFromSocketEvent:
        break;
      case AspectAddedEvent:
        if (event is AspectAddedEvent) {
          yield new AuditCountState(auditCount: event.count);
        }

        break;
      case AuditDistributionCountEvent:
        if (event is AuditDistributionCountEvent) {
          yield new AuditDistributionCountState(count: event.count);
        }

        break;
      default:
    }
  }

  emitAudit(AuditHead data) {
    if (data == null || data.id == null) {
      return;
    }
    ws.emit('submitAudit', data);
  }

  // getCount() {
  //   return _conut;
  // }

  notyfychange(count) {
    add(AspectAddedEvent(count));
  }

  notyfyDistributionchange(count) {
    add(AuditDistributionCountEvent(count));
  }
}
