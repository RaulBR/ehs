import 'package:ehsfocus/models/employee_model.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';
import 'package:flutter/material.dart';

class EmployeeListElement extends StatelessWidget {
  final Employee employee;
  final Function data;
  EmployeeListElement({this.employee, this.data});
  @override
  Widget build(BuildContext context) {
    String getName() {
      String firstName = employee.firstName == null ? '' : employee.firstName;
      String lastName = employee.lastName == null ? '' : employee.lastName;
      return '$firstName $lastName';
    }

    String getDate() {
      return employee.createdDate.split('T')[0];
    }

    return GennericListElement(
      title: getName(),
      subtitle: getDate(),
      isSelected:() {
        data(employee);
      },
    );
  }
}
