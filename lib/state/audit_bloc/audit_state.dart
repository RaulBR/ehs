import 'package:ehsfocus/models/action_model.dart';

// class AuditState {
//   Audit audit;
//   AuditState({this.audit});
//   factory AuditState.initial() => AuditState(audit: null);
// }

// class AuditLoading extends AuditState {}

// class AuditError extends AuditState {
//   String error;

//   AuditError(this.error);
//   factory AuditError.initial() => AuditError(null);
// }

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
class AuditLoading extends AuditState {}
