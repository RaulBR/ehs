import 'package:bookyourdriveing/models/user.model.dart';
import 'package:bookyourdriveing/services/http.dart';
import 'package:bookyourdriveing/shared/constants.dart';
import 'package:bookyourdriveing/state/login_block.dart';
import 'package:bookyourdriveing/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _http = HttpService();
    LoginBloc login = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(actions: <Widget>[], title: Text('Sign up')),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Email',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Enter an email' : null,
                    onChanged: (value) {
                      _email = value;
                    }),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(labelText: 'Passwoard'),
                  validator: (value) => value.isEmpty ? 'Enter an email' : null,
                  onChanged: (value) {
                    _password = value;
                  },
                  obscureText: true,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: 'Confirm password'),
                  validator: (value) => value.isEmpty ? 'Enter an email' : null,
                  obscureText: true,
                ),
                TextFormField(
                  decoration:
                      textInputDecoration.copyWith(labelText: 'Phone numbare'),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                        User user = User(email:_email, password: _password);
                        login.onSignUp(user);
                    },
                    color: AppColors.primary,
                    child: Text('Signup',
                        style: TextStyle(color: AppColors.icons)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormData {}
