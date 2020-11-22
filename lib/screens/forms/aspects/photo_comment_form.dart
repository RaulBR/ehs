import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/category/bloc/category_bloc.dart';
import 'package:ehsfocus/screens/forms/area/bloc/area_bloc.dart';
import 'package:ehsfocus/screens/forms/aspects/aspect_service.dart';
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
                    isEditable: true,
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
                              .map((element) =>
                                  GenericListObject(title: element))
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

                  // till here
                  BlocBuilder<CategoryBloc, CategoryState>(
                    buildWhen: (previous, current) =>
                        current is CategorysTypesState,
                    builder: (context, state) => EhsSearchListPicker(
                      isEditable: isEditable,
                      list: AspectService()
                          .handleCategorysStateChange(context, state),
                      label: Labels.aspectType,
                      tapped: () {
                        BlocProvider.of<CategoryBloc>(context)
                            .add(GetCategoryTypeEvent());
                      },
                      selected: (value2) {
                        if (_aspect.categoryType != value2.title) {
                          _aspect.category = null;
                        }
                        _aspect.categoryType = value2.title;

                        BlocProvider.of<CategoryBloc>(context)
                            .selectedType(value2.id);
                        hasChanges(_aspect);
                      },
                      preselected: _aspect.categoryType,
                    ),
                  ),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    buildWhen: (previous, current) => current is CategorysState,
                    builder: (context, state) => EhsSearchListPicker(
                      isEditable: isEditable,
                      list: AspectService()
                          .handleCategorysStateChange(context, state),
                      label: Labels.category,
                      tapped: () {
                        BlocProvider.of<CategoryBloc>(context)
                            .add(GetCategorysEvent());
                      },
                      selected: (value2) {
                        _aspect.category = value2.title;
                        hasChanges(_aspect);
                      },
                      preselected: _aspect.category,
                    ),
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
        ));
  }
}
