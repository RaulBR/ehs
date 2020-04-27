import 'package:bookyourdriveing/models/employee_model.dart';

class EmployeeListState {
  List<Employee> employees;
  EmployeeListState({this.employees});
  factory EmployeeListState.initial() => EmployeeListState(employees: null);
}

class LoadingListState extends EmployeeListState{
  bool isLoading = false;
  LoadingListState() {
    isLoading = !isLoading;
  }
}

class EmployeeListError extends EmployeeListState {
  String error;

  EmployeeListError({this.error});
  factory EmployeeListError.initial() => EmployeeListError(error: null);
}
