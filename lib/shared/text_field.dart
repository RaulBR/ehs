import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_container.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextAreaWidget extends StatelessWidget {
  final String text;
  final bool notEditable;
  final Function onEdit;
  TextAreaWidget({
    @required this.onEdit,
    this.text,
    this.notEditable,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InputContainer(
        child: Column(
          children: [
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () => onEdit(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TODO add to labels
                  Text(text == null ? Lables.addComment : Lables.comment),
                  Icon(Icons.message)
                ],
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              child:
                  SingleChildScrollView(child: Text(text == null ? '' : text)),
            ),
          ],
        ),
      ),
    );
  }
}

class EditableTextAreaWidget extends StatelessWidget {
  final String text;
  final Function onEdit;

  EditableTextAreaWidget({this.text, @required this.onEdit});

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
                  icon: Icon(Icons.message),
                  label: Text('Adauga Comentariu')),
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
                    decoration: textInputDecoration,
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
