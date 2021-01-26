import 'package:ehsfocus/screens/home/home_card.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Center(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            HomeCard(
              icon: 59639,
              title: Labels.employees,
              acction: () {
                Navigator.pushNamed(context, RoutPath.employeeRout);
              },
            ),
            HomeCard(
              color: AppColors.fieldInFocus,
              icon: 58949,
              title: Labels.category,
              acction: () {
                Navigator.pushNamed(context, RoutPath.categoryRoute);
              },
            ),
            HomeCard(
              icon: 57636,
              title: Labels.area,
              acction: () {
                Navigator.pushNamed(context, RoutPath.areaRoute);
              },
            ),
            HomeCard(
              icon: 57725,
              title: Labels.managerMantanence,
              acction: () {
                Navigator.pushNamed(context, RoutPath.myManaagers);
              },
            ),
          ],
        ),
      ),
    );
  }
}
