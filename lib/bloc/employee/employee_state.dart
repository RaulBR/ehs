part of 'employee_bloc.dart';

@immutable
abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeValueState extends EmployeeState {
  final Employee employee;
  EmployeeValueState(this.employee);
}

class SetEmployeeState extends EmployeeState {
  final Employee employee;
  SetEmployeeState(this.employee);
}

class DeleteEmployeeState extends EmployeeState {
  final Employee employee;
  DeleteEmployeeState(this.employee);
}

class EmployeesValueState extends EmployeeState {
  final List<Employee> employees;
  EmployeesValueState({this.employees});
}

class Sucsess extends EmployeeState {}

class Error extends EmployeeState {}
