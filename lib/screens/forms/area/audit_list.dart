import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/category/category_type_list.dart';
import 'package:ehsfocus/screens/forms/area/area_providers.dart';
import 'package:ehsfocus/screens/forms/area/area_mentenance_form.dart';

import 'package:ehsfocus/shared/form_eleements/generic_list_page_search.dart';
import 'package:flutter/material.dart';

class AuditList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AreaDependencies(
      child: SearchPageWrapper(
        title: 'Area',
        search: (data) {
          print(data);
        },
        child: EhsGenericList(
          listElements: [
            GenericListObject(id: null, title: 'Here', subtitle: 'There')
          ],
          selected: (data) {},
        ),
        addForm: AreaMentenanceForm(),
      ),
    );
  }
}
