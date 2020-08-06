import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';

mixin FormElement implements StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextFormField(
          decoration: textInputDecoration.copyWith(
            labelText: 'Prenume',
          ),
          validator: (value) => value.isEmpty ? 'Enter First name' : null,
          onChanged: (value) {},
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: textInputDecoration.copyWith(labelText: 'Nume'),
          onChanged: (lastName) {},
        ),
      ],
    );
  }
}
