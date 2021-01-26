import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/screens/aspect_distribution/audit_list.dart';
import 'package:ehsfocus/screens/forms/aspects/bloc/aspect_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RejectedAspects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AspectBloc _aspect = AspectBloc();
    var edit;
    return BlocProvider<AspectBloc>(
      create: (context) {
        _aspect.getMyRejectedAspects();
        return _aspect;
      },
      child: AuditList(
          hasDuplicate: true,
          actions: ['', Labels.edit],
          action: (Aspect aspect, action) async {
            if (action == Labels.rejected) {
              // move service to provider;

            }
            if (action == Labels.acceped) {
              _aspect.acceptAspect(aspect: aspect);
            }
          }),
    );
  }
}
