import 'dart:convert';

import 'package:ehsfocus/models/action_model.dart';
import 'package:ehsfocus/models/audit_head_modal.dart';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/services/http/http.dart';

class HttpAuditService extends HttpService {
  Future<List<dynamic>> getPhotosByAspectId(Aspect aspect) async {
    dynamic data = await postRequest(
        endpint: '/aspect/photos',
        jsonValue: jsonEncode({"id": aspect.id}),
        hasHeadder: true);
    dynamic result = (json.decode(data) as List) ?? [];
    if (result.length == 0) {
      return [];
    }
    return result.map((i) => AspectPhoto.fromJson(i)).toList();
  }

// move to poho
  deleteAspectPhoto(AspectPhoto aspectPhoto) async {
    dynamic data = await postRequest(
        endpint: '/aspect/delete-photo',
        jsonValue: jsonEncode({"id": aspectPhoto.id}),
        hasHeadder: true);
    dynamic result = json.decode(data);
    return result;
  }

  Future<dynamic> getAudit() async {
    String data = await getRequest(endpint: '/audits', hasHeadder: true);
    dynamic result = (json.decode(data) as List) ?? [];
    if (result.length == 0) {
      return [];
    }
    return result.map<Audit>((i) => Audit.fromJson(i)).toList();
  }

  Future<dynamic> getMyAudit() async {
    String data = await getRequest(endpint: '/myAudits', hasHeadder: true);
    dynamic result = (json.decode(data) as List) ?? [];
    if (result.length == 0) {
      return [];
    }
    return result.map<Audit>((i) => Audit.fromJson(i)).toList();
  }

  getAuditsToApprove() async {
    String data =
        await getRequest(endpint: '/auditsToApprove', hasHeadder: true);
    dynamic result = (json.decode(data) as List) ?? [];
    if (result.length == 0) {
      return [];
    }

    List<dynamic> auditsList = result.map((i) => Aspect.fromJson(i)).toList();
    return List<Aspect>.from(auditsList);
  }

  getAuditsToFix() async {
    String data = await getRequest(endpint: '/auditsToFix', hasHeadder: true);
    dynamic result = (json.decode(data) as List) ?? [];
    if (result.length == 0) {
      return [];
    }

    List<dynamic> auditsList = result.map((i) => Aspect.fromJson(i)).toList();
    return List<Aspect>.from(auditsList);
  }

  setAudit(AuditHead auditin) async {
    dynamic data = await postRequest(
        endpint: '/audit', jsonValue: jsonEncode(auditin), hasHeadder: true);
    return AuditHead.fromJson(json.decode(data));
  }

  submitAudit(AuditHead auditin) async {
    dynamic data = await postRequest(
        endpint: '/submitAudit',
        jsonValue: jsonEncode(auditin),
        hasHeadder: true);
    return json.decode(data);
  }

  setAspect(AuditRequest auditin) async {
    try {
      dynamic data = await postRequest(
          endpint: '/aspect', jsonValue: jsonEncode(auditin), hasHeadder: true);
      dynamic result = json.decode(data);
      return AuditRequest.fromJson(result);
    } catch (e) {
      throw e;
    }
  }

  rejectAspect(Aspect aspect) async {
    try {
      dynamic data = await postRequest(
          endpint: '/aspect/reject',
          jsonValue: jsonEncode(aspect),
          hasHeadder: true);
      dynamic result = json.decode(data);
      return Aspect.fromJson(result);
    } catch (e) {
      throw e;
    }
  }

  resolveAspect(Aspect aspect) async {
    dynamic data = await postRequest(
        endpint: '/aspect/resolve',
        jsonValue: jsonEncode(aspect),
        hasHeadder: true);
    dynamic result = json.decode(data);
    return Aspect.fromJson(result);
  }

  acceptAspect(Aspect aspect) async {
    dynamic data = await postRequest(
        endpint: '/aspect/accept',
        jsonValue: jsonEncode(aspect),
        hasHeadder: true);
    dynamic result = json.decode(data);
    return Aspect.fromJson(result);
  }

  Future<dynamic> deleteAudit(String id) async {
    String data = await deleteRequest(endpint: '/audits', id: id);
    return data;
  }

  Future<dynamic> getMyAudits() async {
    String data = await getRequest(endpint: '/audits', hasHeadder: true);
    dynamic result = (json.decode(data) as List) ?? [];
    if (result.length == 0) {
      return [];
    }
    return result.map((i) => Audit.fromJson(i)).toList();
  }

  Future<List<Aspect>> getMyRejectedAudits() async {
    try {
      return await _getManyAspects('/rejected');
    } catch (e) {
      return [];
    }
  }

  _getManyAspects(endpoint) async {
    String data = await getRequest(endpint: endpoint, hasHeadder: true);
    dynamic result = (json.decode(data) as List) ?? [];
    if (result.length == 0) {
      return [];
    }

    List<dynamic> auditsList = result.map((i) => Aspect.fromJson(i)).toList();
    return List<Aspect>.from(auditsList);
  }
}
