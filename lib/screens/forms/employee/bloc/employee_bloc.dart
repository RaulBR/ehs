import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/employee/employee_model.dart';

import 'package:ehsfocus/services/http/http_employee.dart';
import 'package:ehsfocus/services/loacal_storage.dart';
import 'package:ehsfocus/services/repository/employee_repo.dart';
import 'package:meta/meta.dart';
part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial());
  Employee _appEmployee;
  Employee _selectedEmployee;
  List<Employee> _appEmployees = [];
  final _localStorageService = LocalStorageService();
  final _employeeRepo = EmployeeRepo();
  // final httpEmployeeService = HttpEmployeeService();
  @override
  Stream<EmployeeState> mapEventToState(
    EmployeeEvent event,
  ) async* {
    switch (event.runtimeType) {
      case GetEmployeesEvent:
        dynamic data = await _employeeRepo.getAllEmployees();
        _appEmployees = data;

        yield EmployeesValueState(employees: _appEmployees);
        break;
      case DeleteEmployeeEvent:
        Employee e = Employee();
        e.id = event is DeleteEmployeeEvent ? event.id : null;
        // await httpEmployeeService.deleteEmployees(e);
        await _employeeRepo.deleteEmployee(e);
        add(GetEmployeesEvent());
        break;
      case UpdateSelectedEmployeeEvent:
        Employee e =
            event is UpdateSelectedEmployeeEvent ? event.employee : null;
        yield EmployeeValueState(e);
        break;
      case SetEmployeeEvent:
        Employee employee = event is SetEmployeeEvent ? event.employee : null;
        try {
          dynamic data = await _employeeRepo.setEmployee(employee);
          yield EmployeeValueState(data);
          yield Sucsess();
          add(GetEmployeesEvent());
        } catch (e) {
          yield Error();
        }

        // move to service

        //
        //   yield AuditDataState(_audit);
        break;
      case GetEmployeeEvent:
        if (event is GetEmployeeEvent) {
          yield EmployeeValueState(event.employee);
        }
        yield EmployeeValueState(
            event is GetEmployeeEvent ? event.employee : Employee());
        break;
      case GetMyselfEvent:
        if (_appEmployee != null) {
          yield EmployeeValueState(_appEmployee);
          break;
        }

        dynamic data = await _employeeRepo.getMyself();
        _appEmployee = data;
        if (_appEmployee.email == null) {
          _appEmployee.email = await _localStorageService.getEmail();
        }
        yield EmployeeValueState(data);
        break;
      default:
        EmployeeValueState(Employee());
    }
  }

  void getMyself() {
    add(GetMyselfEvent());
  }

  Employee getMe() {
    return _appEmployee;
  }

  void getEmployees() {
    add(GetEmployeesEvent());
  }

  void setEmployee(Employee employee) {
    add(SetEmployeeEvent(employee));
  }

  void deleteEmployee({String id}) {
    add(DeleteEmployeeEvent(id));
  }

  Employee getEmployee(String id) {
    Employee dude = _appEmployees.firstWhere((employee) => employee.id == id);
    add(UpdateSelectedEmployeeEvent(dude));
    return dude;
  }

  void selectEmployee({String id}) {
    if (id == null) {
      add(GetEmployeeEvent(employee: Employee()));
      return;
    }
    _selectedEmployee = getEmployee(id);
    add(GetEmployeeEvent(employee: _selectedEmployee));
  }

  void updateEmployee(Employee employee) {
    if (employee == null) employee = Employee();
    add(UpdateSelectedEmployeeEvent(employee));
  }
}
