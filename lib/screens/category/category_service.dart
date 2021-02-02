import 'package:ehsfocus/bloc/category/category_mentenance/category_management_bloc.dart';
import 'package:ehsfocus/bloc/category/category_state.dart';
import 'package:ehsfocus/models/category/category_type_responsible.dart';
import 'package:ehsfocus/models/employee/employee_model.dart';
import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_eleements/clerable%20_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategorySertvice {
  void openCategoryModal(context,
      {Function add, String selected, String title}) async {
    String _localValoue = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title == null ? Labels.addCategory : title),
          content: Container(
            height: 200,
            child: Column(
              children: [
                ClearableTextField(
                  enabled: true,
                  inputValue: selected,
                  label: title == null ? Labels.category : title,
                  onChanged: (data) {
                    _localValoue = data;
                  },
                  error: '',
                ),
                // Switch(
                //   value: false,
                //   onChanged: (value) {},
                // ),
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
              child: Text(Labels.addAnother),
              onPressed: () {
                add(_localValoue);
              },
            ),
            FlatButton(
              child: Text(Labels.add),
              onPressed: () {
                add(_localValoue);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  GenericListObject convertToGenericListObkect(
      CategoryTypeResponsible categoryResp) {
    return GenericListObject(
        id: categoryResp.id,
        title: generateName(categoryResp.responsible),
        subtitle: categoryResp.categoryType.type);
  }

  List<GenericListObject> handleCategorysStateChange(context, state) {
    if (state is CategorysTypesState) {
      return state.categoryes
          .map((d) => GenericListObject(id: d.id, title: d.type))
          .toList();
    }
    if (state is CategorysState) {
      return state.categoryes
          .map((e) => GenericListObject(id: e.id, title: e.category))
          .toList();
    }
    if (state is CategoryManagementListState) {
      return state.categoryTypeResponsibleList
          .map((e) => convertToGenericListObkect(e))
          .toList();
    }
    return [];
  }

  String generateName(Employee employee) {
    if (employee == null) {
      return '';
    }
    String result;

    result = employee.firstName;
    result =
        employee.lastName != null ? '$result ${employee.lastName}' : result;
    return result;
  }
}
