import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class NavigateToNextPage extends StatelessWidget {
  final String label;
  final Function onPressed;

  const NavigateToNextPage({Key key, this.onPressed, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: FlatButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          'Adauga Actiune corectiva',
          style: TextStyle(color: AppColors.fieldInFocus),
        ),
      ),
    );
  }
}
