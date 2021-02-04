import 'package:ehsfocus/bloc/audit_bloc/audit_bloc.dart';
import 'package:ehsfocus/models/action/audit_model.dart';
import 'package:ehsfocus/screens/forms/area/area_form.dart';
import 'package:ehsfocus/screens/forms/aspects/aspects.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/navigation_form/navigation_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuditService {
  Widget getNav(int number, context) {
    return EhsNavigatorWidget(
      action: (data) {
        if (data == 0) {
          BlocProvider.of<AuditBloc>(context).setAuditHead();
        }
      },
      displayWidgets: [
        AuditHeadForm(
          title: Labels.areaId,
          order: 1,
        ),
        AspectsList(
          order: 2,
          type: 'P',
          title: Labels.positiveAcctionMessage,
        ),
        AspectsList(
          order: 3,
          type: 'N',
          title: Labels.negativeAcctionMessage,
        ),
      ],
      pageStart: number,
    );
  }

  String getAreaTitle(Audit audit) {
    if (audit == null) {
      return null;
    }
    return audit.auditHead != null ? '${audit.auditHead.area}' : null;
  }

  String getAreaSubTitle(Audit audit) {
    if (audit == null) {
      return null;
    }
    return audit.auditHead != null
        ? 'audit de ${audit.auditHead.auditType}'
        : null;
  }
}
