import 'package:ehsfocus/models/action_model.dart';
import 'package:ehsfocus/models/area_model.dart';
import 'package:ehsfocus/services/http/http_audit.dart';
import 'package:ehsfocus/state/audit_bloc/audit_bloc_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuditBloc extends Bloc<AuditEvent, AuditState> {
  Audit _audit = Audit();
  @override
  AuditState get initialState => AuditStateInitial.initial();
  final mockHttp = HttpAuditService();
  @override
  Stream<AuditState> mapEventToState(AuditEvent event) async* {
    switch (event.runtimeType) {
      case SetAudit:
        yield AuditLoading();
        mockHttp.setAudit(_audit);
        // Future.delayed(const Duration(milliseconds: 3000), () async* {
        yield AuditDataState(_audit);
        // });

        break;

      case GetMyAudit:
        yield AuditLoading();
        Future.delayed(const Duration(milliseconds: 500), () async* {
          yield AuditDataState(mockHttp.getAudit());
        });

        break;
      case DeleteAudit:
        break;
      default:
        yield AuditDataState(null);
    }
  }

  void getAudit() {
    add(GetMyAudit());
  }

  void setAudit(Audit audit) {
    if (audit == null) {
      return;
    }
    add(SetAudit(audit: audit));
  }

  void deleteAuidit(Audit audit) {
    if (audit == null || audit.area == null) {
      return;
    }

    add(DeleteAudit(id: audit.area.id));
  }

  void setArea(Area area) {
    if (area == null) {
      return;
    }
    _audit.area = area;

    add(SetAudit(audit: _audit));
  }
}
