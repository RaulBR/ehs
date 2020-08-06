import 'package:ehsfocus/shared/GoToButton.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OpenTextAreaWidget extends StatelessWidget {
  final String label;
  final Icon icon;
  final String text;
  final bool notEditable;
  final Function onEdit;
  OpenTextAreaWidget({
    @required this.onEdit,
    this.text,
    this.notEditable,
    this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InputContainer(
        child: Column(
          children: [
            GoToButton(
              icon: icon,
              label: label,
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditableTextAreaWidget(
                        icon: icon,
                        label: label,
                        text: text,
                        onEdit: (text) {
                          onEdit(text);
                        },
                      ),
                    ))
              },
            ),
            Container(
                height: 100,
                padding: EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                child: SingleChildScrollView(
                    child: Text(text == null ? '' : text))),
          ],
        ),
      ),
    );
  }
}

class EditableTextAreaWidget extends StatelessWidget {
  final String text;
  final Function onEdit;
  final String label;
  final Icon icon;

  EditableTextAreaWidget(
      {this.text, @required this.onEdit, this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    var focusNode = new FocusNode();
    final double screenSize = MediaQuery.of(context).size.height;
    final double keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    final myController = TextEditingController();
    myController.text = text;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              FlatButton.icon(
                  onPressed: () => onEdit(myController.text),
                  icon: icon == null ? Icon(Icons.message) : icon,
                  label: Text(label, style: normallabelFomat)),
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Icon(Icons.close))
            ]),
            // SingleChildScrollView(

            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(focusNode);
              },
              child: Container(
                color: AppColors.icons,
                height: (screenSize * 0.7 - keyboardSize),
                child: SingleChildScrollView(
                  child: TextField(
                    focusNode: focusNode,
                    controller: myController,
                    // decoration: textAreaStyle,
                    maxLines: null,
                  ),
                ),
              ),
            ),

            // ),
            FlatButton(
                onPressed: () {
                  onEdit(myController.text);
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  Navigator.pop(context);
                },
                child: Icon(Icons.check))
          ],
        ),
      ),
    );
  }
}
