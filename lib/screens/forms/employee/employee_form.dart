import 'package:ehsfocus/models/employee_model.dart';
import 'package:ehsfocus/screens/forms/employee/bloc/employee_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/clerable%20_text_field.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_list_page_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeForm extends StatefulWidget {
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  @override
  Widget build(BuildContext context) {
    Employee _employee = Employee();
    return PageWrapper(
      child: SingleChildScrollView(
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeValueState) {
              _employee = state.employee;
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                EHSTextField(
                  keyboardType: TextInputType.name,
                  label: Labels.name,
                  inputValue: _employee.firstName,
                  onChanged: (value) {
                    _employee.firstName = value;
                  },
                  error: null,
                ),
                SizedBox(height: 20.0),
                EHSTextField(
                  keyboardType: TextInputType.name,
                  label: Labels.surName,
                  inputValue: _employee.lastName,
                  onChanged: (value) {
                    _employee.lastName = value;
                  },
                  error: null,
                ),
                SizedBox(height: 20.0),
                EHSTextField(
                  label: Labels.role,
                  inputValue: _employee.role,
                  onChanged: (value) {
                    _employee.role = value;
                  },
                  error: null,
                ),
                SizedBox(height: 20.0),
                EHSTextField(
                  // enabled: isEditable,
                  keyboardType: TextInputType.emailAddress,
                  label: Labels.email,
                  inputValue: _employee.email,
                  onChanged: (value) {
                    _employee.email = value;
                  },
                  error: null,
                ),
              ],
            );
          },
        ),
      ),
      footerAction: (data) {
        if (data == FooterStates.save) {
          BlocProvider.of<EmployeeBloc>(context).setEmployee(_employee);
        }
      },
    );
  }

  void dispose() {
    print('dispose form');
    super.dispose();
  }
}
