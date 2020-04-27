import 'package:bookyourdriveing/models/user.model.dart';
import 'package:bookyourdriveing/shared/constants.dart';
import 'package:bookyourdriveing/shared/loading.dart';
import 'package:bookyourdriveing/state/login_bloc/login.dart';
import 'package:bookyourdriveing/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  // final Function setLogin;
  // LoginForm(this.setLogin);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email;
  String _password;
LoginBloc _login;
  void initState() {
    super.initState();
      _login = BlocProvider.of<LoginBloc>(context);
    // _login.amILogendIn();
  }

  void dispose() {
    print('dispose login');
    _login.close();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

     return Scaffold(
        appBar: AppBar(actions: <Widget>[], title: Text('Sign in')),
        body: Container(
            height: 300,
            margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    onChanged: (value) => {_email = value},
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Passward'),
                    obscureText: true,
                    onChanged: (value) => {_password = value},
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        User user = User(email: _email, password: _password);
                        _login.onLogIn(user);
                      },
                      color: AppColors.primary,
                      child: Text('Login',
                              style: TextStyle(color: AppColors.icons)),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      color: AppColors.primary,
                      child: Text('sign up',
                          style: TextStyle(color: AppColors.icons)),
                    ),
                  ),
                ],
              ),
            )));
  }
}
