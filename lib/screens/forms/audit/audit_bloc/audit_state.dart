import 'package:ehsfocus/models/action_model.dart';
import 'package:ehsfocus/models/aspects_model.dart';

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

class AuditsToApproveState extends AuditState {
  List<Aspect> areaList;
  AuditsToApproveState(this.areaList);
}

class Error extends AuditState {}

class DeleteSucsesfull extends AuditState {}

class AutidResponsable extends AuditState {
  final List<String> employees;
  AutidResponsable(this.employees);
}

class AuditLoading extends AuditState {}
