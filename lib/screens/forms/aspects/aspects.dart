import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/screens/forms/aspects/aspect_wraper/aspect_wrapper.dart';
import 'package:ehsfocus/screens/forms/aspects/ehs_asplect_list.dart';
import 'package:ehsfocus/bloc/audit_bloc/audit_bloc.dart';
import 'package:ehsfocus/bloc/audit_bloc/audit_state.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';
import 'package:ehsfocus/shared/animations/slide_right_router.dart';

import 'package:ehsfocus/shared/form_eleements/audit_form_wraper.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/lists/ehs_generic_animated_lsit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AspectsList extends StatelessWidget {
  final bool disabled;
  final List<Aspect> aspects;
  final String title;
  final int order;
  final String type;
  final _mylistKey = GlobalKey<AnimatedListState>();
// her raul
  AspectsList({
    this.aspects,
    @required this.title,
    this.order,
    this.type,
    this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    List<Aspect> _aspects = aspects == null ? [] : [...aspects];
    BuildContext _context = context;
    //BlocProvider.of<AuditBloc>(_context).getAuditAspect(type);
    return Scaffold(
      body: AuditFormWraper(
        title: title,
        order: order,
        children: [
          BlocListener<AuditBloc, AuditState>(
            listener: (context, state) {
              if (state is DeleteAuditAspectState) {
                //   _aspects.removeAt(state.intex);
              }
            },
            child: _aspects.length == 0
                ? Text(Labels.addAspect)
                : Expanded(
                    child: EhsAspectList(
                        listKey: _mylistKey,
                        aspects: _aspects,
                        deleted: (data, index) {
                          if (_mylistKey.currentState != null)
                            _mylistKey.currentState.removeItem(
                              index,
                              (context, animation) => ListAnimation(
                                animation: animation,
                                child: GennericListElement(
                                  simbol: data.status,
                                  title: data.equipment,
                                  subtitle: data.category,
                                ),
                              ),
                            );
                          _aspects.removeAt(index);
                          BlocProvider.of<AuditBloc>(_context)
                              .deleteAuditAspect(data, index);
                        },
                        selected: (Aspect aspect) {
                          navigate(
                              context: context,
                              aspect: aspect,
                              navigationEvent: (data) {
                                data.type = type;
                                BlocProvider.of<AuditBloc>(_context)
                                    .setAspect(data);
                                // hasChanges(data);
                              });
                        }),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigate(
              context: _context,
              navigationEvent: (data) {
                data.type = type;
                BlocProvider.of<AuditBloc>(_context).setAspect(data);
                // hasChanges(data);
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // move to service
  navigate({context, Aspect aspect, Function navigationEvent}) {
    Navigator.push(
        context,
        SlideRightRoute(
          page: BlocProvider.value(
            value: BlocProvider.of<AreaBloc>(context),
            child: AspectWraper(
                hasAction: type == 'N',
                aspect: aspect,
                order: order,
                type: type,
                title: title,
                hasChanges: (Aspect data, action) {
                  data.type = type;
                  navigationEvent(data);
                }),
          ),
        ));
  }
}
