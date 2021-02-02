import 'package:ehsfocus/models/action/audit_model.dart';
import 'package:ehsfocus/models/action/audit_request_model.dart';
import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';

abstract class AuditEvent {
  String id;
  Audit audit;
  Aspect aspect;
  AspectPhoto aspectPhoto;
  AuditRequest auditRequest;
  AuditEvent({this.audit});
}

class GetMyAudit extends AuditEvent {}

class GetMyAuditsEvent extends AuditEvent {}

class UpdateForm extends AuditEvent {
  final Audit audit;
  UpdateForm({this.audit});
}

class GetAuditAspectsEvent extends AuditEvent {
  final String type;
  GetAuditAspectsEvent({this.type});
}

class SetAudit extends AuditEvent {
  final Audit audit;
  SetAudit({this.audit});
}

class SetAuditHead extends AuditEvent {
  final Audit audit;
  SetAuditHead({this.audit});
}

class GetAuditsToApprove extends AuditEvent {}

class SubmitAudit extends AuditEvent {
  SubmitAudit();
}

class EditAudit extends AuditEvent {
  final Audit audit;
  EditAudit({this.audit});
}

class DeleteAudit extends AuditEvent {
  String id;
  DeleteAudit({this.id});
}

class SetAspect extends AuditEvent {
  List<Aspect> aspects;
  SetAspect({this.aspects});
}

class SetAuditAspect extends AuditEvent {
  AuditRequest auditRequest;
  SetAuditAspect({this.auditRequest});
}
