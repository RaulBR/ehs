import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/forms/aspects/aspect_wrapper.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';

class AspectTriajFooter extends StatelessWidget {
  final List<String> actions;
  final Function getAction;
  final Aspect aspect;
  const AspectTriajFooter({Key key, this.actions, this.getAction, this.aspect})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            onPressed: () {
              getAction(aspect, actions[0]);
            },
            child: Text(
              actions[0],
              style: actions[0] == Labels.rejected
                  ? TextStyle(color: AppColors.fieldInFocus)
                  : null,
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AspectWrapper(
                    isEditable: false,
                    aspect: aspect ?? Aspect(),
                    hasChanges: (data, action) {
                      getAction(data, action);
                    },
                    title: Labels.aspectTitle,
                    type: 'N',
                    hasAction: true,
                    buttons: [Labels.acceped, Labels.rejected],
                  ),
                ),
              );
            },
            child: Text(Labels.ditail),
          ),
          FlatButton(
            onPressed: () {
              getAction(aspect, actions[1]);
            },
            child: Icon(
              Icons.check,
              color: AppColors.accent,
            ),
          )
        ],
      ),
    );
  }
}
