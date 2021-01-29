import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';

class EhsGenericAnimatedList extends StatelessWidget {
  final List<GenericListObject> listElements;
  final GlobalKey<AnimatedListState> listKey;
  final Function selected;
  final Function deleted;
  EhsGenericAnimatedList(
      {@required this.listElements,
      @required this.selected,
      this.deleted,
      @required this.listKey});

  @override
  Widget build(BuildContext context) {
    List<GenericListObject> _listElements = listElements ?? [];
    return _listElements.length == 0
        ? Text(Labels.noData)
        : AnimatedList(
            key: listKey,
            initialItemCount: _listElements.length,
            itemBuilder: (context, index, animation) {
              return ListAnimation(
                animation: animation,
                child: GennericListElement(
                  simbol: _listElements[index].status,
                  title: _listElements[index].title,
                  subtitle: _listElements[index].subtitle ?? null,
                  deleted: deleted == null
                      ? null
                      : () => deleted(_listElements[index], index),
                  isSelected: () => selected(_listElements[index]),
                ),
              );
            },
          );
  }
}

class ListAnimation extends StatelessWidget {
  final Animation animation;
  final Widget child;

  const ListAnimation({Key key, this.animation, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: animation.drive(
            Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                .chain(CurveTween(curve: Curves.ease))),
        child: child);
  }
}
