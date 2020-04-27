import 'dart:convert';
import 'package:bookyourdriveing/models/employee_model.dart';
import 'package:bookyourdriveing/services/http/http.dart';

class HttpEmployeeService extends HttpService {
  getAllEmployees() async {
    String data = await getRequest(endpint: '/api/employee', hasHeadder: true);
    return (json.decode(data) as List)
        .map((i) => Employee.fromJson(i))
        .toList();
  }

  setEmployee(employee) async {

    String data = await getRequest(endpint: '/api/employee', hasHeadder: true);
    return Employee.fromJson(json.decode(data));
  }

  // Future<dynamic> signUp(Employee employee) async {
  //   return postTeamplate('/api/user', employee);
  // }

  // Future<dynamic> signOut() async {
  //   return postTeamplate('/api/user/logout', null);
  // }

}
