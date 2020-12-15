import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class FormFooter extends StatelessWidget {
  final Function action;
  final bool isEditable;
  final List<String> actions;
  const FormFooter({Key key, this.action, this.actions, this.isEditable})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> getGeneratedList() {
      return actions
          .map((element) => FlatRoundedButton(
                lable: element,
                onPressed: () {
                  action(element);
                },
              ))
          .toList();
    }

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions == null ? [] : getGeneratedList(),
      ),
    );
  }
}

class FlatRoundedButton extends StatelessWidget {
  final bool isEditable;
  final String lable;
  final Function onPressed;

  const FlatRoundedButton(
      {Key key, this.onPressed, this.lable, this.isEditable})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _isEditable = isEditable == null ? true : isEditable;
    return FlatButton(
      child: Text(
        lable,
        style: TextStyle(
          color: AppColors.icons,
        ),
      ),
      onPressed: !_isEditable
          ? null
          : () {
              onPressed();
            },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    );
  }
}
