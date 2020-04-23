import 'dart:async';
import 'package:bookyourdriveing/models/home_mode.dart';
import 'package:bookyourdriveing/theme.dart';
import 'package:flutter/material.dart';

class TitleMenuElement extends StatelessWidget {
  final HomeElement homeElement;
  final Function data;
  TitleMenuElement({this.homeElement, this.data});
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
          title: Text(homeElement.title),
          subtitle: Text(homeElement.subtitle),
        ),
      ),
    );
  }
  
}
