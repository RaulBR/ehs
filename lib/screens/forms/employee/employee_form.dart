import 'package:ehsfocus/models/employee_model.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class EmployeeForm extends StatefulWidget {
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Employee _employee = Employee();
    return Scaffold(
        appBar: AppBar(actions: <Widget>[], title: Text(Labels.myData)),
        body: Container(
          width: 800,
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
                        labelText: 'Prenume',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Enter First name' : null,
                      onChanged: (value) {
                        _employee.setFirstName = value;
                      }),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Nume'),
                    onChanged: (lastName) {
                      _employee.setLastName = lastName;
                    },
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Rol'),
                    // keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20.0),
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
                  Navigator.pop(context);
                },
                child: Text('cancel', style: TextStyle(color: AppColors.icons)),
              ),
            ],
          ),
        ));
  }

  void dispose() {
    print('dispose form');
    super.dispose();
  }
}
