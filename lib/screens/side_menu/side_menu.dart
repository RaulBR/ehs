import 'package:ehsfocus/screens/forms/employee/bloc/employee_bloc.dart';
import 'package:ehsfocus/screens/login/login_bloc/login_bloc.dart';
import 'package:ehsfocus/screens/side_menu/side_menu_headder.dart';
import 'package:ehsfocus/shared/constants.dart';

import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EmployeeBloc>(context).getMyself();
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      BlocBuilder<EmployeeBloc, EmployeeState>(
        buildWhen: (previous, current) => current is EmployeeValueState,
        builder: (context, state) {
          return DrawerHeader(
            child: SideMenuHeader(
              employee: state.employee,
            ),
            decoration: BoxDecoration(
              color: AppColors.accent,
            ),
          );
        },
      ),
      ListTile(
        title: Text(Labels.mainPage),
        onTap: () {
          Navigator.pushReplacementNamed(context, RoutPath.homeRout);
        },
      ),
      ListTile(
        title: Text(Labels.settings),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: Text(Labels.statistics),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, RoutPath.statsRout);
        },
      ),
      ListTile(
        title: Text(Labels.audits),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, RoutPath.auditsRoute);
        },
      ),
      ListTile(
        title: Text(Labels.myData),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, RoutPath.employeeRout);
        },
      ),
      ListTile(
        title: Text(Labels.category),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, RoutPath.categoryRoute);
        },
      ),
      ListTile(
        title: Text('Log out'),
        onTap: () {
          BlocProvider.of<LoginBloc>(context).onLogout();
          print('logout');
        },
      ),
    ]));
  }
}
