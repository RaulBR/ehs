import 'dart:convert';

import 'package:ehsfocus/models/area_modal.dart';
import 'package:ehsfocus/services/http/http.dart';

class HttpAreaService extends HttpService {
  setAudit(Area auditin) async {
    dynamic data = await postRequest(
        endpint: '/area', jsonValue: jsonEncode(auditin), hasHeadder: true);
    return json.decode(data);
  }

  Future<dynamic> getAudit(requestParams) async {
    String data = await postRequest(
        endpint: '/area/get',
        jsonValue: jsonEncode(requestParams),
        hasHeadder: true);
    dynamic result = (json.decode(data) as List) ?? [];
    if (result.length == 0) {
      return [];
    }
    return result.map((i) => Area.fromJson(i)).toList();
  }
}
