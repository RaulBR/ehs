import 'package:ehsfocus/models/employee/employee_model.dart';
import 'package:ehsfocus/screens/forms/employee/bloc/employee_bloc.dart';
import 'package:ehsfocus/screens/side_menu/side_menu_headder_content.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrowerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeBloc, EmployeeState>(
      buildWhen: (previous, current) => current is EmployeeValueState,
      builder: (context, state) {
        Employee employee = Employee();
        employee = state is EmployeeValueState ? state.employee : employee;
        return DrawerHeader(
          child: SideMenuHeaderContent(
            employee: employee,
          ),
          decoration: BoxDecoration(
            color: AppColors.accent,
          ),
        );
      },
    );
  }
}
