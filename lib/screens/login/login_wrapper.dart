import 'package:ehsfocus/screens/login/login.dart';
import 'package:ehsfocus/screens/login/signup_form.dart';
import 'package:ehsfocus/services/websocket_service.dart/audit_socket_bloc/audit_socket_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWraper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuditSocketBloc>(context).disconnect();
    return MaterialApp(
      title: 'EHS Auth',
      theme: companyThemeData,
      initialRoute: '/',
      routes: {
        RoutPath.login: (context) => LoginForm(),
        RoutPath.signup: (context) => SignUpForm(),
      },
      home: LoginForm(),
    );
  }
}
