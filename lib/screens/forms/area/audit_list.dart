import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/forms/area/area_providers.dart';
import 'package:ehsfocus/screens/forms/area/area_mentenance_form.dart';
import 'package:ehsfocus/screens/forms/area/bloc/area_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';

import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_list_page_search.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AreaMentenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AreaDependencies(
      child: BlocBuilder<AreaBloc, AreaState>(
        buildWhen: (previous, current) => current is AreaListState,
        builder: (context, state) {
          return SearchPageWrapper(
            title: Labels.area,
            search: (data) {},
            add: () {
              BlocProvider.of<AreaBloc>(context).clearForm();
            },
            selected: (data) {
              BlocProvider.of<AreaBloc>(context).setAreaFormById(data.id);
            },
            deleted: (data) {
              BlocProvider.of<AreaBloc>(context).deleteArea(data.id);
            },
            listObjects: state is AreaListState
                ? state.areaList
                    .map((e) => GenericListObject(id: e.id, title: e.area))
                    .toList()
                : [],
            addForm: AreaMentenanceForm(),
          );
        },
      ),
    );
  }
}
