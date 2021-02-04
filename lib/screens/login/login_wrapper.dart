import 'package:ehsfocus/screens/login/login.dart';
import 'package:ehsfocus/screens/login/signup_form.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWraper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EHS Auth',
      theme: companyThemeData,
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginForm(),
        '/signup': (context) => SignUpForm(),
      },
      home: LoginForm(),
    );
  }
}
