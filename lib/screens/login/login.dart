import 'package:ehsfocus/models/user.model.dart';
import 'package:ehsfocus/services/loacal_storage.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_container.dart';
import 'package:ehsfocus/shared/loading.dart';
import 'package:ehsfocus/state/login_bloc/login.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _email;
  String _password;
  bool isLoading = true;
  LoginBloc _login;
  LocalStorageService localStorageService = LocalStorageService();
  String error;
  void initState() {
    super.initState();
    _login = BlocProvider.of<LoginBloc>(context);
    if (localStorageService.getToken() != null) {
      _login.amILogendIn();
    }
    _login.listen((data) {
      if (data is LoginError) {
        error = 'troble signing in';
      }
    });
  }

  void dispose() {
    print('dispose login');
    // _login.close();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, LoginState state) => state
              is AppLoadingState
          ? Loading()
          : Scaffold(
              appBar: AppBar(actions: <Widget>[], title: Text('Sign in')),
              body: Container(
                  height: 300,
                  margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: FormContainer(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            onChanged: (value) => {_email = value},
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Passward'),
                            obscureText: true,
                            onChanged: (value) => {_password = value},
                          ),
                          SizedBox(
                              height: 40,
                              child: error != null ? Text(error) : Text('')),
                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () {
                                User user =
                                    User(email: _email, password: _password);
                                _login.onLogIn(user);
                              },
                              // color: AppColors.primary,
                              child: BlocBuilder<LoginBloc, LoginState>(
                                builder: (BuildContext context, state) {
                                  return state is LoadingState
                                      ? LoadingSimbol(
                                          size: 10,
                                        )
                                      : Text('Login',
                                          style: TextStyle(
                                              color: AppColors.icons));
                                },
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
                              child: Text('Sign Up',
                                  style: TextStyle(color: AppColors.icons)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))),
    );
  }
}
