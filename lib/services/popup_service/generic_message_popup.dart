import 'package:ehsfocus/shared/constants.dart';
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
}
