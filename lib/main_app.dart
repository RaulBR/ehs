import 'package:bookyourdriveing/custom_routs.dart';
import 'package:bookyourdriveing/theme.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MaterialApp (
        title: 'Flutter Demo',
        theme: CompanyThemeData,
        onGenerateRoute: Router().generateRoute,
        initialRoute: '/' ,
      );
  }
}