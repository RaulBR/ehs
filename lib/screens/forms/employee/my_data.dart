import 'package:ehsfocus/bloc/employee/employee_bloc.dart';
import 'package:ehsfocus/screens/forms/employee/employee_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // load my data
    BlocProvider.of<EmployeeBloc>(context).getMyself();
    return Scaffold(
        appBar: AppBar(
          title: Text('Datele mele'),
        ),
        body: EmployeeForm());
  }
}
