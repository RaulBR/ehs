import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';

class NavigationTile extends StatelessWidget {
  final String title;
  final String path;
  final Function action;
  const NavigationTile({Key key, this.title, this.path, this.action})
      : super(key: key);
  _nafigateTo(context, path) {
    if (path == RoutPath.homeRout) {
      Navigator.popUntil(context, ModalRoute.withName(RoutPath.homeRout));
      return;
    }
    Navigator.pop(context);
    Navigator.pushNamed(context, path);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        _nafigateTo(context, path);
        if (action != null) action();
      },
    );
  }
}
