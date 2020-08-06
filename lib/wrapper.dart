import 'package:ehsfocus/main_app.dart';
import 'package:ehsfocus/screens/login/login_bloc/login_bloc.dart';
import 'package:ehsfocus/screens/login/login_bloc/login_state.dart';

import 'package:ehsfocus/screens/login/login_wrapper.dart';
import 'package:ehsfocus/services/animations/animation_wrapper.dart';

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
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginState) {}
            return state is LoginState && state.user != null
                ? AnimationWrapper(child: MainApp())
                : AnimationWrapper(child: LoginWraper());
          },
        ),
      ),
    );
  }
}
