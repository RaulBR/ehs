import 'package:ehsfocus/shared/form_container.dart';
import 'package:ehsfocus/theme.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ehsfocus/shared/constants.dart';

class DatePiker extends StatefulWidget {
  final String inputDate;
  final String label;
  final DateTime date;
  final Function getDate;
  final Color color;
  DatePiker({this.inputDate, this.label, this.getDate, this.color, this.date});
  @override
  _DatePikerState createState() => _DatePikerState();
}

class _DatePikerState extends State<DatePiker> {
  var txt = TextEditingController();

  DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
  DateTime _dateTime;

  @override
  void initState() {
    txt.text = widget.inputDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: FlatButton(
        padding: EdgeInsets.all(0),
        color: widget.color,
        onPressed: () {
          showDatePicker(
                  context: context,
                  locale: const Locale("ro", "RO"),
                  fieldLabelText: widget.label,
                  initialDate:
                      widget.date == null ? DateTime.now() : widget.date,
                  firstDate: DateTime(2016),
                  lastDate: DateTime(2222))
              .then((date) => {
                    setState(() => {
                          _dateTime = date,
                          widget.getDate(date),
                          print(date),
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
                      // initialValue: widget.inputDate == null ? null :  widget.inputDate,
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
