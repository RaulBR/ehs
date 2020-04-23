
import 'package:bookyourdriveing/screens/login/login.dart';
import 'package:bookyourdriveing/screens/login/signup_form.dart';
import 'package:bookyourdriveing/theme.dart';
import 'package:flutter/material.dart';
class LoginWraper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   MaterialApp (
        title: 'Flutter Demo',
        theme: CompanyThemeData,
        initialRoute: '/',
        routes: {
          '/login': (context) => LoginForm(),
          '/signup': (context) => SignUpForm(),
        },
        home:  LoginForm(),
      );
  }
}