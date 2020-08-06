import 'package:ehsfocus/models/category_model.dart';
import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';

class EhsCategoryTypeList extends StatelessWidget with Labels {
  final List<CategoryType> categoryTypes;
  final Function selected;
  EhsCategoryTypeList({this.categoryTypes, this.selected});

  @override
  Widget build(BuildContext context) {
    return categoryTypes == null
        ? Text(Labels.noData)
        : ListView.builder(
            itemCount: categoryTypes == null ? 0 : categoryTypes.length,
            itemBuilder: (context, index) {
              return GennericListElement(
                title: categoryTypes[index].type,
                // file: aspects[index].photo,
                isSelected: () {
                  selected(categoryTypes[index]);
                },
              );
            },
          );
  }
}

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
                // deleted: () => deleted(_listElements[index]),
                isSelected: () => selected(_listElements[index]),
              );
            },
          );
  }
}
