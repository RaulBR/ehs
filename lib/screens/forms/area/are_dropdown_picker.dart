import 'package:ehsfocus/models/action/audit_head_modal.dart';
import 'package:ehsfocus/models/area/area_model.dart';
import 'package:ehsfocus/models/area/area_step_model.dart';
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
            // BlocProvider.of<AreaBloc>(context).setAreaFormByArea(data.area);
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

class EquipmantDroptDownPicker extends StatelessWidget {
  final String equipment;
  final bool isEditable;
  final Function getData;

  const EquipmantDroptDownPicker(
      {Key key, this.equipment, this.getData, this.isEditable})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AreaBloc, AreaState>(
        buildWhen: (previous, current) =>
            current is StepListState || current is SelectedStepState,
        builder: (context, state) {
          String _input = equipment;
          List<AreaStep> _steps = [];
          if (state is StepListState) {
            _steps = state.stepList;
          }
          if (state is SelectedStepState) {
            _input = state.step == null ? _input : state.step;
          }

          return EhsSearchListPicker(
            isEditable: isEditable,
            label: Labels.area2,
            list: _steps
                .map((element) => GenericListObject(title: element.step))
                .toList(),
            preselected: _input, //_area.step,
            selected: (data) {
              BlocProvider.of<AreaBloc>(context).selectedStep(data.title);
              getData(data.title);
            },
            tapped: () {
              BlocProvider.of<AreaBloc>(context).getStepes();
            },
            searchFor: (data) {
              //  areaBloc.searchAreas(data);
            },
          );
        });
  }
}
