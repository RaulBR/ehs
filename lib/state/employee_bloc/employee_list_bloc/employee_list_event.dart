import 'package:bookyourdriveing/models/employee_model.dart';

abstract class EmployeeListEvent {
  Employee employee;
}


class GetAllEmployeeEvent extends EmployeeListEvent {}

