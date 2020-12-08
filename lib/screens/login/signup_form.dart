import 'package:ehsfocus/models/user.model.dart';
import 'package:ehsfocus/screens/login/login_bloc/login.dart';
import 'package:ehsfocus/screens/login/login_bloc/login_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/clerable%20_text_field.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[], title: Text(Labels.signup)),
      body: Container(
        height: 500,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: SingleChildScrollView(
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
                      BlocProvider.of<LoginBloc>(context).onSetEmail(value);
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
                      BlocProvider.of<LoginBloc>(context).onSetPassWoard(value);
                    },
                  ),
                  EHSTextField(
                    inputValue:
                        state is UserFormState ? state.user.password2 : null,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Confirm ${Labels.passwoard}',
                    error: null,
                    onChanged: (value) {
                      BlocProvider.of<LoginBloc>(context)
                          .onSetSecondPassWoard(value);
                    },
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context).onSignUp();
                      },
                      child: Text(Labels.signup,
                          style: TextStyle(color: AppColors.icons)),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
