import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  final String label;
  final bool value;
  final Function setValue;
  MyCheckBox({this.value, @required this.setValue, this.label});

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
          title: Text(widget.label == null ? 'Do you agree?' : widget.label),
          value: valueIn,
          onChanged: (bool value) {
            widget.setValue(value);
            setState(() {
              valueIn = value;
            });
          },
          // secondary: const Icon(Icons.hourglass_empty),
        ),
      );
    });
  }
}

class EhsCheckBox extends StatelessWidget {
  final String label;
  final bool isEditable;
  final bool value;
  final Function setValue;
  EhsCheckBox(
      {this.value, @required this.setValue, this.label, this.isEditable});
  @override
  Widget build(BuildContext context) {
    // return CheckboxListTile(

    //   title: Text(label),
    //   onChanged: (bool value) {

    //    setValue(value);
    //  },
    //   value: value,
    //  );

    return InputContainer(
      child: Center(
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            setValue(!value);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Checkbox(
                value: value,
                onChanged: (bool value) {
                  if (isEditable) {
                    setValue(value);
                  }
                },
                // secondary: const Icon(Icons.hourglass_empty),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
