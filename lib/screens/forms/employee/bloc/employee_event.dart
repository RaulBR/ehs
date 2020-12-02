part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent {}

class GetEmployeeEvent extends EmployeeEvent {
  final Employee employee;
  GetEmployeeEvent({this.employee});
}

class GetMyselfEvent extends EmployeeEvent {}

class GetEmployeesEvent extends EmployeeEvent {}

class DeleteEmployeeEvent extends EmployeeEvent {
  final String id;

  DeleteEmployeeEvent(this.id);
}

class UpdateSelectedEmployeeEvent extends EmployeeEvent {
  final Employee employee;
  UpdateSelectedEmployeeEvent(this.employee);
}

class SetEmployeeEvent extends EmployeeEvent {
  final Employee employee;
  SetEmployeeEvent(this.employee);
}
