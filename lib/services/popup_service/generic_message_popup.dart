import 'package:ehsfocus/shared/comment.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/clerable%20_text_field.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class EhsGennericPopup {
  Future<bool> showPupup(context, {title, contentText, what, subtitle}) async {
    bool value = false;
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title ?? Labels.areYouShoure),
              content: Container(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(what),
                    Text(subtitle ?? ''),
                    Text(contentText ?? Labels.areYouShoureText),
                  ],
                ),
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    value = true;
                    Navigator.of(context).pop();
                  },
                  child: Text(Labels.ok),
                ),
                FlatButton(
                  onPressed: () {
                    value = false;
                    Navigator.of(context).pop();
                  },
                  child: Text(Labels.close),
                )
              ],
            ));

    return value;
  }

  void openCategoryModal(context,
      {Function add, String selected, String title}) async {
    String _localValoue = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title == null ? Labels.addCategory : title),
          content: Container(
            height: 200,
            child: Column(
              children: [
                ClearableTextField(
                  enabled: true,
                  inputValue: selected,
                  label: title == null ? Labels.category : title,
                  onChanged: (data) {
                    _localValoue = data;
                  },
                  error: '',
                ),
                // Switch(
                //   value: false,
                //   onChanged: (value) {},
                // ),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text(Labels.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(Labels.addAnother),
              onPressed: () {
                add(_localValoue);
              },
            ),
            FlatButton(
              child: Text(Labels.add),
              onPressed: () {
                add(_localValoue);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> showCommentPupup(context,
      {title, contentText, what, subtitle}) async {
    final myController = TextEditingController();
    var focusNode = FocusNode();

    String value = '';
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title ?? Labels.areYouShoure),
              content: Container(
                height: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(what),
                    Container(
                      child: TextField(
                        focusNode: focusNode,
                        controller: myController,
                        onChanged: (data) {
                          value = data;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                        ),
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(Labels.ok),
                ),
                FlatButton(
                  onPressed: () {
                    value = '';
                    Navigator.of(context).pop();
                  },
                  child: Text(Labels.close),
                )
              ],
            ));

    return value;
  }
}
