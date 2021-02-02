import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/models/area/area_step_model.dart';
import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/fields/search_picker/custom_list_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EquipmantDroptDownPicker extends StatelessWidget {
  final String area;
  final String equipment;
  final bool isEditable;
  final Function getData;

  const EquipmantDroptDownPicker(
      {Key key, this.equipment, this.getData, this.isEditable, this.area})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (equipment == null) {
      BlocProvider.of<AreaBloc>(context).celarSelected();
    }

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
            BlocProvider.of<AreaBloc>(context).getStepes(area);
          },
          searchFor: (data) {
            //  areaBloc.searchAreas(data);
          },
        );
      },
    );
  }
}
