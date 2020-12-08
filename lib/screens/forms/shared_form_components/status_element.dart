import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final String status;

  const StatusWidget({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int icon = 0xe7b6;
    Color color = AppColors.accent;

    switch (status) {
      case 'A':
        icon = 0xe6cf;
        break;
      case 'S':
        icon = 0xe318;
        color = AppColors.darkprimary;
        break;
      case 'B':
        icon = 0xe341;
        color = AppColors.darkprimary;
        break;
      case 'P':
        icon = 0xe341;
        color = AppColors.pending;
        break;
      case 'D':
        icon = 0xe10c;
        color = AppColors.darkprimary;
        break;
      case 'R':
        icon = 0xf3e4;
        color = AppColors.fieldInFocus;
        break;
      default:
    }
    return CircleAvatar(
      radius: 25,
      backgroundColor: AppColors.icons,
      child: Icon(
        IconData(icon, fontFamily: 'MaterialIcons'),
        color: color,
      ),
    );
  }
}

class StatusTextWidget extends StatelessWidget {
  final String status;

  const StatusTextWidget({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String text = '';
    Color color = AppColors.accent;

    switch (status) {
      case 'A':
        text = 'Acceptat';
        break;
      case 'S':
        text = 'Ne procesat';
        color = AppColors.darkprimary;
        break;
      case 'B':
        text = 'Trimis';
        color = AppColors.darkprimary;
        break;
      case 'P':
        text = 'In proces de aprobare';
        color = AppColors.pending;
        break;
      case 'D':
        text = 'Duplicat (Acceptat)';
        color = AppColors.darkprimary;
        break;
      case 'R':
        text = 'Rejectat';
        color = AppColors.fieldInFocus;
        break;
      default:
    }
    return Text(
      text,
      style: TextStyle(color: color),
    );
  }
}
