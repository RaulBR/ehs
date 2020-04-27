import 'package:bookyourdriveing/models/employee_model.dart';

class EmployeeState {
  Employee employee;
  EmployeeState({this.employee});
  factory EmployeeState.initial() => EmployeeState(employee: null);
}

class LoadingEmployeeState extends EmployeeState{
  bool isLoading = false;
  LoadingEmployeeState() {
    isLoading = !isLoading;
  }
}

class EmployeeError extends EmployeeState {
  String error;

  EmployeeError({this.error});
  factory EmployeeError.initial() => EmployeeError(error: null);
}
