import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/screens/aspect_distribution/action_distribution_card.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ActionDistributionList extends StatelessWidget with Labels {
  final List<Aspect> listElements;
  final Function hasDublicate;
  final int index;
  final Function indexOut;

  ActionDistributionList(
      {this.listElements,
      @required this.indexOut,
      this.index,
      this.hasDublicate});

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(
      initialPage: index == null ? 1 : index,
    );
    List<Aspect> _listElements = listElements ?? [];
    return _listElements.length == 0
        ? Text(Labels.noData)
        : PageView.builder(
            dragStartBehavior: DragStartBehavior.start,
            controller: _controller,
            pageSnapping: true,
            onPageChanged: (value) {
              if (indexOut != null && value != null) {
                indexOut(value);
              }
            },
            itemCount: _listElements.length,
            itemBuilder: (context, index) {
              return ActionDistributionCard(
                  aspect: _listElements[index], hasDublicate: hasDublicate);
            },
          );
  }
}
