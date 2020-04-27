
import 'package:bookyourdriveing/state/login_bloc/login_bloc.dart';
import 'package:bookyourdriveing/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(BlocProvider(
      create: (_) => LoginBloc(),
      child:  AuthWrapper()
      )
      );
}