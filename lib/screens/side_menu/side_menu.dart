
import 'package:bookyourdriveing/state/login_bloc/login.dart';
import 'package:bookyourdriveing/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
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
            title: Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('refresh list'),
            onTap: () {
                //  BlocProvider.of<EmployeeListBloc>(context).getEmployes();
              Navigator.pop(context);
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Log out'),
            onTap: () {
              BlocProvider.of<LoginBloc>(context).onLogout();
              // Update the state of the app.
              // ...
            },
          ),
        ]));
  }
}
