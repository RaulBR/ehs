import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/forms/aspects/aspect_wraper/aspect_wrapper.dart';
import 'package:ehsfocus/screens/forms/aspects/ehs_asplect_list.dart';
import 'package:ehsfocus/screens/forms/audit/audit_bloc/audit_bloc.dart';
import 'package:ehsfocus/screens/forms/audit/audit_bloc/audit_state.dart';
import 'package:ehsfocus/services/animations/slide_right_router.dart';
import 'package:ehsfocus/shared/form_eleements/audit_form_wraper.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AspectsList extends StatelessWidget {
  final bool disabled;
  final Function hasChanges;
  final String title;
  final int order;
  final String type;
  final List<Aspect> aspects;

  AspectsList(
      {this.aspects,
      this.hasChanges,
      @required this.title,
      this.order,
      this.type,
      this.disabled});

  @override
  Widget build(BuildContext context) {
    List<Aspect> _aspects = [];
    _aspects = aspects ?? _aspects;
    return Scaffold(
      body: BlocBuilder<AuditBloc, AuditState>(
        builder: (context, state) => AuditFormWraper(
          title: title,
          order: order,
          children: [
            _aspects.length == 0
                ? Text(Labels.addAspect)
                : Expanded(
                    child: EhsAspectList(
                        aspects: _aspects,
                        selected: (Aspect aspect) {
                          navigate(
                              context: context,
                              aspect: aspect,
                              navigationEvent: (data) {
                                data.type = type;
                                hasChanges(data);
                              });
                        }),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigate(
              context: context,
              navigationEvent: (data) {
                data.type = type;
                hasChanges(data);
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
          page: AspectWraper2(
              hasAction: type == 'N',
              aspect: aspect,
              order: order,
              type: type,
              title: title,
              hasChanges: (Aspect data, action) {
                data.type = type;
                navigationEvent(data);
              }),
        ));
  }
}
