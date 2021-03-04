import 'package:ehsfocus/errors/employee_exception.dart';
import 'package:ehsfocus/models/employee/employee_model.dart';

import 'package:ehsfocus/services/repository/local_database/repo.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:hive/hive.dart';

class EmployeeLocaldb extends HiveRepo {
  /*
  retrives data form local db, if data is absent it makes a hattp call
  add ofline check
  */
  Future<Employee> getMyself() async {
    try {
      Box<Employee> _myselfBox = await _initiateMyBox();
      Employee myself = _myselfBox.get(0);
      return myself;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Employee>> getAllEmployees() async {
    try {
      Box<Employee> employeesBox = await _initiateEmployeeBox();
      return convertBoxToList<Employee>(employeesBox);
    } catch (e) {
      throw EmployeeException('retrive faild');
    }
  }

  Future<Employee> setEmployee(Employee employee) async {
    try {
      Box<Employee> employeesBox = await _initiateEmployeeBox();
      employeesBox.put(employee.id, employee);
      return employee;
    } catch (e) {
      throw EmployeeException('save faild');
    }
  }

  deleteEmployee(Employee employee) async {
    try {
      Box<Employee> employeesBox = await _initiateEmployeeBox();
      employeesBox.delete(employee.id);
    } catch (e) {
      throw EmployeeException('delete faild');
    }
  }

  Future<Employee> getEmployee(String id) async {
    try {
      if (id == null) return null;
      Box<Employee> employees = await _initiateEmployeeBox();
      Employee employeedb = employees.get(id);
      for (int i = 0; i < employees.length; i++) {
        Employee emp = employees.getAt(i);
        if (emp.id == id) {
          employeedb = emp;
          return employeedb;
        }
      }
      return employeedb;
    } catch (e) {
      return null;
    }
  }

  Future<Box<Employee>> _initiateEmployeeBox() async {
    return await initiateBox<Employee>(HiveName.employees);
  }

  Future<Box<Employee>> _initiateMyBox() async {
    return await initiateBox<Employee>(HiveName.mySelf);
  }

  Future<void> setMyself(Employee myself) async {
    Box<Employee> _myselfBox = await _initiateMyBox();
    await _myselfBox.put(0, myself);
  }

  void setEployees(List<Employee> employees) {
    _saveToLocalDb(employees);
  }

  Future<void> _saveToLocalDb(List<Employee> employees) async {
    Box<Employee> employeesBox = await _initiateEmployeeBox();
    if (employees.length > 0) {
      employees.forEach((element) {
        employeesBox.put(element.id, element);
      });
    }
  }

  Future<void> deleteLocaEmployee() async {
    Box<Employee> empBox = await _initiateMyBox();
    Box<Employee> empsBox = await _initiateEmployeeBox();
    empBox.clear();
    empsBox.clear();
  }
}
