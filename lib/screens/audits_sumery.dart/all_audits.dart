import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/forms/audit/audit_bloc/audit_bloc_index.dart';
import 'package:ehsfocus/screens/forms/audit/audit_form.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_list_page_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAudits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuditBloc>(context).getAudits();
    return BlocBuilder<AuditBloc, AuditState>(
      buildWhen: (previous, current) => current is AuditsDataState,
      builder: (context, state) {
        List<GenericListObject> elements = [];
        if (state is AuditsDataState) {
          state.areaList.forEach((element) {
            elements.add(GenericListObject(
                status: element.auditHead.auditStatus,
                id: element.auditHead.id,
                title: element.auditHead.area,
                subtitle: element.auditHead.createdDate));
          });
        }
        return SearchPageWrapper(
          title: Labels.auditTitle,
          addForm: AuditForm(loadDataFromList: true),
          listObjects: elements,
          selected: (data) {
            BlocProvider.of<AuditBloc>(context).selectedAudit(data);
          },
          // add: () {
          //   BlocProvider.of<AuditBloc>(context).selectedAudit(null);
          // },
          // deleted: (data) {},
          search: (data) {},
        );
      },
    );
  }
}
