import 'package:ehsfocus/Initiate_app_service.dart';
import 'package:ehsfocus/main_app.dart';
import 'package:ehsfocus/bloc/login/login_bloc.dart';
import 'package:ehsfocus/bloc/login/login_state.dart';
import 'package:ehsfocus/screens/login/login_wrapper.dart';
import 'package:ehsfocus/shared/animations/animation_wrapper.dart';
import 'package:ehsfocus/shared/loading.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  InitAppService _initAppService = InitAppService();
  bool _isDataLoaded = false;
  @override
  void initState() {
    _initAppService.isAppInitiated().then((value) {
      setState(() {
        _isDataLoaded = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _initAppService.closeRepo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_isDataLoaded
        ? MaterialApp(home: Loading())
        : Container(
            color: AppColors.accent,
            child: BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    MaterialApp(home: Loading());
                  }
                  if (state is LoginError) {
                    return AnimationWrapper(child: LoginWraper());
                  }
                  return state is AuthorizedState && state.user != null
                      ? AnimationWrapper(child: MainApp())
                      : AnimationWrapper(child: LoginWraper());
                },
              ),
            ),
          );
  }
}
