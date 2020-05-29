import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final int icon;
  final String title;
  final Function acction;
  final Color color;
  HomeCard({this.icon, this.title, this.acction ,this.color});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 150,
      child: Card(
        color: color == null ?  AppColors.primary : color,
        child: FlatButton(
          onPressed: () {
            acction();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Center(
                  child: Icon(
                   IconData(icon != null ? icon : 59645, fontFamily: 'MaterialIcons'),
                size: 40,
                color: AppColors.icons,
              )),
              Text(
                title == null ? 'Title' : title,
                style: TextStyle(color: AppColors.icons),
              )
            ],
          ),
        ),
      ),
    );
  }
}
