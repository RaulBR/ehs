import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/cupertino.dart';

class PageHelperService {
  String checkRoute(context) {
    Map<String, String> routPathList = CurrentPath().get();
    String route = ModalRoute.of(context).settings.name;
    return dinamicTitles[routPathList.keys
        .firstWhere((k) => routPathList[k] == route, orElse: () => null)];
      
  }
}
