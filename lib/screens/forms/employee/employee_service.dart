import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/forms/employee/bloc/employee_bloc.dart';

class EmployeeService {
  List<GenericListObject> mapToList(state) {
    return state is EmployeesValueState
        ? state.employees
            .map((e) => GenericListObject(
                id: e.id,
                title: '${e.firstName} ${e.lastName}',
                subtitle: e.role))
            .toList()
        : [];
  }
}
