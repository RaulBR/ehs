import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/screens/aspect_distribution/audit_list.dart';
import 'package:ehsfocus/screens/forms/aspects/bloc/aspect_bloc.dart';
import 'package:ehsfocus/services/popup_service/generic_message_popup.dart';

import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistributeAspectsLsit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AspectBloc _aspect = AspectBloc();
    return BlocProvider<AspectBloc>(
      create: (context) {
        _aspect.getAspectsToApprove();
        return _aspect;
      },
      child: AuditList(
          hasDuplicate: true,
          actions: [Labels.rejected, Labels.acceped],
          action: (Aspect aspect, action) async {
            print(action);
            print(aspect.toJson());
            if (action == Labels.rejected) {
              // move service to provider;
              String comment = await EhsGennericPopup()
                  .showCommentPupup(context, what: 'reject comment');
              aspect.rejectComment = comment;
              if (comment != '') {
                _aspect.rejectAspect(aspect: aspect);
              }
            }
            if (action == Labels.acceped) {
              _aspect.acceptAspect(aspect: aspect);
            }
          }),
    );
  }
}
