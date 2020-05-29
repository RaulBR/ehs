import 'dart:io';

import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class GennericListElement extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function isSelected;
  final File file;
  GennericListElement({this.title, this.subtitle, this.isSelected, this.file});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Card(
        borderOnForeground: false,
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          onTap: () async {
            isSelected();
          },
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.lightprimary,
            child: file != null
                ? Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill, image: FileImage(file))))
                : Text('P'),
          ),
          title: Text(title == null ? 'no data' : title),
          subtitle: Text(subtitle == null ? '' : subtitle),
          // trailing: FlatButton(
          //   shape: new CircleBorder(),
          //   child: Icon(Icons.close),
          //   onPressed: () {
          //     isSelected();
          //   },
          // ),
        ),
      ),
    );
  }
}
