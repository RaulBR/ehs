import 'dart:convert';

import 'package:ehsfocus/models/area/area_model.dart';
import 'package:ehsfocus/models/area/area_role_model.dart';
import 'package:ehsfocus/services/http/http.dart';

class HttpAreaService extends HttpService {
  setArea(Area auditin) async {
    dynamic data = await postRequest(
        endpint: '/area', jsonValue: jsonEncode(auditin), hasHeadder: true);
    return Area.fromJson(json.decode(data));
  }

  Future<List<Area>> getAreas() async {
    try {
      String data = await postRequest(
          endpint: '/area/get',
          // jsonValue: jsonEncode(requestParams),
          hasHeadder: true);
      dynamic result = (json.decode(data) as List) ?? [];
      if (result.length == 0) {
        return [];
      }
      return (json.decode(data) as List).map((i) => Area.fromJson(i)).toList();
    } catch (e) {
      throw e;
    }
  }

  deleteArea(Area auditin) async {
    String data = await postRequest(
        endpint: '/area/delete',
        jsonValue: jsonEncode(auditin),
        hasHeadder: true);
    dynamic result = (json.decode(data) as List) ?? [];
    if (result.length == 0) {
      return [];
    }
    return result.map((i) => Area.fromJson(i)).toList();
  }

  deleteRole(AreaRole areaRole) async {
    String data = await postRequest(
        endpint: '/area/roledelete',
        jsonValue: jsonEncode(areaRole),
        hasHeadder: true);
    return Area.fromJson(json.decode(data));
  }
}
