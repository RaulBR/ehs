import 'package:ehsfocus/models/employee_model.dart';
import 'package:ehsfocus/screens/forms/employee/bloc/employee_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideMenuHeader extends StatelessWidget {
  final Employee employee;
  final String appTtitle;
  const SideMenuHeader({Key key, this.employee, this.appTtitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Employee _employee = employee ?? Employee();

    BlocProvider.of<EmployeeBloc>(context).getMyself();
    return Column(
      children: [
        Text(
          appTtitle ?? Labels.ehsTitle,
          style: TextStyle(color: AppColors.lightprimary),
        ),
        ListTile(
          leading: Icon(
            Icons.portrait,
            color: AppColors.field,
            size: 80,
          ),

          title: Text(
            ' ${_employee.lastName} ${_employee.firstName} ',
            style: TextStyle(color: AppColors.icons),
          ),
          subtitle: Text(
            ' ${_employee.role}',
            style: TextStyle(color: AppColors.icons),
          ),
          //   ],
          // ),
        ),
      ],
    );
  }
}
