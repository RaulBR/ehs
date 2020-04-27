import 'package:bookyourdriveing/main_app.dart';

import 'package:bookyourdriveing/screens/login/login_wrapper.dart';
import 'package:bookyourdriveing/shared/animation_wrapper.dart';
import 'package:bookyourdriveing/state/login_bloc/login_bloc.dart';
import 'package:bookyourdriveing/state/login_bloc/login_state.dart';

import 'package:bookyourdriveing/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.accent,
      child: BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(),
          child: BlocListener<LoginBloc, LoginState>(
              listener: (BuildContext context, LoginState state) =>
                  {print(' is login ${state.user.toJson()}')},
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) => state.user != null ?
                      AnimationWrapper(wrappWidget: MainApp()) : 
                      AnimationWrapper(wrappWidget: LoginWraper()),
              ))),
    );
  }
}