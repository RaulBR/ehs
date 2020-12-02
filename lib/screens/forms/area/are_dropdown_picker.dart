import 'package:ehsfocus/models/audit_head_modal.dart';
import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/fields/search_picker/custom_list_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/area_bloc.dart';

class AreaDropDownPiker extends StatelessWidget {
  final AuditHead area;
  final Function getData;

  const AreaDropDownPiker({Key key, this.area, this.getData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuditHead _area = AuditHead();
    _area = area ?? _area;
    return BlocProvider(
      create: (context) => AreaBloc(),
      child: BlocBuilder<AreaBloc, AreaState>(
        buildWhen: (previous, current) => current is AreaListState,
        builder: (context, state) => EhsSearchListPicker(
          label: Labels.area1,
          list: state is AreaListState
              ? state.areaList
                  .map((element) => GenericListObject(
                      id: element.id, title: element.area ?? null))
                  .toList()
              : [],
          preselected: area != null ? area.area : null,
          selected: (data) {
            _area.step = data == _area.area ? _area.step : null;
            _area.area = data.title;
            getData(_area);
          },
          tapped: () {
            //BlocProvider.of<AreaBloc>(context).getAreas();
          },
          searchFor: (data) {
            BlocProvider.of<AreaBloc>(context).searchAreas(data);
          },
        ),
      ),
    );
  }
}
