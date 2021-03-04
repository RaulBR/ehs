import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/models/action/audit_head_modal.dart';

// to be removed
class AuditRequest {
  AuditHead auditHead;
  Aspect aspect;
  AuditRequest({this.aspect, this.auditHead});

  factory AuditRequest.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null || parsedJson['auditHead'] == null) {
      return AuditRequest();
    }
    AuditHead auditHead2 = AuditHead.fromJson(parsedJson['auditHead']);
    Aspect aspect2;
    if (parsedJson['aspect'] == null) {
      return AuditRequest();
    }
    aspect2 = Aspect.fromJson(parsedJson['aspect']);
    return AuditRequest(auditHead: auditHead2, aspect: aspect2);
  }

  Map<String, dynamic> toJson() => {
        "auditHead": auditHead?.toJson(),
        "aspect": aspect?.toJson(),
      };
}
