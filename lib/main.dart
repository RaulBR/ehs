import 'package:bookyourdriveing/state/login_block.dart';
import 'package:bookyourdriveing/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  final login = LoginBloc();
  runApp(BlocProvider(
      create: (_) => login,
      child:  AuthWrapper()
      )
      );
}