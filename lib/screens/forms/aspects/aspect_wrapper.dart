import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/forms/aspects/actions_form.dart';
import 'package:ehsfocus/screens/forms/aspects/aspect_dependencys.dart';
import 'package:ehsfocus/screens/forms/aspects/photo_comment_form.dart';
import 'package:ehsfocus/services/animations/animation_wrapper.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';

class AspectWrapper extends StatefulWidget {
  final Aspect aspect;
  final Function hasChanges;
  final String title;
  final int order;
  final String type;
  final bool hasAction;
  final bool isEditable;
  final List<String> buttons;

  const AspectWrapper(
      {Key key,
      this.aspect,
      this.hasChanges,
      this.title,
      this.order,
      this.type,
      this.hasAction,
      this.buttons,
      this.isEditable})
      : super(key: key);

  @override
  _AspectWrapperState createState() => _AspectWrapperState();
}

class _AspectWrapperState extends State<AspectWrapper> {
  bool _isAction = false;
  Aspect _aspect = Aspect();
  navigate() {
    setState(() {
      _isAction = !_isAction;
    });
  }

  setAspects(data) {
    setState(() {
      _aspect = data;
    });
  }

  setActions(data) {
    setState(() {
      _aspect.action = data;
    });
  }

  resetForm() {
    setState(() {
      _aspect = Aspect();
    });
  }

  List<Widget> generateButtons() {
    List<String> buttons = widget.buttons ?? [];
    if (widget.buttons == null) {
      buttons.add(Labels.addAnother);
      buttons.add(Labels.add);
      buttons.add(Labels.back);
    }
    return [
      FlatButton(
        // icon: Icon(Icons.add),
        child: Text(buttons[0]),
        onPressed: () {
          widget.hasChanges(_aspect, buttons[0]);
          resetForm();
        },
      ),
      FlatButton(
        onPressed: () {
          widget.hasChanges(_aspect, buttons[1]);

          Navigator.pop(context);
        },
        child: Text(buttons[1]),
      ),
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(Labels.back),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    _aspect = widget.aspect ?? _aspect;
    return AspectBlocDependencyes(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: _isAction
            ? AnimationWrapper(
                child: ActionsFormWidget(
                  isEditable: _aspect.status != "A",
                  aspect: _aspect,
                  order: widget.order != null ? widget.order + 1 : null,
                  title: Labels.corectiveAcction,
                  navigate: () => navigate(),
                  hasChanges: (data) => setActions(data),
                ),
              )
            : AnimationWrapper(
                child: PhotoCommentForm(
                    isEditable: widget.isEditable ?? true,
                    hasAction: widget.hasAction,
                    aspect: _aspect,
                    order: widget.order,
                    type: widget.type,
                    title: widget.title,
                    navigate: () => navigate(),
                    hasChanges: (Aspect data) {
                      setAspects(data);
                    }),
              ),
        persistentFooterButtons: generateButtons(),
      ),
    );
  }
}
