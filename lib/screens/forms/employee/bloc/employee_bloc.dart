import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/employee_model.dart';
import 'package:ehsfocus/services/http/http_employee.dart';
import 'package:meta/meta.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {}
  Employee _appEmployee;
  List<Employee> _appEmployees = [];
  final httpAuditService = HttpEmployeeService();
  @override
  Stream<EmployeeState> mapEventToState(
    EmployeeEvent event,
  ) async* {
    switch (event.runtimeType) {
      case GetEmployeesEvent:
        dynamic data = await httpAuditService.getAllEmployees();
        _appEmployees = data;
        yield EmployeesValueState(_appEmployees);
        break;

      case SetEmployeeEvent:
        dynamic data = await httpAuditService.setEmployee(event.employee);
        if (data == null) {
          // yield Error();
          break;
        }
        // move to service

        //
        //   yield AuditDataState(_audit);
        break;
      case GetMyselfEvent:
        if (_appEmployee != null) {
          yield EmployeeValueState(_appEmployee);
          break;
        }
        dynamic data = await httpAuditService.getMyself();
        _appEmployee = data;
        yield EmployeeValueState(data);
        break;
      default:
        EmployeeValueState(Employee());
    }
  }

  void getMyself() {
    add(GetMyselfEvent());
  }

  void getEmployees() {
    add(GetEmployeesEvent());
  }

  Employee getEmployee(String id) {
    return _appEmployees.firstWhere((employee) => employee.id == id);
  }
}
