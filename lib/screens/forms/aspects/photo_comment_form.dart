import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/screens/category/category_picker.dart';
import 'package:ehsfocus/bloc/audit_bloc/audit_bloc.dart';
import 'package:ehsfocus/screens/forms/area/equipment_dropdown_picker.dart';
import 'package:ehsfocus/shared/photoComponents/camera_service.dart';
import 'package:ehsfocus/shared/action_button.dart';
import 'package:ehsfocus/shared/form_eleements/audit_form_wraper.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/photoComponents/placeholder_photo.dart';
import 'package:ehsfocus/shared/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoCommentForm extends StatelessWidget {
  final PhotoCommentError error;
  final Aspect aspect;
  final String type;
  final String title;
  final int order;
  final bool hasAction;
  final bool isEditable;
  final Function navigate;
  final Function hasChanges;
  final CameraService camera = CameraService();
  PhotoCommentForm(
      {this.hasChanges,
      @required this.title,
      this.order,
      this.type,
      this.aspect,
      this.hasAction,
      this.navigate,
      this.isEditable,
      this.error});

  @override
  Widget build(BuildContext context) {
    Aspect _aspect = Aspect();

    final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    _aspect.type = type;
    _aspect = aspect == null ? _aspect : aspect;
    _aspect.categoryType = BlocProvider.of<AuditBloc>(context).getAuditType();
    String area = BlocProvider.of<AuditBloc>(context).getAuditArea();
    return Scaffold(
      key: _key,
      // resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AuditFormWraper(
              title: title,
              order: order,
              children: [
                PhotoWithPlaceholder(
                  aspectIn: _aspect,
                  isEditable: isEditable == null ? true : isEditable,
                  addPicture: (picture) {
                    _aspect.photos = [];
                    _aspect.photos.add(picture);
                    hasChanges(_aspect);
                  },
                  deletePicture: (picture) {
                    _aspect.photos
                        .remove((element) => element.id == picture.id);
                  },
                ),
                EquipmantDroptDownPicker(
                  area: area,
                  equipment: _aspect.equipment,
                  isEditable: isEditable,
                  getData: (equipment) {
                    _aspect.equipment = equipment;
                  },
                ),
                CategoryPiker(
                  categoryType: _aspect.categoryType,
                  error: null,
                  input: _aspect.category,
                  isEditable: isEditable,
                  hasChanges: (_category) {
                    _aspect.category = _category;
                    hasChanges(_aspect);
                  },
                ),
                OpenTextAreaWidget(
                  isEditable: isEditable,
                  label: _aspect.comment == null
                      ? Labels.addComment
                      : Labels.comment,
                  text: _aspect.comment,
                  onEdit: (text) {
                    _aspect.comment = text;
                    hasChanges(_aspect);
                  },
                ),
              ],
            ),
            hasAction == null || !hasAction
                ? SizedBox()
                : NavigateToNextPage(
                    label: _aspect.action != null
                        ? Labels.goTocorectiveAcction
                        : Labels.addCorectiveAcction,
                    onPressed: () => navigate(),
                  ),
          ],
        ),
      ),
    );
  }
}

class PhotoCommentError {
  String areaError;
  String photoError;
  String categoryError;
  String commentError;
}
