import 'package:ehsfocus/screens/category/bloc/category_bloc.dart';
import 'package:ehsfocus/screens/forms/aspects/aspect_service.dart';
import 'package:ehsfocus/screens/forms/aspects/bloc/aspect_bloc.dart';

import 'package:ehsfocus/services/camera_service.dart';
import 'package:ehsfocus/shared/action_button.dart';
import 'package:ehsfocus/shared/fields/search_picker/custom_list_search.dart';
import 'package:ehsfocus/shared/form_eleements/audit_form_wraper.dart';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/placeholder_photo.dart';
import 'package:ehsfocus/shared/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/aspect_bloc.dart';

class PhotoCommentForm extends StatelessWidget {
  final Aspect aspect;
  final String type;
  final String title;
  final int order;
  final bool hasAction;
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
      this.navigate});

  @override
  Widget build(BuildContext context) {
    List<String> _aspectTypes = [];
    List<String> _categoryes = [];
    String _selectedCategoryType;
    String image;
    if (aspect != null && aspect.photos != null && aspect.photos.length > 0) {
      if (aspect.photos[0].photo == null) {
        BlocProvider.of<AspectBloc>(context).getAspectsPhotos(aspect);
      }
      if (aspect.photos[0].photo != null) {
        image = aspect.photos[0].photo ?? null;
      }
    }
    Aspect _aspect = Aspect();
    final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    _aspect.type = type;
    _aspect = aspect ?? _aspect;

    return Scaffold(
        key: _key,
        resizeToAvoidBottomPadding: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AuditFormWraper(
              title: title,
              order: order,
              children: [
                BlocListener<AspectBloc, AspectState>(
                  listener: (BuildContext context, AspectState state) {
                    if (state is AuditPhotos) {
                      image = state.photos[0].photo ?? null;
                      _aspect.photos[0].photo = image;
                    }
                  },
                  child: BlocBuilder<AspectBloc, AspectState>(
                    buildWhen: (state, current) => current is AuditPhotos,
                    builder: (context, state) => PhotoWithPlaceholder(
                      image: image,
                      open: () => camera.handleShowDialog(context, ((picture) {
                        _aspect.photos = [];
                        _aspect.photos.add(picture);
                        hasChanges(_aspect);
                      })),
                      remove: () {
                        BlocProvider.of<AspectBloc>(context)
                            .deleteAspectPhoto(_aspect.photos[0]);
                        hasChanges(_aspect);
                      },
                    ),
                  ),
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  buildWhen: (previous, current) =>
                      current is CategorysTypesState,
                  builder: (context, state) => EhsSearchListPicker2(
                    list: AspectService()
                        .handleCategorysStateChange(context, state),
                    label: Labels.aspectType,
                    tapped: () {
                      BlocProvider.of<CategoryBloc>(context)
                          .add(GetCategoryTypeEvent());
                    },
                    selected: (value2) {
                      _aspect.categoryType = value2.type;
                      BlocProvider.of<CategoryBloc>(context)
                          .selectedType(value2.id);

                      hasChanges(_aspect);
                    },
                    preselected: _aspect.categoryType,
                  ),
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  buildWhen: (previous, current) => current is CategorysState,
                  builder: (context, state) => EhsSearchListPicker2(
                    list: AspectService()
                        .handleCategorysStateChange(context, state),
                    label: Labels.category,
                    tapped: () {
                      BlocProvider.of<CategoryBloc>(context)
                          .add(GetCategorysEvent());
                    },
                    selected: (value2) {
                      _aspect.category = value2.type;
                      hasChanges(_aspect);
                    },
                    preselected: _aspect.category,
                  ),
                ),
                OpenTextAreaWidget(
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
        ));
  }
}
