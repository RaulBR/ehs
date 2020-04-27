import 'package:bookyourdriveing/custom_routs.dart';
import 'package:bookyourdriveing/state/employee_bloc/employee_bloc.dart';
import 'package:bookyourdriveing/state/employee_bloc/employee_list_bloc/employee_list_bloc.dart';
import 'package:bookyourdriveing/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => EmployeeBloc(),
        ),
        BlocProvider(
          create: (_) => EmployeeListBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'My app',
        theme: CompanyThemeData,
        onGenerateRoute: Router().generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
