import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/bloc/employee/employee_bloc.dart';
import 'package:ehsfocus/screens/forms/employee/employee_form.dart';
import 'package:ehsfocus/screens/forms/employee/employee_service.dart';
import 'package:ehsfocus/services/popup_service/generic_message_popup.dart';

import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_list_page_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeAdmin extends StatelessWidget {
  final EmployeeService employeeService = EmployeeService();
  @override
  Widget build(BuildContext context) {
    return EmployeeWrapper(
      child: BlocListener<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is Sucsess) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          buildWhen: (previous, current) => current is EmployeesValueState,
          builder: (context, state) {
            List<GenericListObject> list =
                employeeService.mapEmployeesToList(state);
            return SearchPageWrapper(
              title: Labels.employees,
              searchLabel: Labels.search,
              search: (data) {},
              add: () => BlocProvider.of<EmployeeBloc>(context)
                  .selectEmployee(id: null),
              selected: (data) => BlocProvider.of<EmployeeBloc>(context)
                  .selectEmployee(id: data.id),
              deleted: (data) async {
                if (await EhsGennericPopup()
                    .showPupup(context, what: data.title)) {
                  BlocProvider.of<EmployeeBloc>(context)
                      .deleteEmployee(id: data.id);
                }
              },
              listObjects: list,
              addForm: EmployeeForm(
                isAdd: true,
              ),
            );
          },
        ),
      ),
    );
  }
}

class EmployeeWrapper extends StatelessWidget {
  final Widget child;

  const EmployeeWrapper({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EmployeeBloc>(context).getEmployees();
    return child;
  }
}
