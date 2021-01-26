import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:ehsfocus/theme.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ehsfocus/shared/constants.dart';

//TODO whis is this sateful?
class DatePiker extends StatefulWidget {
  final String inputDate;
  final String label;
  final Function getDate;
  final bool isEditable;
  final bool isTodaty;
  final Color color;
  DatePiker(
      {this.inputDate,
      this.label,
      this.getDate,
      this.color,
      this.isEditable,
      this.isTodaty});
  @override
  _DatePikerState createState() => _DatePikerState();
}

class _DatePikerState extends State<DatePiker> {
  var txt = TextEditingController();

  DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
  DateTime _dateTime;
  DateTime _date;
  @override
  void initState() {
    txt.text = widget.inputDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _date = widget.inputDate == null
        ? DateTime.now()
        : DateTime.parse(widget.inputDate);
    return InputContainer(
      child: FlatButton(
        padding: EdgeInsets.all(0),
        color: widget.color,
        onPressed: () {
          if (!widget.isEditable) {
            return;
          }
          showDatePicker(
                  context: context,
                  locale: const Locale("ro", "RO"),
                  fieldLabelText: widget.label,
                  initialDate: _date,
                  firstDate: DateTime(2016),
                  lastDate: DateTime(2222))
              .then((date) => {
                    setState(() => {
                          _dateTime = date,
                          widget.getDate(date),
                          txt.text = dateFormat.format(_dateTime)
                        })
                  });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(widget.label, style: labelFomat),
            // SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: AppColors.textSecundart,
                width: 1.0,
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 140,
                    child: TextFormField(
                      controller: txt,
                      enabled: false,
                      decoration: textInputDecoration.copyWith(
                          fillColor: Colors.grey[50], labelText: widget.label),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
