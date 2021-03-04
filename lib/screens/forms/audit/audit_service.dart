import 'package:ehsfocus/bloc/audit_bloc/audit_bloc.dart';
import 'package:ehsfocus/bloc/audit_bloc/audit_bloc_index.dart';
import 'package:ehsfocus/models/action/audit_model.dart';
import 'package:ehsfocus/screens/forms/area/area_form.dart';
import 'package:ehsfocus/screens/forms/aspects/aspects.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/navigation_form/navigation_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuditService {
  Audit _audit = Audit();
  Widget getNav(int number, context) {
    BlocProvider.of<AuditBloc>(context).getAuditAspects();
    return BlocBuilder<AuditBloc, AuditState>(
      buildWhen: (previous, current) => current is AduitAspectsState,
      builder: (context, state) {
        if (state is AduitAspectsState) {
          _audit = state.audit;
        }
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
              aspects: _audit.positiveAspects,
              order: 2,
              type: 'P',
              title: Labels.positiveAcctionMessage,
            ),
            AspectsList(
              aspects: _audit.negativeAspects,
              order: 3,
              type: 'N',
              title: Labels.negativeAcctionMessage,
            ),
          ],
          pageStart: number,
        );
      },
    );
  }

  String getAreaTitle(Audit audit) {
    if (audit == null) {
      return null;
    }
    if (audit.auditHead == null) {
      return null;
    }
    if (audit.auditHead.area == null) {
      return null;
    }

    return audit.auditHead != null ? '${audit.auditHead.area}' : null;
  }

  String getAreaSubTitle(Audit audit) {
    if (audit == null) {
      return null;
    }
    if (audit.auditHead == null) {
      return null;
    }
    if (audit.auditHead.auditType == null) {
      return 'Nu a-ti ales un tip';
    }
    return 'audit de ${audit.auditHead.auditType}';
  }
}
