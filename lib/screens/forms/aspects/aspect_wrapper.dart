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

  const AspectWrapper(
      {Key key,
      this.aspect,
      this.hasChanges,
      this.title,
      this.order,
      this.type,
      this.hasAction})
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

  @override
  Widget build(BuildContext context) {
    _aspect = widget.aspect ?? _aspect;
    return AspectBlocDependencyes(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: _isAction
            ? AnimationWrapper(
                child: ActionsFormWidget(
                  aspect: _aspect,
                  order: widget.order + 1,
                  title: Labels.corectiveAcction,
                  navigate: () => navigate(),
                  hasChanges: (data) => setActions(data),
                ),
              )
            : AnimationWrapper(
                child: PhotoCommentForm(
                    hasAction: widget.type == 'N',
                    aspect: _aspect,
                    order: widget.order,
                    type: widget.type,
                    title: widget.title,
                    navigate: () => navigate(),
                    hasChanges: (Aspect data) {
                      setAspects(data);
                    }),
              ),
        persistentFooterButtons: [
          FlatButton.icon(
            icon: Icon(Icons.add),
            label: Text(Labels.addAnother),
            onPressed: () {
              widget.hasChanges(_aspect);
              resetForm();
            },
          ),
          FlatButton(
            onPressed: () {
              widget.hasChanges(_aspect);

              Navigator.pop(context);
            },
            child: Text(Labels.add),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(Labels.back),
          )
        ],
      ),
    );
  }
}
