import 'package:ehsfocus/models/action/audit_model.dart';
import 'package:ehsfocus/models/action/audit_request_model.dart';
import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/services/repository/local_database/photo_local.db.dart';
import 'package:ehsfocus/services/repository/local_database/repo.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:hive/hive.dart';

class AuditLocalDb extends HiveRepo {
  PhotoLocalDb _photoLocalDb = PhotoLocalDb();
  Future<Audit> setAuditAspect(Aspect aspect) async {
    try {
      Audit localAudit = await getMyAudit();
      if (localAudit == null) {
        localAudit = initiateAuditObject(localAudit);
      }
      aspect.audit = localAudit.auditHead;
      aspect = clearPhotosFromAspect(aspect);
      if (aspect.type == 'N') {
        if (localAudit.negativeAspects == null) localAudit.negativeAspects = [];
        localAudit.negativeAspects.add(aspect);
      } else {
        if (localAudit.positiveAspects == null) localAudit.positiveAspects = [];
        localAudit.positiveAspects.add(aspect);
      }
      setHollAudit(localAudit);
      return localAudit;
    } catch (e) {
      throw e;
    }
  }

  Audit initiateAuditObject(Audit localAudit) {
    localAudit = localAudit == null ? Audit() : localAudit;
    localAudit.negativeAspects =
        localAudit.negativeAspects == null ? [] : localAudit.negativeAspects;
    localAudit.positiveAspects =
        localAudit.positiveAspects == null ? [] : localAudit.positiveAspects;
    return localAudit;
  }

  Aspect clearPhotosFromAspect(Aspect aspect) {
    if (aspect.photos != null) {
      if (aspect.photos.length > 0)
        aspect.photos.forEach((element) {
          element.photo = null;
        });
    }
    return aspect;
  }

  Future<Audit> initiateAudit({Audit audit}) async {
    Box<Audit> aspectBox = await initiateBox(HiveName.audit);
    Audit localAudit = aspectBox.get(0);
    audit = audit == null ? Audit() : audit;
    audit.negativeAspects =
        audit.negativeAspects == null ? [] : audit.negativeAspects;
    audit.positiveAspects =
        localAudit.positiveAspects = null ? [] : localAudit.positiveAspects;
    setHollAudit(audit);
    return localAudit;
  }

// move to poho
  deleteAspectPhoto(AspectPhoto aspectPhoto) async {}

  Future<Audit> getAudit() async {
    Box<Audit> aspectBox = await initiateBox(HiveName.aspect);
    Audit a = aspectBox.get(0);

    return a;
  }

  Future<Audit> getMyAudit() async {
    try {
      Box<Audit> aspectBox = await initiateBox(HiveName.audit);
      Audit audit = aspectBox.get(0);
      if (audit == null) {
        audit = Audit();
      }
      return audit;
    } catch (e) {
      return null;
    }
  }

  getAuditsToApprove() async {}

  getAuditsToFix() async {}

  Future<Audit> setAuditHead(AuditHead auditin) async {
    if (auditin == null) return null;
    Box<Audit> aspectBox = await initiateBox(HiveName.audit);
    Audit localAudit = aspectBox.get(0);
    if (localAudit == null) {
      localAudit = Audit();
    }
    if (auditin == null) {
      localAudit.auditHead = AuditHead();
    } else {
      localAudit.auditHead = auditin;
    }
    if (localAudit.negativeAspects == null) localAudit.negativeAspects = [];
    if (localAudit.positiveAspects == null) localAudit.positiveAspects = [];
    setHollAudit(localAudit);
    return localAudit;
  }

  Future<void> setHollAudit(Audit audit) async {
    if (audit == null) return;
    if (audit.auditHead == null &&
        audit.negativeAspects == null &&
        audit.positiveAspects == null) return;
    try {
      Box<Audit> aspectBox = await initiateBox(HiveName.audit);
      await aspectBox.put(0, audit);
    } catch (e) {
      print(e);
    }
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

  Future<void> deleteAudit2() async {
    Box<Audit> aspectBox = await initiateBox(HiveName.audit);
    Audit audit = aspectBox.get(0);
    if (audit == null) {
      return;
    }
    List elemetns = [];
    if (audit.positiveAspects != null) {
      elemetns = audit.positiveAspects;
    }
    if (audit.negativeAspects != null) {
      elemetns = [...elemetns, ...audit.negativeAspects];
    }

    elemetns.forEach((element) {
      if (element.photos != null)
        element.photos.forEach((photo) {
          _photoLocalDb.removePhoto(photo);
        });
    });
    await aspectBox.delete(0);
  }

  Future<dynamic> getMyAudits() async {}

  Future<List<Aspect>> getMyRejectedAudits() async {
    try {} catch (e) {
      return [];
    }
  }

  _getManyAspects(endpoint) async {}

  clearAudit() async {
    Box<Audit> auditBox = await initiateBox<Audit>(HiveName.audit);
    await auditBox.clear();
  }
}
