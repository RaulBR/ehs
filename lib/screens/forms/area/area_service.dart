import 'package:ehsfocus/models/drop_down_model.dart';
import 'package:ehsfocus/screens/forms/employee/bloc/employee_bloc.dart';

class AreaService {
  List<DropDown> addEmployeesToDropDown(context, state) {
    if (state is EmployeesValueState) {
      return state.employees
          .map((employee) => DropDown(
              id: employee.id,
              type: '${employee.firstName} ${employee.lastName}',
              subtype: employee.role ?? null))
          .toList();
    }
  }
}
