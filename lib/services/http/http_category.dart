import 'dart:convert';
import 'package:ehsfocus/models/category_model.dart';
import 'package:ehsfocus/services/http/http.dart';

class HttpCategoryService extends HttpService {
  String _categoryUrl = '/category';
  getCategoryTypes() async {
    String data = await postRequest(
        endpint: '$_categoryUrl/get', jsonValue: null, hasHeadder: true);
    print(data);
    return (json.decode(data) as List)
        .map((i) => CategoryType.fromJson(i))
        .toList();
  }

  // setEmployee(Employee employee) async {
  //   String data = await postRequest(
  //       endpint: _categoryUrl, jsonValue: employee.toJson(), hasHeadder: true);
  //   return Employee.fromJson(json.decode(data));
  // }

  // deleteEmployee(Employee employee) async {
  //   if (employee == null) {
  //     return;
  //   }

  //   if (employee.id == null) {
  //     return;
  //   }

  //   String data = await deleteRequest(endpint: '$_categoryUrl${employee.id}');
  //   return data;
  // }

  // Future<dynamic> signOut() async {
  //   return postTeamplate('/api/user/logout', null);
  // }

}
