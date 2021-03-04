import 'dart:convert';

import 'package:ehsfocus/models/category/category_type_responsible.dart';
import 'package:ehsfocus/services/http/http.dart';

class HttpCategoryManagmentService extends HttpService {
  String _categoryUrl = '/categoryManagement';

  Future<List<CategoryTypeResponsible>> getCategoryTypeResponsible() async {
    try {
      String data =
          await getRequest(endpint: '$_categoryUrl', hasHeadder: true);

      return (json.decode(data) as List)
          .map((i) => CategoryTypeResponsible.fromJson(i))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<CategoryTypeResponsible> setCategoryTypeResponsible(
      {CategoryTypeResponsible categoryType}) async {
    String data = await postRequest(
        endpint: _categoryUrl,
        jsonValue: json.encode(categoryType),
        hasHeadder: true);

    return CategoryTypeResponsible.fromJson(json.decode(data));
  }

  deleteCategoryTypeResponsible({CategoryTypeResponsible categoryType}) async {
    String data = await postRequest(
        endpint: '$_categoryUrl/delete',
        jsonValue: json.encode(categoryType),
        hasHeadder: true);
    return json.decode(data);
    // return (json.decode(data) as List)
    //     .map((i) => CategoryType.fromJson(i))
    //     .toList();
  }
}
