import 'package:bookyourdriveing/models/employee_model.dart';
import 'package:bookyourdriveing/theme.dart';
import 'package:flutter/material.dart';

class EmployeeListElement extends StatelessWidget {
  final Employee employee;
  final Function data;
  EmployeeListElement({this.employee, this.data});
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(3),
      child: Card(
        borderOnForeground: true,
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: () async {
           data();
          },
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.lightprimary,
          ),
          title: Text('${employee.id} ${employee.lastName.toString()}'),
          subtitle: Text(employee.phone.toString()),
        ),
      ),
    );
  }
  
}
