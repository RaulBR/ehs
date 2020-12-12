import 'dart:convert';
import 'package:ehsfocus/models/employee_model.dart';
import 'package:ehsfocus/services/http/http.dart';

class HttpEmployeeService extends HttpService {
  String employeeUrl = '/employee';
  getAllEmployees() async {
    String data = await postRequest(
        endpint: '$employeeUrl/get', jsonValue: null, hasHeadder: true);
    print(data);
    return (json.decode(data) as List)
        .map((i) => Employee.fromJson(i))
        .toList();
  }

  getMyself() async {
    try {
      String data = await getRequest(endpint: employeeUrl, hasHeadder: true);
      return Employee.fromJson(json.decode(data));
    } catch (e) {
      return Employee();
    }
  }

  setEmployee(Employee employee) async {
    String data = await postRequest(
        endpint: employeeUrl,
        jsonValue: json.encode(employee),
        hasHeadder: true);
    return Employee.fromJson(json.decode(data));
  }

  deleteEmployee(Employee employee) async {
    if (employee == null) {
      return;
    }

    if (employee.id == null) {
      return;
    }

    String data = await deleteRequest(endpint: '$employeeUrl${employee.id}');
    return data;
  }

  deleteEmployees(Employee employee) async {
    String data = await postRequest(
        endpint: '$employeeUrl/delete',
        jsonValue: json.encode(employee),
        hasHeadder: true);
    return Employee.fromJson(json.decode(data));
  }
  // Future<dynamic> signOut() async {
  //   return postTeamplate('/api/user/logout', null);
  // }

}
