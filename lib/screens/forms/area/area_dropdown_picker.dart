import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/area/area_model.dart';
import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/fields/search_picker/custom_list_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/area/area_bloc.dart';

class AreaDropDownPiker extends StatelessWidget {
  final AuditHead area;
  final Function getData;

  const AreaDropDownPiker({Key key, this.area, this.getData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuditHead _area = AuditHead();
    _area = area ?? _area;
    return BlocBuilder<AreaBloc, AreaState>(
      buildWhen: (previous, current) =>
          current is AreaListState || current is AreaFormState,
      builder: (context, state) {
        String selected = area != null ? area.area : null;
        List<Area> list = [];
        if (state is AreaListState) {
          list = state.areaList != null ? state.areaList : [];
        }
        if (state is AreaFormState) {
          selected = state.area != null ? state.area.area : selected;
        }

        return EhsSearchListPicker(
          label: Labels.area1,
          list: list
              .map((element) => GenericListObject(
                  id: element.id, title: element.area ?? null))
              .toList(),
          preselected: selected,
          selected: (data) {
            _area.step = data == _area.area ? _area.step : null;
            _area.area = data.title;
            BlocProvider.of<AreaBloc>(context).setAreaFormByArea(_area.area);
            getData(_area);
          },
          tapped: () {
            BlocProvider.of<AreaBloc>(context).getAreas();
          },
          searchFor: (data) {
            BlocProvider.of<AreaBloc>(context).searchAreas(data);
          },
        );
      },
    );
  }
}
