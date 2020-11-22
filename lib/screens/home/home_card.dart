import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final bool expanded;
  final int icon;
  final String title;
  final Function acction;
  final Color color;
  HomeCard({this.icon, this.title, this.acction, this.color, this.expanded});
  @override
  Widget build(BuildContext context) {
    bool _exp = expanded ?? false;
    return SizedBox(
        height: _exp ? 90 : 120,
        width: _exp ? 308 : 150,
        child: CardElement(
          icon: icon,
          title: title,
          acction: acction,
          color: color,
        ));
  }
}

class CardElement extends StatelessWidget {
  final int icon;
  final String title;
  final Function acction;
  final Color color;

  const CardElement({Key key, this.icon, this.title, this.acction, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color == null ? AppColors.primary : color,
      child: FlatButton(
        onPressed: () {
          acction();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
                child: Icon(
              IconData(icon != null ? icon : 59645,
                  fontFamily: 'MaterialIcons'),
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
    );
  }
}
