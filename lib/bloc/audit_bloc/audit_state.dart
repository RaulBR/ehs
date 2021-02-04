import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/action/audit_model.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';

abstract class AuditState {}

class AuditStateInitial extends AuditState {
  Audit audit;
  AuditStateInitial({this.audit});
  factory AuditStateInitial.initial() => AuditStateInitial(audit: null);
}

class AuditDataState extends AuditState {
  Audit audit;
  AuditDataState(this.audit);
}

class AduitAspectsState extends AuditState {
  List<Aspect> aspects;
  AduitAspectsState({this.aspects});
}

class AuditsDataState extends AuditState {
  List<Audit> areaList;
  AuditsDataState({this.areaList});
}

class AspectAddedState extends AuditState {
  Aspect aspect;
  AspectAddedState({this.aspect});
}

// move
class AuditsToApproveState extends AuditState {
  List<Aspect> areaList;
  AuditsToApproveState(this.areaList);
}

class Error extends AuditState {
  final dynamic error;
  Error({
    this.error,
  });
}

class DeleteSucsesfull extends AuditState {}

class AutidResponsable extends AuditState {
  final List<String> employees;
  AutidResponsable(this.employees);
}

class AuditLoading extends AuditState {}

class AduitHeadState extends AuditState {
  AuditHead auditHead;
  AduitHeadState({this.auditHead});
}
