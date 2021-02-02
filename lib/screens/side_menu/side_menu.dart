import 'package:ehsfocus/bloc/login/login_bloc.dart';
import 'package:ehsfocus/screens/side_menu/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: NavogationService()
                .getMenu(BlocProvider.of<LoginBloc>(context).getUserRole(), () {
              BlocProvider.of<LoginBloc>(context).onLogout();
            })));
  }
}
