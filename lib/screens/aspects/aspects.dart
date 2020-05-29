import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/screens/aspects/photo_comment_form.dart';
import 'package:ehsfocus/screens/forms/ehs_asplect_list.dart';

import 'package:ehsfocus/shared/animation_wrapper.dart';
import 'package:ehsfocus/shared/audit_form_wraper.dart';
import 'package:ehsfocus/shared/constants.dart';

import 'package:flutter/material.dart';

class AspectsList extends StatelessWidget {
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
      this.type});

  @override
  Widget build(BuildContext context) {
    List<Aspect> _aspects = [];
    _aspects = aspects;

    navigate({Aspect aspect}) {
      Navigator.push(
          context,
          SlideRightRoute(
              page: SafeArea(
                  child: PhotoCommentForm(
                      hasAction: type == 'N',
                      aspect: aspect,
                      order: order,
                      type: type,
                      title: title,
                      hasChanges: (Aspect data) {
                        print(data);
                        if (data.photo == null) {
                          return;
                        }
                        _aspects.add(data);
                        hasChanges(_aspects);

                        //  widget.hasChanges( _aspects);
                      }))));
    }

    print('Buiild acctions');
    return Scaffold(
      body: AuditFormWraper(
        title: title,
        order: order,
        children: [
          _aspects == null
              ? Text(Lables.addAspect)
              : EhsAspectList(
                  aspects: _aspects,
                  selected: (Aspect aspect) {
                    navigate(aspect: aspect);
                  }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigate();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
