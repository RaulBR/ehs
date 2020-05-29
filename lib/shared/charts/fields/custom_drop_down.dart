import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/form_container.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';


class EhsDropDown extends StatelessWidget {
  final String label;
  final String area;
  final List<String> dropDownList;
  final String preselected;
  final Function selected;
  final bool hasEmpty;
  EhsDropDown(
      {
      this.area,
      this.preselected, 
      this.dropDownList,
      @required this.selected,
      this.hasEmpty,
      this.label});
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
                decoration: textInputDecoration.copyWith(
                        labelText: label,
                      ),
            value: preselected == null ? null : preselected,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            isExpanded: true,
            elevation: 16,
            style: TextStyle(color: AppColors.textPrimery),
            onChanged: (String newValue) {
              selected(newValue);
            },
            items: (dropDownList == null
                    ? <String>['One', 'Two', 'Free', 'Four']
                    : dropDownList)
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ));
  }
}
