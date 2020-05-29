import 'dart:convert';
import 'package:ehsfocus/models/employee_model.dart';
import 'package:ehsfocus/services/http/http.dart';

class HttpEmployeeService extends HttpService {
  String employeeUrl = '/api/employee/';
  getAllEmployees() async {
    String data = await getRequest(endpint: employeeUrl, hasHeadder: true);
    return (json.decode(data) as List)
        .map((i) => Employee.fromJson(i))
        .toList();
  }

  setEmployee(Employee employee) async {
    String data = await postRequest(endpint: employeeUrl, jsonValue: employee.toJson() ,hasHeadder: true);
    return Employee.fromJson(json.decode(data));
  }

  deleteEmployee(Employee employee) async {
    if(employee == null) {
      return;
    }

    if(employee.id == null) {
      return;
    }

    String data = await deleteRequest(endpint: '$employeeUrl${employee.id}');
    print(data);
    return data;
  }


  // Future<dynamic> signOut() async {
  //   return postTeamplate('/api/user/logout', null);
  // }

}
