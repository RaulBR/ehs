import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/bloc/employee/employee_bloc.dart';

class AreaService {
  List<GenericListObject> addEmployeesToDropDown(context, state) {
    if (state is EmployeesValueState) {
      return state.employees
          .map((employee) => GenericListObject(
              id: employee.id,
              title: '${employee.firstName} ${employee.lastName}',
              subtitle: employee.role ?? null))
          .toList();
    }
    return [];
  }
}
