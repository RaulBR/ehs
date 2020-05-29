import 'package:ehsfocus/models/action_model.dart';

abstract class AuditEvent {
  Audit audit;
  AuditEvent({this.audit});
}

class GetMyAudits extends AuditEvent {}

class GetMyAudit extends AuditEvent {}

class GetMyTasks extends AuditEvent {}

class OpenNavigator extends AuditEvent {
  int page;
  OpenNavigator({this.page});
}

class SetAudit extends AuditEvent {
  Audit audit;
  SetAudit({this.audit});
}

class EditAudit extends AuditEvent {
  Audit audit;
  EditAudit({this.audit});
}

class DeleteAudit extends AuditEvent {
  String id;
  DeleteAudit({this.id});
}
