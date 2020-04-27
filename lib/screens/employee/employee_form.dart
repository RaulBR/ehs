import 'package:bookyourdriveing/models/employee_model.dart';
import 'package:bookyourdriveing/shared/check_box.dart';
import 'package:bookyourdriveing/shared/constants.dart';
import 'package:bookyourdriveing/state/employee_bloc/employee_bloc.dart';
import 'package:bookyourdriveing/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeForm extends StatefulWidget {
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    Employee _employee = Employee();

    final EmployeeBloc employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    return Scaffold(
        appBar: AppBar(actions: <Widget>[], title: Text('Add employee')),
        body: Container(
          margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextFormField(
                      decoration: textInputDecoration.copyWith(
                        labelText: 'First name',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Enter First name' : null,
                      onChanged: (value) {
                        _employee.setFirstName = value;
                      }),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(labelText: 'Last Name'),
                    onChanged: (lastName) {
                      _employee.setLastName = lastName;
                    },
                  ),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(labelText: 'Email'),
                    onChanged: (email) {
                      _employee.setEmail = email;
                    },
                  ),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(labelText: 'Company'),
                    onChanged: (value) {
                      _employee.setCompany = value;
                    },
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        labelText: 'Phone numbare'),
                  ),
                  RaisedButton.icon(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2222))
                            .then((date) => {
                                  setState(() => {
                                        _dateTime = date,
                                      })
                                });
                      },
                      icon: Icon(Icons.calendar_today),
                      label: Text(_dateTime != null
                          ? _dateTime.toString()
                          : 'BirthDay')),
                  SizedBox(height: 20.0),
                  MyCheckBox(
                      value: false,
                      setValue: (value) {
                        _employee.setChecked = value;
                      })
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: AppColors.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                elevation: 0,
                onPressed: () {
                  _employee.setBirthday = _dateTime.toString();
                  employeeBloc.setEmployee(employee: _employee);
                },
                color: AppColors.primary,
                child:
                    Text('register', style: TextStyle(color: AppColors.icons)),
              ),
              RaisedButton(
                elevation: 0,
                onPressed: () {
                  Navigator.pop(context);
                },
                color: AppColors.primary,
                child: Text('cancel', style: TextStyle(color: AppColors.icons)),
              ),
            ],
          ),
        ));
  }
}
