import 'package:ehsfocus/errors/error_model.dart';
import 'package:ehsfocus/models/action/audit_model.dart';
import 'package:ehsfocus/models/action/audit_request_model.dart';
import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/services/http/http_audit.dart';
import 'package:ehsfocus/services/repository/local_database/audit_local_db.dart';
import 'package:ehsfocus/shared/constants.dart';

class AuditRepo {
  HttpAuditService _httpAuditService = HttpAuditService();
  AuditLocalDb _auditLocalDb = AuditLocalDb();
  Future<List<dynamic>> getPhotosByAspectId(Aspect aspect) async {}

// move to poho
  deleteAspectPhoto(AspectPhoto aspectPhoto) async {}

  Future<Audit> getAudit() async {
    try {
      Audit audit = await _auditLocalDb.getAudit();
      if (audit != null) return audit;
      audit = await _httpAuditService.getMyAudits();
      return audit;
    } catch (e) {
      throw GetException(Errors.getError);
    }
  }

  Future<Audit> getMyAudit() async {
    return _auditLocalDb.getMyAudit();
  }

  getAuditsToApprove() async {}

  getAuditsToFix() async {}

  Future<Audit> setAudit(AuditHead auditin) async {
    return await _auditLocalDb.setAudit(auditin);
  }

  submitAudit(AuditHead auditin) async {}

  setAspect(AuditRequest auditin) async {
    try {} catch (e) {
      throw e;
    }
  }

  rejectAspect(Aspect aspect) async {
    try {} catch (e) {
      throw e;
    }
  }

  resolveAspect(Aspect aspect) async {}

  acceptAspect(Aspect aspect) async {}

  Future<dynamic> deleteAudit(String id) async {
    _auditLocalDb.deleteAudit2();
  }

  Future<dynamic> getMyAudits() async {}

  Future<List<Aspect>> getMyRejectedAudits() async {
    try {} catch (e) {
      return [];
    }
  }

  _getManyAspects(endpoint) async {}

  Future<Audit> setAspect2(Aspect aspect) async {
    return await _auditLocalDb.setAuditAspect(aspect);
  }
}
