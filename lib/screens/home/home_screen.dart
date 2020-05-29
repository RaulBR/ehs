import 'package:ehsfocus/screens/forms/employee_list.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';


class Safety extends StatelessWidget with Lables {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: Text(Lables.safty)),
      // drawer: SideMenu(),
      body: EmployeeList(),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.darkprimary,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, '/employee');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}