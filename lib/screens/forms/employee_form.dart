import 'package:ehsfocus/models/employee_model.dart';
import 'package:ehsfocus/shared/check_box.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/datepiker.dart';
import 'package:ehsfocus/state/employee_bloc/employee_bloc.dart';
import 'package:ehsfocus/state/employee_bloc/employee_bloc_index.dart';
import 'package:ehsfocus/theme.dart';
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
    return Scaffold(
        appBar: AppBar(actions: <Widget>[], title: Text('Add employee')),
        body: Container(
          width: 400,
          margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                         keyboardType: TextInputType.number,
                  ),
                  DatePiker(
                      color: AppColors.icons,
                      inputDate: 'data',
                      label: 'Date piker',
                      getDate: (data) {
                        print(data.toString());
                        _dateTime = data;
                      }),
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
                  BlocProvider.of<EmployeeBloc>(context)
                      .setEmployee(employee: _employee);
                      Navigator.pop(context);
                },
                child:
                    Text('register', style: TextStyle(color: AppColors.icons)),
              ),
              RaisedButton(
                elevation: 0,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel', style: TextStyle(color: AppColors.icons)),
              ),
            ],
          ),
        )
        
        );
  }

  void dispose() {
    print('dispose form');
    super.dispose();
  }
}
