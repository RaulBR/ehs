import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/category/category_picker.dart';
import 'package:ehsfocus/screens/category/category_type_picker.dart';
import 'package:ehsfocus/screens/forms/area/bloc/area_bloc.dart';
import 'package:ehsfocus/services/camera_service.dart';
import 'package:ehsfocus/shared/action_button.dart';
import 'package:ehsfocus/shared/fields/search_picker/custom_list_search.dart';
import 'package:ehsfocus/shared/form_eleements/audit_form_wraper.dart';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/photoComponents/placeholder_photo.dart';
import 'package:ehsfocus/shared/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoCommentForm extends StatelessWidget {
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
      this.isEditable});

  @override
  Widget build(BuildContext context) {
    Aspect _aspect = Aspect();
    final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    _aspect.type = type;
    _aspect = aspect == null ? _aspect : aspect;

    return Scaffold(
      key: _key,
      resizeToAvoidBottomPadding: false,
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
                BlocBuilder<AreaBloc, AreaState>(
                  buildWhen: (previous, current) => current is StepListState,
                  builder: (context, state) => EhsSearchListPicker(
                    isEditable: isEditable,
                    label: Labels.area2,
                    list: state is StepListState
                        ? state.stepList
                            .map((element) => GenericListObject(title: element))
                            .toList()
                        : [],
                    preselected: null, //_area.step,
                    selected: (data) {
                      //  BlocProvider.of<AuditBloc>(context).setArea(_area);
                    },
                    tapped: () {},
                    searchFor: (data) {
                      //  areaBloc.searchAreas(data);
                    },
                  ),
                ),
                CategoryTypePiker(
                  input: _aspect.categoryType,
                  isEditable: isEditable,
                  hasChanges: (value2) {
                    _aspect.categoryType = value2;
                    hasChanges(_aspect);
                  },
                  label: Labels.aspectType,
                ),
                CategoryPiker(
                  input: _aspect.category,
                  isEditable: isEditable,
                  hasChanges: (value2) {
                    _aspect.category = value2;
                    hasChanges(_aspect);
                  },
                  label: Labels.category,
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
