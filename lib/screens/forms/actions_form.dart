import 'package:ehsfocus/models/action_model.dart';
import 'package:ehsfocus/shared/action_button.dart';
import 'package:ehsfocus/shared/audit_form_wraper.dart';
import 'package:ehsfocus/shared/charts/fields/custom_drop_down.dart';
import 'package:ehsfocus/shared/check_box.dart';
import 'package:ehsfocus/shared/constants.dart';
import 'package:ehsfocus/shared/datepiker.dart';
import 'package:ehsfocus/shared/text_field.dart';
import 'package:flutter/material.dart';

class ActionsFormWidget extends StatelessWidget {
  final AuditAction action;
  final String title;
  final int order;
  final Function getData;
  final Function goBack;
  ActionsFormWidget(
      {this.title, this.order, this.getData, this.action, this.goBack});


  @override
  Widget build(BuildContext context) {
    
  bool checkItem = false;
    AuditAction _action = AuditAction();
    _action = action ?? _action;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AuditFormWraper(
            title: title == null ? null : title,
            order: order == null ? '' : order,
            children: [
              EhsDropDown(
                  label: Lables.responsabile,
                  selected: (data) {
             
                  },
                  dropDownList: <String>['a', 'b', 'c', 'd'],
                  preselected:
                      _action == null ? null : _action.responsible),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: EhsCheckBox(
                  label: Lables.imidiateActtion,
                  value: _action.imidiatAcction ?? false,
                  setValue: (value) {
                      _action.imidiatAcction = value;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 12),
                child: DatePiker(
                    label: Lables.limitDate,
                    inputDate: (_action == null
                            ? null
                            : _action.limitDate) ??
                        null,
                    getDate: (data) {
                      _action.limitDate = data.toString();

                      print(data.toString());
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(right: 12),
                child: TextAreaWidget(
                  text: _action.comment,
                  onEdit: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditableTextAreaWidget(
                            text: _action.comment ?? '',
                            onEdit: (text) {
                           
                                _action.comment = text;
                           
                            },
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
          NavigateToNextPage(
            label: 'Inapoi la aspec',
            onPressed: () {
              goBack();
            },
          ),
        ],
      ),
    );
  }
}
