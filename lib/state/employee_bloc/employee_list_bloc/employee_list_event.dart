import 'package:ehsfocus/models/employee_model.dart';

abstract class EmployeeListEvent {
  Employee employee;
}


class GetAllEmployeeEvent extends EmployeeListEvent {}

