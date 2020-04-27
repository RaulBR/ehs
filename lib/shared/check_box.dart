import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  bool value = false;
  Function setValue;
  MyCheckBox({this.value, @required this.setValue});
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState(value);
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool valueIn = false;

  _MyCheckBoxState(valueIn);
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Center(
        child: CheckboxListTile(
          title: const Text('Animate Slowly'),
          value: valueIn,
          onChanged: (bool value) {
            widget.setValue(value);
            setState(() {
              valueIn = value;
            });
          },
          secondary: const Icon(Icons.hourglass_empty),
        ),
      );
    });
  }
}
