import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AspectWrapperServie {
  List<Widget> generateButtons(
      {List<String> buttons, bool isEnabled, Function hasChanges}) {
    List<String> _buttons = buttons ?? [];
    if (buttons == null) {
      _buttons.add(Labels.addAnother);
      _buttons.add(Labels.add);
    }
    return [
      TextButton(
        child: Text(_buttons[0]),
        onPressed: !isEnabled || _buttons[0] == ''
            ? null
            : () {
                hasChanges(_buttons[0]);
              },
      ),
      TextButton(
        onPressed: !isEnabled || _buttons[1] == ''
            ? null
            : () {
                hasChanges(_buttons[1]);
              },
        child: Text(_buttons[1]),
      ),
      TextButton(
        onPressed: () {
          hasChanges(Labels.back);
        },
        child: Text(Labels.back),
      )
    ];
  }
}
