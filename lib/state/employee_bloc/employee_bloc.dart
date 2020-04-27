import 'package:bookyourdriveing/models/employee_model.dart';
import 'package:bookyourdriveing/services/http/http_employee.dart';
import 'package:bookyourdriveing/state/employee_bloc/employee_bloc_index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final httpEmployeeService = HttpEmployeeService();

  @override
  // TODO: implement initialState
  EmployeeState get initialState => EmployeeState.initial();

  @override
  Stream<EmployeeState> mapEventToState(EmployeeEvent event) async* {
    dynamic data;
    yield LoadingEmployeeState();
    switch (event.runtimeType) {
      case GetEmployeeEvent:
        yield EmployeeState(employee: data);
        break;
      case AddEmployeeEvent:
        data = await httpEmployeeService.setEmployee(event.employee);
        yield EmployeeState(employee: null);
        break;
      default:
        yield EmployeeState(employee: null);
    }
  }

  void setEmployee({Employee employee}) {
    print('here');
    if (employee == null) {
      return;
    }
    print(employee.toJson());
    add(AddEmployeeEvent(employee: employee));
  }

  void deleteEmployees({Employee employee}) {
    if (employee == null) {
      return;
    }
    add(DeleteEmployeeEvent(employee: employee));
  }

  void getSpecificEmployee({Employee employee}) {
    add(GetEmployeeEvent(employee: employee));
  }

  void updateSpecificEmployee({Employee employee}) {
    add(UpdateEmployeeEvent(employee: employee));
  }
}
