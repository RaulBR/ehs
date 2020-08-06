part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent {
  Employee employee;
}

class GetEmployeeEvent extends EmployeeEvent {}

class GetMyselfEvent extends EmployeeEvent {}

class GetEmployeesEvent extends EmployeeEvent {}

class SetEmployeeEvent extends EmployeeEvent {
  final Employee employee;
  SetEmployeeEvent(this.employee);
}
