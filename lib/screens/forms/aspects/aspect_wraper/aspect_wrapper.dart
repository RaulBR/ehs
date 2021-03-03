import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/screens/forms/aspects/actions_form.dart';
import 'package:ehsfocus/screens/forms/aspects/aspect_wraper/aspect_wrapper_service.dart';
import 'package:ehsfocus/screens/forms/aspects/aspect_wraper/bloc/aspect_wrapper_bloc.dart';
import 'package:ehsfocus/screens/forms/aspects/photo_comment_form.dart';

import 'package:ehsfocus/shared/animations/animation_wrapper.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AspectWraper extends StatelessWidget {
  final Aspect aspect;
  final Function hasChanges;
  final String title;
  final int order;
  final String type;
  final bool hasAction;
  final bool isEditable;
  final bool isFooterEditable;
  final List<String> buttons;
  final AspectWrapperServie _aspectWpService = AspectWrapperServie();
  AspectWraper(
      {Key key,
      this.aspect,
      this.hasChanges,
      this.title,
      this.order,
      this.type,
      this.hasAction,
      this.isEditable,
      this.buttons,
      this.isFooterEditable})
      : super(key: key);

  changeForm(context) {
    BlocProvider.of<AspectWrapperBloc>(context).add(ChangeFormEvent());
  }

  checkForm(context, _aspect) {
    BlocProvider.of<AspectWrapperBloc>(context).add(CheckIfValidEvent(_aspect));
  }

  @override
  Widget build(BuildContext context) {
    Aspect _aspect = aspect ?? Aspect();
    bool _isAction = type == 'N';
    _aspect.type = type;
    return BuilderProvider(
      child: SafeArea(
        child: Scaffold(
          // resizeToAvoidBottomPadding: false,
          body: Container(
            child: BlocBuilder<AspectWrapperBloc, AspectWrapperState>(
                buildWhen: (previous, current) => current is FormPageSate,
                builder: (context, state) {
                  _isAction = state.isPhoto == null ? false : !state.isPhoto;
                  checkForm(context, _aspect);
                  return _isAction
                      ? AnimationWrapper(
                          child: ActionsFormWidget(
                            isEditable: _aspect.status != "A",
                            aspect: _aspect,
                            order: order != null ? order + 1 : null,
                            title: Labels.corectiveAcction,
                            navigate: () => changeForm(context),
                            hasChanges: (data) {
                              _aspect.action = data;
                              checkForm(context, _aspect);
                            }, //setActions(data),
                          ),
                        )
                      : AnimationWrapper(
                          child: PhotoCommentForm(
                              error: null,
                              isEditable: isEditable ?? true,
                              hasAction: hasAction,
                              aspect: _aspect,
                              order: order,
                              type: type,
                              title: title,
                              navigate: () => changeForm(context), //navigate()
                              hasChanges: (Aspect data) {
                                _aspect = data;
                                checkForm(context, _aspect);
                              }),
                        );
                }),
          ),
          bottomNavigationBar: BlocBuilder<AspectWrapperBloc,
                  AspectWrapperState>(
              //     buildWhen: (previous, current) => current is EditableSate,
              builder: (context, state) {
            bool _isEnabled = isFooterEditable == null
                ? (state.isEditable ?? false)
                : isFooterEditable;
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _aspectWpService.generateButtons(
                    buttons: buttons,
                    isEnabled: _isEnabled,
                    hasChanges: (change) {
                      if (change == Labels.back) {
                        Navigator.pop(context);
                        return;
                      }
                      if (change == Labels.add) {
                        Navigator.pop(context);
                      }
                      hasChanges(_aspect, change);
                    }));
          }),
        ),
      ),
    );
  }
}

class BuilderProvider extends StatelessWidget {
  final Widget child;

  const BuilderProvider({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AspectWrapperBloc>(
            create: (context) => AspectWrapperBloc(), child: child)
      ],
      child: child,
    );
  }
}

class GenericPageSwitcher extends StatelessWidget {
  final Widget pageOne;
  final Widget pageTow;

  const GenericPageSwitcher({Key key, this.pageOne, this.pageTow})
      : super(key: key);

  changeForm(context) {
    BlocProvider.of<AspectWrapperBloc>(context).add(ChangeFormEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AspectWrapperBloc>(
      create: (context) => AspectWrapperBloc(),
      child: Container(
        child: BlocBuilder<AspectWrapperBloc, AspectWrapperState>(
            buildWhen: (previous, current) => current is FormPageSate,
            builder: (context, state) {
              bool _isAction = state.isPhoto == null ? false : !state.isPhoto;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _isAction
                          ? AnimationWrapper(
                              child: pageOne,
                            )
                          : AnimationWrapper(
                              child: pageTow,
                            ),
                    ],
                  ),
                  TextButton(
                      onPressed: () => changeForm(context),
                      child: Text('switch'))
                ],
              );
            }),
      ),
    );
  }
}
