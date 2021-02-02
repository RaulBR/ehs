import 'dart:async';
import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/action/audit_model.dart';
import 'package:ehsfocus/models/action/audit_request_model.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/bloc/audit_bloc/audit_event.dart';
import 'package:ehsfocus/bloc/audit_bloc/audit_state.dart';
import 'package:ehsfocus/services/http/http_audit.dart';
import 'package:ehsfocus/services/repository/audit_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuditBloc extends Bloc<AuditEvent, AuditState> {
  Audit _audit = Audit();
  List<Audit> _audits = [];
  AuditBloc() : super(null);

  final httpAuditService = HttpAuditService();
  final _auditRepo = AuditRepo();
  @override
  Stream<AuditState> mapEventToState(AuditEvent event) async* {
    yield AuditLoading();
    switch (event.runtimeType) {
      case UpdateForm:
        yield AuditDataState(event.audit);
        break;

      case SetAuditAspect:
        try {
          AuditRequest a = AuditRequest();
          a.auditHead = _audit.auditHead;
          a.aspect = event.auditRequest.aspect;
          a.aspect.audit = _audit.auditHead;
          a.aspect.status = 'S';
          _auditRepo.setAspect2(a.aspect);
          add(GetMyAudit());
          yield AspectAddedState(aspect: a.aspect);
          add(GetAuditAspectsEvent(type: a.aspect.type));
        } catch (e) {
          yield Error(error: e);
        }
        break;
      case GetAuditsToApprove:
        try {
          List<Aspect> audits = await httpAuditService.getAuditsToApprove();
          yield AuditsToApproveState(audits);
          break;
        } catch (e) {
          yield Error();
          break;
        }
        break;
      case SetAuditHead:
        await _auditRepo.setAuditHead(_audit.auditHead);
        break;
      case SetAudit:
        try {
          _audit = await _auditRepo.setAudit(_audit);
        } catch (e) {
          yield Error();
          break;
        }
        yield AuditDataState(_audit);
        break;
      case SubmitAudit:
        try {
          await httpAuditService.submitAudit(_audit.auditHead);
          Timer(Duration(seconds: 1), () => add(UpdateForm(audit: Audit())));
        } catch (e) {
          yield Error();
          break;
        }
        yield AuditDataState(_audit);
        break;
      case GetMyAudit:
        try {
          Audit a = await _auditRepo.getAudit();
          if (a == null) {
            _clearAudit();
          } else {
            _audit = a;
          }
          yield AuditDataState(_audit);
        } catch (e) {
          yield AuditDataState(_audit);
        }

        break;
      case GetMyAuditsEvent:
        try {
          List<Audit> a = await httpAuditService.getMyAudit();
          _audits = a;
          yield AuditsDataState(areaList: a);
        } catch (e) {
          yield AuditsDataState(areaList: []);
        }

        break;
      case GetAuditAspectsEvent:
        if (event is GetAuditAspectsEvent) {
          _audit = await _auditRepo.getAudit();
          if (event.type == 'N') {
            yield AduitAspectsState(aspects: _audit.negativeAspects);
          }
          if (event.type == 'P') {
            yield AduitAspectsState(aspects: _audit.positiveAspects);
          }
        }
        break;
      case DeleteAudit:
        _auditRepo.deleteFromLovalDb();
        yield DeleteSucsesfull();
        _clearAudit();
        yield AuditDataState(_audit);
        dynamic a = await _auditRepo.deleteAudit(event.id);
        if (a == 'success') {
          yield DeleteSucsesfull();
          _clearAudit();
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

  void setAuditHead() {
    add(SetAuditHead());
  }

  void deleteAuidit(String id) {
    add(DeleteAudit(id: id));
  }

  void setArea(AuditHead area) {
    if (area == null) {
      return;
    }
    _audit.auditHead = area;

    add(UpdateForm(audit: _audit));
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

  List<Aspect> _handleAspectElement(List<Aspect> list, aspect) {
    list = list ?? [];
    Aspect element;
    element = aspect;
    if (list.length > 0) {
      element = list.firstWhere((element) => element.id == aspect.id,
          orElse: () => null);
      if (element != null) {
        element = aspect;
        return list;
      }
    }
    list.add(aspect);
    return list;
  }

  void submitAudit() {
    add(SubmitAudit());
  }

  void getAuditsToApprove() {
    add(GetAuditsToApprove());
  }

  void _clearAudit() {
    _audit.auditHead = null;
    _audit.negativeAspects = [];
    _audit.positiveAspects = [];
  }

  void getAudits() {
    add(GetMyAuditsEvent());
  }

  void selectedAudit(data) {
    if (data == null) {}
    _audit = _audits.firstWhere((element) => element.auditHead.id == data.id);
    add(UpdateForm(audit: _audit));
  }

  String getAuditType() {
    return _audit.auditHead.auditType;
  }

  String getAuditArea() {
    return _audit.auditHead.area;
  }

  void getAuditAspect(String type) {
    add(GetAuditAspectsEvent(type: type));
  }
}
