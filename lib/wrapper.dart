import 'package:ehsfocus/main_app.dart';

import 'package:ehsfocus/screens/login/login_wrapper.dart';
import 'package:ehsfocus/shared/animation_wrapper.dart';

import 'package:ehsfocus/state/login_bloc/login_bloc.dart';
import 'package:ehsfocus/state/login_bloc/login_state.dart';

import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.accent,
      child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
          child: BlocListener<LoginBloc, LoginState>(
              listener: (BuildContext context, LoginState state) => {},
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return state is LoginState
                      ? AnimationWrapper(child: MainApp())
                      : AnimationWrapper(child: LoginWraper());
                },
              ))),
    );
  }
}
