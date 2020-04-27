import 'package:bookyourdriveing/models/employee_model.dart';

abstract class EmployeeEvent {
  Employee employee;
}

class AddEmployeeEvent extends EmployeeEvent {
  AddEmployeeEvent({Employee employee}) {
    this.employee = employee;
  }
}

class UpdateEmployeeEvent extends EmployeeEvent {
  UpdateEmployeeEvent({Employee employee}) {
    this.employee = employee;
  }
}

class DeleteEmployeeEvent extends EmployeeEvent {
  DeleteEmployeeEvent({Employee employee}) {
    this.employee = employee;
  }
}


class GetEmployeeEvent extends EmployeeEvent {
  GetEmployeeEvent({Employee employee}) {
    this.employee = employee;
  }
}
