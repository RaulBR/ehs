import 'package:ehsfocus/screens/aspect_distribution/audit_list.dart';
import 'package:ehsfocus/screens/forms/aspects/bloc/aspect_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuditsToFixLsit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AspectBloc>(
      create: (context) {
        AspectBloc a = AspectBloc();
        a.getAspectsForMe();
        return a;
      },
      child: AuditListWrapper(),
    );
  }
}

class AuditListWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AspectBloc>(context).getAspectsForMe();
    return AuditList(
        actions: ['', Labels.acceped],
        action: (aspect, action) {
          print(action);
          if (action == Labels.rejected) print('rejected');
          if (action == Labels.acceped) {
            BlocProvider.of<AspectBloc>(context).resolveAspect(aspect: aspect);
          }
        });
  }
}
