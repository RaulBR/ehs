
import 'package:ehsfocus/services/http/http_employee.dart';
import 'package:ehsfocus/state/employee_bloc/employee_list_bloc/employee_list_event.dart';
import 'package:ehsfocus/state/employee_bloc/employee_list_bloc/employee_list_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final httpEmployeeService = HttpEmployeeService();

  @override
  EmployeeListState get initialState => EmployeeListState.initial();

  @override
  Stream<EmployeeListState> mapEventToState(EmployeeListEvent event) async* {
    dynamic data;
    yield LoadingListState();
    switch (event.runtimeType) {
      case GetAllEmployeeEvent:
        data = await httpEmployeeService.getAllEmployees();
        yield EmployeeListState(employees: data);
        break;
      default:
        yield EmployeeListState(employees: null);
    }
  }

  void getEmployes() {
    add(GetAllEmployeeEvent());
  }


}
