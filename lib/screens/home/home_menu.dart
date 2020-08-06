import 'package:ehsfocus/screens/home/home_card.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget with Labels {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            HomeCard(
              icon: 58696,
              title: Labels.safty,
              acction: () {
                Navigator.pushNamed(context, RoutPath.safetyRout);
              },
            ),
            // HomeCard(
            //   icon: 58375,
            //   title: Lables.enviroment,
            //   acction: () {
            //     Navigator.pushNamed(context, RoutPath.enviromentRout);
            //   },
            // ),
            // HomeCard(
            //   icon: 59685,
            //   title: Lables.helth,
            //   acction: () {
            //     Navigator.pushNamed(context, RoutPath.helthRout);
            //   },
            // ),
            HomeCard(
              color: AppColors.fieldInFocus,
              icon: 58949,
              title: Labels.incident,
              acction: () {
                Navigator.pushNamed(context, RoutPath.incidentRout);
              },
            ),
          ],
        ),
      ),
    );
  }
}
