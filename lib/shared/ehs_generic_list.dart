import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';

class EhsGenericList extends StatelessWidget with Labels {
  final List<GenericListObject> listElements;
  final Function selected;
  final Function deleted;
  EhsGenericList({this.listElements, this.selected, this.deleted});

  @override
  Widget build(BuildContext context) {
    List<GenericListObject> _listElements = listElements ?? [];
    return _listElements.length == 0
        ? Text(Labels.noData)
        : ListView.builder(
            itemCount: _listElements.length,
            itemBuilder: (context, index) {
              return GennericListElement(
                title: _listElements[index].title,
                subtitle: _listElements[index].subtitle ?? null,
                deleted: () => deleted(_listElements[index]),
                isSelected: () => selected(_listElements[index]),
              );
            },
          );
  }
}
