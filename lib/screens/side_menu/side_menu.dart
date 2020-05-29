import 'package:ehsfocus/state/employee_bloc/employee_bloc_index.dart';
import 'package:ehsfocus/state/login_bloc/login.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
        child: Text(
          'Drawer Header',
          style: TextStyle(color: AppColors.icons),
        ),
        decoration: BoxDecoration(
          color: AppColors.accent,
        ),
      ),
      ListTile(
        title: Text('Pagina Principala'),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
      ListTile(
        title: Text('Setari'),
        onTap: () {
          BlocProvider.of<EmployeeListBloc>(context).getEmployes();
          Navigator.pop(context);
        },
      ),
      ListTile(
        title: Text('Statistici'),
        onTap: () {
        Navigator.pop(context);
          Navigator.pushNamed(context, '/stats');
          
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
