import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/forms/area/area_providers.dart';
import 'package:ehsfocus/screens/forms/area/area_mentenance_form.dart';
import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/screens/forms/area/area_service.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/generic_list_page_search.dart';
import 'package:ehsfocus/shared/form_eleements/lists/ehs_generic_animated_lsit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AreaMentenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _areaService = AreaService();
    final _mylistKey = GlobalKey<AnimatedListState>();
    BlocProvider.of<AreaBloc>(context).getAreas();
    return AreaDependencies(
      child: SearchPageWrapper(
        title: Labels.area,
        search: (data) {},
        customListWidget: BlocBuilder<AreaBloc, AreaState>(
          buildWhen: (previous, current) => current is AreaListState,
          builder: (context, state) {
            List<GenericListObject> list =
                _areaService.areaListToGenericList(state);
            return EhsGenericAnimatedList(
              listKey: _mylistKey,
              listElements: list,
              selected: (data) {
                _areaService.openSheet(context, AreaMentenanceForm(),
                    id: data.id);
              },
              deleted: (data, index) {
                _areaService.deletteElemet(_mylistKey, index, data, list);
                BlocProvider.of<AreaBloc>(context).deleteArea(data.id);
              },
            );
          },
        ),
        add: () {
          BlocProvider.of<AreaBloc>(context).clearForm();
        },
        addForm: AreaMentenanceForm(),
      ),
    );
  }
}
