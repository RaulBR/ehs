import 'package:ehsfocus/models/action_model.dart';
import 'package:ehsfocus/models/audit_head_modal.dart';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/forms/audit/audit_bloc/audit_event.dart';
import 'package:ehsfocus/screens/forms/audit/audit_bloc/audit_state.dart';
import 'package:ehsfocus/services/http/http_audit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuditBloc extends Bloc<AuditEvent, AuditState> {
  Audit _audit = Audit();
  AuditBloc() : super(null);

  final httpAuditService = HttpAuditService();
  @override
  Stream<AuditState> mapEventToState(AuditEvent event) async* {
    yield AuditLoading();
    switch (event.runtimeType) {
      case UpdateForm:
        yield AuditDataState(event.audit);
        break;

      case SetAuditAspect:
        dynamic data = await httpAuditService.setAspect(event.auditRequest);
        if (data == null) {
          yield Error();
          break;
        }
        // move to service
        _audit.auditHead = data.auditHead;
        if (data.aspect.type == 'N') {
          _audit.negativeAspects = _audit.negativeAspects ?? [];
          _audit.negativeAspects.add(data.aspect);
        } else {
          _audit.positiveAspects = _audit.positiveAspects ?? [];
          _audit.positiveAspects.add(data.aspect);
        }
        //
        yield AuditDataState(_audit);
        break;

      case SetAudit:
        try {
          httpAuditService.setAudit(_audit.auditHead);
        } catch (e) {
          yield Error();
          break;
        }
        yield AuditDataState(_audit);
        break;

      case GetMyAudit:
        yield AuditLoading();
        dynamic a = await httpAuditService.getAudit();
        if (a.length == 0) {
          yield AuditDataState(_audit);
          break;
        }
        _audit = a[0];
        yield AuditDataState(a[0]);
        break;
      case GetAuditResponsible:
        print(event.aspect);
        yield AutidResponsable(['Claudiu David', 'Danutz vasilica']);
        break;
      case DeleteAudit:
        dynamic a = await httpAuditService.deleteAudit(event.id);
        if (a == 'success') {
          yield DeleteSucsesfull();
          _audit.auditHead = null;
          _audit.negativeAspects = [];
          _audit.positiveAspects = [];

          yield AuditDataState(_audit);
          // yield AuditDataState(_audit);
          break;
        }
        break;
      default:
        yield AuditDataState(null);
    }
  }

  void getAudit() {
    add(GetMyAudit());
  }

  void setAudit() {
    add(SetAudit());
  }

  void deleteAuidit(String id) {
    if (id == null) {
      return;
    }

    add(DeleteAudit(id: id));
  }

  void setArea(AuditHead area) {
    if (area == null) {
      return;
    }
    _audit.auditHead = area;

    add(UpdateForm(audit: _audit));
  }

  void getEmployees(Aspect aspect) {
    if (aspect == null) {
      return;
    }
    add(GetAuditResponsible(aspect: aspect));
  }

  void setAspect(Aspect aspect) {
    if (aspect == null) {
      return;
    }
    AuditRequest audit = AuditRequest();
    audit.auditHead = _audit.auditHead ?? AuditHead();
    audit.aspect = aspect;
    add(SetAuditAspect(auditRequest: audit));
  }
}
