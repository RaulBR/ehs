import 'package:ehsfocus/errors/employee_exception.dart';
import 'package:ehsfocus/models/employee/employee_model.dart';
import 'package:ehsfocus/services/http/http_employee.dart';
import 'package:ehsfocus/services/repository/local_database/employee_local_db.dart';

class EmployeeRepo {
  HttpEmployeeService _httpEmployeeService = HttpEmployeeService();
  EmployeeLocaldb _employeeLocaldb = EmployeeLocaldb();
  /*
  retrives data form local db, if data is absent it makes a hattp call
  add ofline check
  */
  Future<Employee> getMyself() async {
    try {
      Employee myself = await _employeeLocaldb.getMyself();
      if (myself == null) {
        myself = await _httpEmployeeService.getMyself();
        if (myself != null) {
          _employeeLocaldb.setMyself(myself);
        }
      }
      return myself;
    } catch (e) {
      print(e);
      throw EmployeeException('retrive faild');
    }
  }

  Future<List<Employee>> getAllEmployees() async {
    try {
      List<Employee> employees = await _employeeLocaldb.getAllEmployees();
      if (employees.length == 0) {
        employees = await _httpEmployeeService.getAllEmployees();
        _employeeLocaldb.setEployees(employees);
      }
      return employees;
    } catch (e) {
      throw EmployeeException('retrive faild');
    }
  }

  Future<Employee> setEmployee(Employee employee) async {
    try {
      Employee employeeRepo = await _httpEmployeeService.setEmployee(employee);
      _employeeLocaldb.setEmployee(employeeRepo);
      return employeeRepo;
    } catch (e) {
      throw EmployeeException('save faild');
    }
  }

  deleteEmployee(Employee employee) async {
    try {
      await _httpEmployeeService.deleteEmployee(employee);
      _employeeLocaldb.deleteEmployee(employee);
    } catch (e) {
      throw EmployeeException('delete faild');
    }
  }

  Future<Employee> getEmployee(String id) async {
    try {
      return await _employeeLocaldb.getEmployee(id);
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteLocaEmployee() async {
    _employeeLocaldb.deleteLocaEmployee();
  }
}
