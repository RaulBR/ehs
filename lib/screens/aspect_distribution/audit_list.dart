import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/screens/aspect_distribution/action_list.dart';
import 'package:ehsfocus/screens/aspect_distribution/aspect_triaj_footer.dart';
import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/screens/forms/aspects/aspect_wraper/aspect_wrapper.dart';
import 'package:ehsfocus/bloc/aspect/aspect_bloc.dart';
import 'package:ehsfocus/shared/animations/animation_wrapper.dart';

import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/loading.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuditList extends StatelessWidget {
  final bool hasDuplicate;
  final List<String> actions;
  final Function action;

  const AuditList({Key key, this.actions, this.action, this.hasDuplicate})
      : super(key: key);
  openAspect(context, Aspect aspect) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) {
            AreaBloc areaBloc = AreaBloc();
            String area = aspect.audit.area;
            areaBloc.setareaString(area);
            return areaBloc;
          },
          child: AspectWraper(
            isEditable: false,
            isFooterEditable: true,
            aspect: aspect ?? Aspect(),
            hasChanges: (action) {
              action(aspect, action);
            },
            title: Labels.aspectTitle,
            type: 'N',
            hasAction: true,
            buttons: [Labels.acceped, Labels.rejected],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Aspect> _aspects = [];
    int index = 0;
    bool _hasDuplicate = hasDuplicate == null ? false : hasDuplicate;
    return BlocBuilder<AspectBloc, AspectState>(
      buildWhen: (previous, current) =>
          current is AspectToHandleState || current is LoadingState,
      builder: (context, state) {
        _aspects = state is AspectToHandleState ? state.aspects : [];
        return Scaffold(
          appBar: AppBar(title: Text(Labels.auditTitle)),
          resizeToAvoidBottomInset: false,
          body: state is LoadingState
              ? FadeAnimationWrapper(
                  child: Loading(
                    color: AppColors.icons,
                  ),
                )
              : FadeAnimationWrapper(
                  child: BlocBuilder<AspectBloc, AspectState>(
                    builder: (context, state) {
                      index = BlocProvider.of<AspectBloc>(context).getIndex();
                      if (index == -1) {
                        Navigator.pop(context);
                      }
                      return ActionDistributionList(
                        hasDublicate: !_hasDuplicate
                            ? null
                            : (value) {
                                if (value) {
                                  _aspects[index].type = 'D';
                                }
                              },
                        index: index,
                        indexOut: (indexOut) {
                          index = indexOut;
                        },
                        listElements:
                            state is AspectToHandleState ? state.aspects : [],
                      );
                    },
                  ),
                ),
          bottomNavigationBar: (state is LoadingState)
              ? null
              : AspectTriajFooter(
                  actions: actions,
                  getAction: (actionVal) {
                    if (actionVal == Labels.ditail) {
                      openAspect(
                        context,
                        _aspects[index],
                      );
                      return;
                    }
                    action(_aspects[index], actionVal);
                  },
                ),
        );
      },
    );
  }
}
