import 'dart:convert';

import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/services/http/http.dart';

class HttpPhotoService extends HttpService {
  Future<List<AspectPhoto>> getPhotosByAspectId(Aspect aspect) async {
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
}
