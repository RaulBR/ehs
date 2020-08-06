import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomGroupButtons extends StatelessWidget {
  final bool isBackHiden;
  final Function navigate;
  final Function submit;
  BottomGroupButtons({this.navigate, this.submit, this.isBackHiden});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                child: isBackHiden ? Text('') : Icon(Icons.chevron_left),
                onPressed: () => navigate(-1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              FlatButton(
                child: Text(Labels.back),
                onPressed: () => submit(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              FlatButton(
                child: Icon(Icons.chevron_right),
                onPressed: () => navigate(1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ],
          )),
    );
  }
}
