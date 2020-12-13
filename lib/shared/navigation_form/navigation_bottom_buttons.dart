import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomGroupButtons extends StatelessWidget {
  final bool isLast;
  final bool isFirst;
  final Function navigate;
  final Function submit;
  BottomGroupButtons({this.navigate, this.submit, this.isFirst, this.isLast});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                child: isFirst
                    ? Text('')
                    : Row(
                        children: [
                          Icon(Icons.chevron_left),
                          isFirst ? Text('') : Text('inapoi'),
                        ],
                      ),
                onPressed: isFirst ? null : () => navigate(-1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              // FlatButton(
              //   child: Text(Labels.back),
              //   onPressed: () => submit(),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(30.0),
              //   ),
              // ),
              FlatButton(
                child: Row(
                  children: [
                    isLast ? Text('inchide') : Text('urmatorul'),
                    isLast ? Text('') : Icon(Icons.chevron_right),
                  ],
                ),
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
