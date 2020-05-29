import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';

class EhsAspectList extends StatelessWidget with Lables {
  final List<Aspect> aspects;
  final Function selected;
  EhsAspectList({this.aspects,  this.selected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: aspects != null ? aspects.length.toDouble() * 83 : 0,
          child: ListView.builder(
              itemCount: aspects == null ? 0 : aspects.length,
              itemBuilder: (context, index) {
                return GennericListElement(title: aspects[index].category, file: aspects[index].photo, isSelected: () {
                  selected(aspects[index]);
                },);
              }),
        ),

      ],
    );
  }
}
