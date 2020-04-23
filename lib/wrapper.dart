import 'package:bookyourdriveing/main_app.dart';

import 'package:bookyourdriveing/screens/login/login_wrapper.dart';
import 'package:bookyourdriveing/state/login_block.dart';
import 'package:bookyourdriveing/state/login_state.dart';
import 'package:bookyourdriveing/theme.dart';
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
              listener: (BuildContext context, LoginState state) =>
                  {print(' is login ${state.isLogin}')},
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) => state.isLogin
                    ? AnimationWrapper(wrappWidget: MainApp())
                    : AnimationWrapper(wrappWidget: LoginWraper()),
              ))),
    );
  }
}

class AnimationWrapper extends StatelessWidget {
  final Widget wrappWidget;
  AnimationWrapper({this.wrappWidget});
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          // return FadeTransition(opacity:Tween(begin:0.0, end: 1.0).animate(animation) ,
          return SlideTransition(
              position:
                  Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset(0.0, 0.0))
                      .animate(animation),
              child: child);
        },
        child: wrappWidget);
  }
  //SizeTransition( axis: Axis.horizontal, sizeFactor: Tween(begin:0.0, end: 2.0).animate(animation),
  // SlideTransition(position: Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset(0.0, 0.0)).animate(animation),
}
