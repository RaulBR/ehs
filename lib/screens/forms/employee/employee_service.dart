import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/bloc/employee/employee_bloc.dart';

class EmployeeService {
  List<GenericListObject> mapEmployeesToList(state) {
    return state is EmployeesValueState
        ? state.employees
            .map((e) => GenericListObject(
                id: e.id,
                title: '${e.firstName} ${e.lastName}',
                subtitle: e.role))
            .toList()
        : [];
  }

  String getName(employee) {
    if (employee != null) {
      String returnString =
          employee.firstName == null ? null : employee.firstName;
      returnString = employee.lastName == null
          ? returnString
          : returnString + ' ' + employee.lastName;
      return returnString;
    }
    return '';
  }
}
