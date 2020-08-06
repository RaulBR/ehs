import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:flutter/material.dart';

class GoToButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final Icon icon;
  const GoToButton({Key key, this.onPressed, this.label, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 12),
      child: FlatButton(
        padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputContainer(child: Text(label, style: normallabelFomat)),
            icon == null ? Icon(Icons.message) : icon,
          ],
        ),
      ),
    );
  }
}
