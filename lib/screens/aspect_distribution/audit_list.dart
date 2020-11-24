import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/aspect_distribution/action_list.dart';
import 'package:ehsfocus/screens/aspect_distribution/aspect_triaj_footer.dart';
import 'package:ehsfocus/screens/forms/aspects/bloc/aspect_bloc.dart';
import 'package:ehsfocus/services/animations/animation_wrapper.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/loading.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuditList extends StatelessWidget {
  final List<String> actions;
  final Function action;
  const AuditList({Key key, this.actions, this.action}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Aspect> _aspects = [];
    int index = 0;
    return BlocBuilder<AspectBloc, AspectState>(
      buildWhen: (previous, current) =>
          current is AspectToHandleState || current is LoadingState,
      builder: (context, state) {
        _aspects = state is AspectToHandleState ? state.aspects : [];
        return Scaffold(
          appBar: AppBar(title: Text(Labels.auditTitle)),
          body: state is LoadingState
              ? FadeAnimationWrapper(
                  child: Loading(
                    color: AppColors.icons,
                  ),
                )
              : FadeAnimationWrapper(
                  child: ActionDistributionList(
                    index: null,
                    indexOut: (indexOut) {
                      index = indexOut;
                    },
                    listElements:
                        state is AspectToHandleState ? state.aspects : [],
                  ),
                ),
          bottomNavigationBar: (state is LoadingState)
              ? null
              : AspectTriajFooter(
                  actions: actions,
                  getAction: (aspect, actionVal) {
                    action(aspect, actionVal);
                  },
                  aspect:
                      _aspects.length == 0 ? Aspect() : _aspects[index ?? 0],
                ),
        );
      },
    );
  }
}
