import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';

import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/lists/ehs_generic_animated_lsit.dart';
import 'package:flutter/material.dart';

class EhsAspectList extends StatelessWidget with Labels {
  final GlobalKey<AnimatedListState> listKey;
  final List<Aspect> aspects;
  final Function selected;
  final Function deleted;
  EhsAspectList({this.aspects, this.selected, this.deleted, this.listKey});
// here
  @override
  Widget build(BuildContext context) {
    GlobalKey<AnimatedListState> _listKey =
        listKey == null ? GlobalKey<AnimatedListState>() : listKey;
    return AnimatedList(
      key: _listKey,
      initialItemCount: aspects.length,
      itemBuilder: (context, index, animation) {
        return ListAnimation(
          animation: animation,
          child: GennericListElement(
            simbol: aspects[index].status,
            title: aspects[index].equipment,
            subtitle: aspects[index].category,
            deleted: deleted == null
                ? null
                : () {
                    if (listKey.currentState != null)
                      listKey.currentState.removeItem(
                        index,
                        (context, animation) => ListAnimation(
                          animation: animation,
                          child: GennericListElement(
                            simbol: aspects[index].status,
                            title: aspects[index].equipment,
                            subtitle: aspects[index].category,
                          ),
                        ),
                      );
                    if (index < aspects.length - 1) aspects.removeAt(index);
                    deleted(aspects[index]);
                  },
            isSelected: () {
              selected(aspects[index]);
            },
          ),
        );
      },
    );
  }
}
