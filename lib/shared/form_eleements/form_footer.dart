import 'package:ehsfocus/models/form_metadata.dart/form_footer_model.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class FormFooter extends StatelessWidget {
  final Function action;
  final bool isEditable;
  final List<FormFooterModel> actions;
  const FormFooter({Key key, this.action, this.actions, this.isEditable})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> getGeneratedList() {
      return actions
          .map((element) => FlatRoundedButton(
                isEditable: element.editable == null ? true : element.editable,
                lable: element.lable,
                onPressed: () {
                  action(element.lable);
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
          color: _isEditable ? AppColors.icons : AppColors.lightprimary,
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
