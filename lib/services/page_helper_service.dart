import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/cupertino.dart';

class PageHelperService {
  final dynamic context;
  String route;
  final CurrentPath currentpath = CurrentPath();
  PageHelperService({this.context}) {
    route = ModalRoute.of(context).settings.name;

  }

  String checkRoute() {
    Map<String, String> routPathList =currentpath.get();
    return dinamicTitles[routPathList.keys
        .firstWhere((k) => routPathList[k] == route, orElse: () => null)];
      
  }
    String getType() {
    Map<String, String> routPathList =currentpath.get();
    return routPathList.keys
        .firstWhere((k) => routPathList[k] == route, orElse: () => null);
      
  }
}
