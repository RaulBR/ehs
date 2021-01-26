import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/models/action/audit_head_modal.dart';

// to be removed
class AuditRequest {
  AuditHead auditHead;
  Aspect aspect;
  AuditRequest({this.aspect, this.auditHead});

  AuditRequest.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson == null || parsedJson['auditHead'] == null) {
      return;
    }
    auditHead = AuditHead.fromJson(parsedJson['auditHead']);
    if (parsedJson['aspect'] == null) {
      aspect = null;
      return;
    }
    aspect = Aspect.fromJson(parsedJson['aspect']);
  }

  Map<String, dynamic> toJson() => {
        "auditHead": auditHead?.toJson(),
        "aspect": aspect?.toJson(),
      };
}
