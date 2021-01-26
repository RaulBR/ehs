import 'package:ehsfocus/models/employee/employee_model.dart';
import 'package:ehsfocus/bloc/employee/employee_bloc.dart';
import 'package:ehsfocus/screens/forms/employee/employee_service.dart';
import 'package:ehsfocus/shared/fields/search_picker/custom_list_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*
Needs A block provider of EmployeeBloc
Returns list of all Employees and lets you select a employee 
*/

class EmployeePicker extends StatelessWidget {
  final bool isEditable;
  final Function hasChanges;
  final Employee preSelected;
  final String lable;
  final EmployeeService _employeeService = EmployeeService();

  EmployeePicker(
      {Key key, this.isEditable, this.hasChanges, this.lable, this.preSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final EmployeeBloc _emmployeeBloc = BlocProvider.of<EmployeeBloc>(context);
    _emmployeeBloc.updateEmployee(preSelected);
    String _preSelected = _employeeService.getName(preSelected);
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeValueState) {
          Employee employee = state.employee;
          hasChanges(employee);
        }
      },
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeValueState)
            _preSelected = _employeeService.getName(state.employee);

          return EhsSearchListPicker(
            isEditable: isEditable,
            list: _employeeService.mapEmployeesToList(state),
            label: lable,
            selected: (data) {
              _emmployeeBloc.getEmployee(data.id);
            },
            tapped: () {
              BlocProvider.of<EmployeeBloc>(context).getEmployees();
            },
            preselected: _preSelected,
          );
        },
      ),
    );
  }
}

class IndependentEmployeePicker extends StatelessWidget {
  final bool isEditable;
  final Function hasChanges;
  final preSelected;
  final String lable;
  const IndependentEmployeePicker(
      {Key key, this.isEditable, this.hasChanges, this.lable, this.preSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(),
      child: BlocListener<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is EmployeeValueState) {
            Employee employee = state.employee;
            hasChanges(employee);
          }
        },
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) => EhsSearchListPicker(
            isEditable: isEditable,
            list: EmployeeService().mapEmployeesToList(state),
            label: lable,
            selected: (data) {
              BlocProvider.of<EmployeeBloc>(context).getEmployee(data.id);
            },
            tapped: () {
              BlocProvider.of<EmployeeBloc>(context).getEmployees();
            },
            preselected: preSelected,
          ),
        ),
      ),
    );
  }
}
