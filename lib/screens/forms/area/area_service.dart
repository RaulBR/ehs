import 'package:ehsfocus/bloc/area/area_bloc.dart';
import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/bloc/employee/employee_bloc.dart';
import 'package:ehsfocus/screens/forms/shared_form_components/generic_element.dart';
import 'package:ehsfocus/shared/form_eleements/generic_list__search_page/bloc/ehs_generic_list_bloc.dart';
import 'package:ehsfocus/shared/form_eleements/lists/ehs_generic_animated_lsit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AreaService {
  List<GenericListObject> addEmployeesToDropDown(context, state) {
    if (state is EmployeesValueState) {
      return state.employees
          .map((employee) => GenericListObject(
              id: employee.id,
              title: '${employee.firstName} ${employee.lastName}',
              subtitle: employee.role ?? null))
          .toList();
    }
    return [];
  }

  List<GenericListObject> areaListToGenericList(state) {
    return state is AreaListState
        ? state.areaList
            .map((e) => GenericListObject(id: e.id, title: e.area))
            .toList()
        : [];
  }

  openBootomSheet(context, Widget widget) {
    return Scaffold.of(context).showBottomSheet(
      (context) => widget,
      clipBehavior: Clip.hardEdge,
    );
  }

  void openSheet(BuildContext context, Widget widget, {id}) {
    showAddButton(context, false);
    PersistentBottomSheetController bottomSheetController =
        openBootomSheet(context, widget);
    bottomSheetController.closed.then((value) => showAddButton(context, true));
    if (id != null) {
      BlocProvider.of<AreaBloc>(context).setAreaFormById(id);
      return;
    }
    BlocProvider.of<AreaBloc>(context).clearForm();
  }

  void showAddButton(BuildContext context, bool flag) {
    BlocProvider.of<EhsGenericListBloc>(context)
        .add(AddVisibilittyEvent(isAddVisible: flag));
  }

  void deletteElemet(GlobalKey<AnimatedListState> _mylistKey, index, data,
      List<GenericListObject> list) {
    if (_mylistKey.currentState != null)
      _mylistKey.currentState.removeItem(
        index,
        (context, animation) => ListAnimation(
          animation: animation,
          child: GennericListElement(
            title: data.title,
          ),
        ),
      );
    if (index < list.length - 1) list.removeAt(index);
  }
}
