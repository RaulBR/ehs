import 'dart:io';
import 'package:ehsfocus/screens/forms/actions_form.dart';
import 'package:ehsfocus/shared/action_button.dart';
import 'package:ehsfocus/shared/animation_wrapper.dart';
import 'package:ehsfocus/shared/audit_form_wraper.dart';
import 'package:ehsfocus/shared/charts/fields/custom_drop_down.dart';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/plaveholder_photo.dart';
import 'package:ehsfocus/shared/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoCommentForm extends StatefulWidget with Lables {
  final Aspect aspect;
  final Function hasChanges;
  final String title;
  final int order;
  final String type;
  final bool hasAction;
  final bool isfooterDisabled;

  PhotoCommentForm(
      {this.hasChanges,
      @required this.title,
      this.order,
      this.type,
      this.aspect,
      this.hasAction,
      this.isfooterDisabled});
  @override
  _PhotoCommentFormState createState() => _PhotoCommentFormState();
}

class _PhotoCommentFormState extends State<PhotoCommentForm> {
  File imageFile;
  Aspect _aspect = Aspect();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  bool isAction = false;
  @override
  Widget build(BuildContext context) {
    _aspect.type = widget.type;
    _aspect = widget.aspect ?? _aspect;
    return Scaffold(
      key: _key,
      resizeToAvoidBottomPadding: false,
      body: isAction
          ? AnimationWrapper(
// TODO add key
              child: ActionsFormWidget(
                goBack: () {
                  setState(() {
                    isAction = true;
                  });
                },
                action: widget.aspect != null ? widget.aspect.action : null,
                order: widget.order + 1,
                title: Lables.corectiveAcction,
              ),
            )
          : AnimationWrapper(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AuditFormWraper(
                    title: widget.title == null ? null : widget.title,
                    order: widget.order == null ? '' : widget.order,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () => handleShowDialog(context),
                          child: PhotoWithPlaceholder(
                            imageFile: _aspect.photo,
                          ),
                        ),
                      ),
                      EhsDropDown(
                        label: Lables.category,
                        dropDownList: <String>['a', 'b', 'c'],
                        selected: (value2) {
                          print(' herewrhe ' + value2);
                          setState(() {
                            _aspect.category = value2;
                          });
                        },
                        preselected: _aspect.category,
                      ),
                      TextAreaWidget(
                        text: _aspect.comment,
                        onEdit: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditableTextAreaWidget(
                                  text: _aspect.comment,
                                  onEdit: (text) {
                                    setState(() {
                                      _aspect.comment = text;
                                    });
                                  },
                                ),
                              ));
                        },
                      ),
                    ],
                  ),
                  widget.hasAction == null || !widget.hasAction
                      ? SizedBox()
                      : NavigateToNextPage(
                          label: 'Adauga Actiune corectiva',
                          onPressed: () {
                            setState(() {
                              isAction = true;
                            });
                          },
                        ),
                ],
              ),
            ),
      persistentFooterButtons: widget.isfooterDisabled != null &&  widget.isfooterDisabled
          ? null
          : [
              FlatButton.icon(
                icon: Icon(Icons.add),
                label: Text(Lables.addAnother),
                onPressed: () {
                  widget.hasChanges(_aspect);
                },
              ),
              FlatButton(
                onPressed: () {
                  widget.hasChanges(_aspect);
                  Navigator.pop(context);
                },
                child: Text(Lables.add),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(Lables.back),
              )
            ],
    );
  }

  _openGalery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _aspect.photo = image;
    });
    Navigator.pop(context);
  }

  _openCamera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _aspect.photo = image;
    });
    Navigator.pop(context);
  }

  Future<void> handleShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(Lables.chose),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlatButton.icon(
                        onPressed: () => _openGalery(),
                        icon: Icon(Icons.photo_album),
                        label: Text(Lables.galery)),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton.icon(
                        onPressed: () => _openCamera(),
                        icon: Icon(Icons.camera_alt),
                        label: Text(Lables.camera)),
                  ],
                ),
              ));
        });
  }
}
