import 'package:ehsfocus/models/user.model.dart';
import 'package:ehsfocus/screens/login/login_bloc/login_bloc.dart';
import 'package:ehsfocus/screens/login/login_bloc/login_state.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/clerable%20_text_field.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:ehsfocus/shared/loading.dart';

import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _email;
    String _password;
    String error;
    return Scaffold(
      appBar: AppBar(actions: <Widget>[], title: Text(Labels.signIn)),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SingleChildScrollView(
          child: FormContainer(
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    EHSTextField(
                      inputValue:
                          state is UserFormState ? state.user.email : null,
                      keyboardType: TextInputType.emailAddress,
                      label: Labels.email,
                      error: state is UserLoginError ? state.error.email : null,
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    EHSTextField(
                      inputValue:
                          state is UserFormState ? state.user.password : null,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      label: Labels.passwoard,
                      error:
                          state is UserLoginError ? state.error.password : null,
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(
                      height: 40,
                      child: error != null ? Text(error) : Text(''),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          User user = User(email: _email, password: _password);
                          BlocProvider.of<LoginBloc>(context).onLogIn(user);
                        },
                        // color: AppColors.primary,
                        child: state is LoadingState
                            ? LoadingSimbol(
                                size: 10,
                              )
                            : Text(
                                Labels.signIn,
                                style: TextStyle(color: AppColors.icons),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        // color: AppColors.primary,
                        child: Text(
                          Labels.signup,
                          style: TextStyle(color: AppColors.icons),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
