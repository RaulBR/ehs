import 'package:ehsfocus/errors/error_model.dart';
import 'package:ehsfocus/models/action/audit_model.dart';
import 'package:ehsfocus/models/action/audit_request_model.dart';
import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/services/http/http_audit.dart';
import 'package:ehsfocus/services/repository/local_database/audit_local_db.dart';
import 'package:ehsfocus/services/repository/photo_repo.dart';
import 'package:ehsfocus/shared/constants.dart';

class AuditRepo {
  HttpAuditService _httpAuditService = HttpAuditService();
  AuditLocalDb _auditLocalDb = AuditLocalDb();
  PhotoRepo _photoRepo = PhotoRepo();

  Future<Audit> getAudit() async {
    try {
      Audit audit = await _auditLocalDb.getMyAudit();
      if (audit != null) return audit;
      List<Audit> audits = await _httpAuditService.getMyAudits();
      await _auditLocalDb.setHollAudit(audits[0]);
      return audits[0];
    } catch (e) {
      throw GetException(Errors.getError);
    }
  }

  Future<Audit> getMyAudit() async {
    return _auditLocalDb.getMyAudit();
  }

  setAuditHead(AuditHead auditHead) async {
    await _auditLocalDb.setAuditHead(auditHead);
  }

// frist iteration

  Future<Audit> setAudit(Audit audit) async {
    Audit newAudit = Audit();
    if (audit.negativeAspects == null) audit.negativeAspects = [];
    if (audit.positiveAspects == null) audit.positiveAspects = [];
    List<Aspect> aspects = [...audit.negativeAspects, ...audit.positiveAspects];
    newAudit.auditHead = await _httpAuditService.setAudit(audit.auditHead);
    newAudit.negativeAspects = await setEachAspect(aspects, newAudit.auditHead);
    newAudit = getAuditHead(newAudit);
    await _auditLocalDb.setHollAudit(newAudit);
    return newAudit;
  }

  Future<List<Aspect>> setEachAspect(List<Aspect> audit, auditHead) async {
    if (audit == null) return [];
    if (audit.length == 0) return [];
    AuditRequest auditRequest = AuditRequest();
    auditRequest.auditHead = auditHead;
    List<Aspect> aspects = [];
    for (Aspect element in audit) {
      element.photos = await getPhotosForAspect(element.photos);
      auditRequest.aspect = element;
      auditRequest.aspect.auditId = auditHead.id;
      auditRequest = await _httpAuditService.setAspect(auditRequest);
      auditRequest.aspect =
          _auditLocalDb.clearPhotosFromAspect(auditRequest.aspect);
      aspects.add(auditRequest.aspect);
    }
    return aspects;
  }

  Future<List<AspectPhoto>> getPhotosForAspect(
      List<AspectPhoto> aspectPotos) async {
    if (aspectPotos == null) return [];
    List<AspectPhoto> photos = [];
    for (AspectPhoto element in aspectPotos) {
      AspectPhoto photo = await _photoRepo.getFromFile(element.name);
      element.photo = photo.photo;
      photos.add(element);
    }
    return photos;
  }

  submitAudit() async {
    Audit audit = await _auditLocalDb.getMyAudit();
    dynamic result = await _httpAuditService.submitAudit(audit.auditHead);
    await _auditLocalDb.clearAudit();
  }

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
    String a;
    _auditLocalDb.deleteAudit2().then((value) => a == 'success');
    await _httpAuditService.deleteAudit(id);
    return a;
  }

  Future<void> deleteFromLovalDb() async {
    await _auditLocalDb.deleteAudit2();
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

  Audit getAuditHead(Audit audit) {
    List<Aspect> aspects = audit.negativeAspects;
    audit.negativeAspects = [];
    audit.positiveAspects = [];
    aspects.forEach((element) {
      if (audit.auditHead == null) audit.auditHead = element.audit;
      if (element.type == 'N') audit.negativeAspects.add(element);
      if (element.type == 'P') audit.positiveAspects.add(element);
    });
    return audit;
  }
}
