import 'package:flutter/material.dart';
import 'package:ehsfocus/shared/constants.dart';
class FormContainer extends StatelessWidget {
  final Widget child;
  FormContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return  Center(
              child: Container(
                child: child,
                width: 400,
              )
    );
  }
}


class InputContainer extends StatelessWidget {
  final Widget child;
  InputContainer({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: labelPadding,
      child: child,
    );
  }
}