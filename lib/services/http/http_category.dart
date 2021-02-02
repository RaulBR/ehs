import 'dart:convert';
import 'package:ehsfocus/models/category/category_type_model.dart';
import 'package:ehsfocus/services/http/http.dart';

class HttpCategoryService extends HttpService {
  String _categoryUrl = '/category';
  String _deleteUrl = '/category/delete-categoryType';
  Future<List<CategoryType>> getCategoryTypes() async {
    try {
      String data = await postRequest(
          endpint: '$_categoryUrl/get', jsonValue: null, hasHeadder: true);

      return (json.decode(data) as List)
          .map((i) => CategoryType.fromJson(i))
          .toList();
    } catch (e) {
      return [];
    }
  }

  setCategoryType({CategoryType categoryType}) async {
    String data = await postRequest(
        endpint: _categoryUrl,
        jsonValue: json.encode(categoryType),
        hasHeadder: true);

    return CategoryType.fromJson(json.decode(data));
  }

  deleteCategoryTypes({CategoryType categoryType}) async {
    String data = await postRequest(
        endpint: _deleteUrl,
        jsonValue: json.encode(categoryType),
        hasHeadder: true);

    return (json.decode(data) as List)
        .map((i) => CategoryType.fromJson(i))
        .toList();
  }
}
