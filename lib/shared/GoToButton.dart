import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
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
      // padding: EdgeInsets.only(right: 12),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.only(left: 8, right: 13),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: normallabelFomat,
            ),
            icon == null
                ? Icon(
                    Icons.message,
                    color: AppColors.textSecundart,
                  )
                : icon,
          ],
        ),
      ),
    );
  }
}
