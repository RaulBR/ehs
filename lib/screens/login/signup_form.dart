import 'package:ehsfocus/models/user.model.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_container.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ehsfocus/state/login_bloc/login.dart';

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
    return Scaffold(
      appBar: AppBar(actions: <Widget>[], title: Text('Sign up')),
      body: Container(
         height: 500,
        margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: FormContainer(
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
                        User user = User(email: _email, password: _password);
                        BlocProvider.of<LoginBloc>(context).onSignUp(user);
                      },
                      child: Text('Signup',
                          style: TextStyle(color: AppColors.icons)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

