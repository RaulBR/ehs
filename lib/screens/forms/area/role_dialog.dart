import 'package:ehsfocus/models/area/area_role_model.dart';
import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/screens/category/bloc/category_bloc.dart';
import 'package:ehsfocus/screens/forms/area/area_service.dart';
import 'package:ehsfocus/screens/forms/aspects/aspect_service.dart';
import 'package:ehsfocus/screens/forms/employee/bloc/employee_bloc.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/fields/search_picker/custom_list_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoleDialog extends StatefulWidget {
  final AreaRole areaRole;
  final Function add;

  const RoleDialog({Key key, this.add, this.areaRole}) : super(key: key);
  @override
  _RoleDialogState createState() => _RoleDialogState();
}

class _RoleDialogState extends State<RoleDialog> {
  AreaRole _areaRole = AreaRole();
  String _responsable;
  setResponsabile(GenericListObject data) {
    setState(() {
      _responsable = data.title;
    });
    // get if
    _areaRole.responsible =
        BlocProvider.of<EmployeeBloc>(context).getEmployee(data.id);
  }

  setArea(GenericListObject data) {
    setState(() {});
    _areaRole.role = data.title;
  }

  @override
  Widget build(BuildContext context) {
    _areaRole = widget.areaRole ?? _areaRole;
    return AlertDialog(
      title: Text('Seteaza responsabili'),
      content: Container(
        height: 250.0,
        width: double.maxFinite,
        child: Column(
          children: [
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) => EhsSearchListPicker(
                list:
                    AspectService().handleCategorysStateChange(context, state),
                error: null,
                label: Labels.aspectType,
                selected: (data) {
                  setArea(data);
                },
                tapped: () {
                  BlocProvider.of<CategoryBloc>(context)
                      .add(GetCategoryTypeEvent());
                },
                preselected: _areaRole.role,
              ),
            ),
            BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) => EhsSearchListPicker(
                list: AreaService().addEmployeesToDropDown(context, state),
                error: null,
                label: Labels.responsabile,
                selected: (data) {
                  setResponsabile(data);
                },
                tapped: () {
                  BlocProvider.of<EmployeeBloc>(context).getEmployees();
                },
                preselected: _responsable,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: Text(Labels.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(Labels.add),
          onPressed: () {
            if (_areaRole.responsible != null) {
              widget.add(_areaRole);
            }
            //    Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
