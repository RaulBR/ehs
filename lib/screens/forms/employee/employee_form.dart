import 'package:ehsfocus/models/employee/employee_model.dart';
import 'package:ehsfocus/bloc/employee/employee_bloc.dart';
import 'package:ehsfocus/models/form_metadata.dart/form_footer_model.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/clerable%20_text_field.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_page_wraper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeForm extends StatelessWidget {
  final bool isAdd;

  const EmployeeForm({Key key, this.isAdd}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Employee _employee = Employee();
    bool _isAdd = isAdd == null ? false : isAdd;
    return PageWrapper(
      child: BlocListener<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is Sucsess && !_isAdd) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeValueState) {
              _employee = state.employee;
            }
            return Container(
              height: 540,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    enabled: _isAdd,
                    keyboardType: TextInputType.emailAddress,
                    label: Labels.email,
                    inputValue: _employee.email,
                    onChanged: (value) {
                      _employee.email = value;
                    },
                    error: null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      footerActions: [
        FormFooterModel(Labels.delete),
        FormFooterModel(Labels.save)
      ],
      footerAction: (data) {
        if (data == Labels.save) {
          BlocProvider.of<EmployeeBloc>(context).setEmployee(_employee);
        }
      },
    );
  }
}
