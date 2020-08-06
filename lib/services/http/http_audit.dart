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
    return result.map((i) => Audit.fromJson(i)).toList();
  }

  setAudit(AuditHead auditin) async {
    dynamic data = await postRequest(
        endpint: '/audit', jsonValue: jsonEncode(auditin), hasHeadder: true);
    return json.decode(data);
  }

  setAspect(AuditRequest auditin) async {
    dynamic data = await postRequest(
        endpint: '/aspect', jsonValue: jsonEncode(auditin), hasHeadder: true);
    dynamic result = json.decode(data);
    return AuditRequest.fromJson(result);
  }

  Future<dynamic> deleteAudit(String id) async {
    String data = await deleteRequest(endpint: '/audits', id: id);
    return data;
  }
}
