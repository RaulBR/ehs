import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/clerable%20_text_field.dart';
import 'package:flutter/material.dart';

class CategoryPopup extends StatefulWidget {
  final Function add;
  final String selected;
  final String title;

  const CategoryPopup({Key key, this.add, this.selected, this.title})
      : super(key: key);
  @override
  _CategoryPopupState createState() => _CategoryPopupState();
}

class _CategoryPopupState extends State<CategoryPopup> {
  String _localValoue;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title == null ? Labels.addCategory : widget.title),
      content: Container(
        height: 200,
        child: ClearableTextField(
          enabled: true,
          inputValue: widget.selected,
          label: widget.title == null ? Labels.category : widget.title,
          onChanged: (data) {
            _localValoue = data;
          },
          error: null,
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        TextButton(
          child: Text(Labels.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(Labels.addAnother),
          onPressed: () {
            widget.add(_localValoue);
            setState(() {
              _localValoue = '';
            });
          },
        ),
        TextButton(
          child: Text(Labels.add),
          onPressed: () {
            widget.add(_localValoue);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
