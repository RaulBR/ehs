import 'package:ehsfocus/shared/GoToButton.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OpenTextAreaWidget extends StatefulWidget {
  final String label;
  final Icon icon;
  final String text;
  final bool isEditable;
  final Function onEdit;
  OpenTextAreaWidget({
    @required this.onEdit,
    this.text,
    this.isEditable,
    this.label,
    this.icon,
  });

  @override
  _OpenTextAreaWidgetState createState() => _OpenTextAreaWidgetState();
}

class _OpenTextAreaWidgetState extends State<OpenTextAreaWidget> {
  String _text;
  @override
  Widget build(BuildContext context) {
    _text = _text == null ? widget.text : _text;
    return SafeArea(
      child: InputContainer(
        child: Column(
          children: [
            GoToButton(
              icon: widget.icon,
              label: widget.label,
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditableTextAreaWidget(
                        isEditable: widget.isEditable,
                        icon: widget.icon,
                        label: widget.label,
                        text: _text,
                        onEdit: (text) {
                          setState(() {
                            _text = text;
                          });
                          widget.onEdit(text);
                        },
                      ),
                    ))
              },
            ),
            Container(
                height: 40,
                padding: EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                child: SingleChildScrollView(
                    child: Text(_text == null ? '' : _text))),
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
  final isEditable;
  EditableTextAreaWidget(
      {this.text,
      @required this.onEdit,
      this.label,
      this.icon,
      this.isEditable});

  @override
  Widget build(BuildContext context) {
    final double screenSize = MediaQuery.of(context).size.height;
    final double keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    final myController = TextEditingController();
    var focusNode = FocusNode();
    myController.text = text;
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              // SingleChildScrollView(

              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(focusNode);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  color: AppColors.icons,
                  height: (screenSize * 0.72 - keyboardSize),
                  child: SingleChildScrollView(
                    child: TextField(
                      readOnly: isEditable == null ? false : !isEditable,
                      focusNode: focusNode,
                      controller: myController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
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
      ),
    );
  }
}
