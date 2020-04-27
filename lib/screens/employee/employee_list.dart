import 'dart:async';
import 'package:bookyourdriveing/models/employee_model.dart';
import 'package:bookyourdriveing/screens/employee/employee_element.dart';
import 'package:bookyourdriveing/state/employee_bloc/employee_bloc_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeList extends StatefulWidget {
  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<Employee> pageItems = [];
  void initState() {
    super.initState();
    BlocProvider.of<EmployeeListBloc>(context).getEmployes();
  }

  @override
  Widget build(BuildContext context) {
    data() {
      print('tapp');
    }

    return BlocBuilder<EmployeeListBloc, EmployeeListState>(
        builder: (context, state) {
      return ListView.builder(
          itemCount:  state.employees == null ? 0 : state.employees.length,
          itemBuilder: (context, index) {
            return EmployeeListElement(
                employee: state.employees[index], data: data);
          });
    });
  }
}
