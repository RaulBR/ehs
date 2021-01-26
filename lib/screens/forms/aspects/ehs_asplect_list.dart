import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';

class EhsAspectList extends StatelessWidget with Labels {
  final List<Aspect> aspects;
  final Function selected;
  EhsAspectList({this.aspects, this.selected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: aspects == null ? 0 : aspects.length,
      itemBuilder: (context, index) {
        return GennericListElement(
          simbol: aspects[index].status,
          title: aspects[index].equipment,
          subtitle: aspects[index].category,
          isSelected: () {
            selected(aspects[index]);
          },
        );
      },
    );
  }
}
