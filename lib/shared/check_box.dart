import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:flutter/material.dart';

// class MyCheckBox extends StatefulWidget {
//   final String label;
//   final bool value;
//   final Function setValue;
//   MyCheckBox({this.value, @required this.setValue, this.label});

//   @override
//   _MyCheckBoxState createState() => _MyCheckBoxState(value);
// }

// class _MyCheckBoxState extends State<MyCheckBox> {
//   bool valueIn = false;

//   _MyCheckBoxState(valueIn);
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//       return Center(
//         child: CheckboxListTile(
//           title: Text(widget.label == null ? 'Do you agree?' : widget.label),
//           value: valueIn,
//           onChanged: (bool value) {
//             widget.setValue(value);
//             setState(() {
//               valueIn = value;
//             });
//           },
//           // secondary: const Icon(Icons.hourglass_empty),
//         ),
//       );
//     });
//   }
// }

class EhsCheckBox extends StatefulWidget {
  final bool spred;
  final String label;
  final bool isEditable;
  final bool value;
  final Function setValue;
  EhsCheckBox(
      {this.value,
      @required this.setValue,
      this.label,
      this.isEditable,
      this.spred});

  @override
  _EhsCheckBoxState createState() => _EhsCheckBoxState();
}

class _EhsCheckBoxState extends State<EhsCheckBox> {
  bool local;
  bool _spred;
  @override
  Widget build(BuildContext context) {
    _spred = widget.spred == null ? true : widget.spred;
    local = local == null ? widget.value : local;
    setLocal() {
      setState(() {
        local = !local;
      });
    }

    return InputContainer(
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          setLocal();
          widget.setValue(local);
        },
        child: Row(
          mainAxisAlignment: _spred
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            Text(widget.label),
            Checkbox(
              value: local,
              onChanged: (bool value) {
                if (widget.isEditable) {
                  setLocal();
                  widget.setValue(local);
                }
              },
              // secondary: const Icon(Icons.hourglass_empty),
            ),
          ],
        ),
      ),
    );
  }
}
