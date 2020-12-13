import 'package:ehsfocus/shared/date_picker.dart/bloc/date_picker_bloc.dart';
import 'package:ehsfocus/shared/form_eleements/form_container.dart';
import 'package:ehsfocus/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ehsfocus/shared/constants.dart';

class DatePiker2 extends StatelessWidget {
  final String inputDate;
  final String label;
  final Function getDate;
  final bool isEditable;
  final bool isTodaty;
  final Color color;

  const DatePiker2(
      {Key key,
      this.inputDate,
      this.label,
      this.getDate,
      this.isEditable,
      this.isTodaty,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String _inputDate = inputDate;
    var txt = TextEditingController();

    return BlocProvider(
      create: (context) {
        DatePickerBloc a = DatePickerBloc();
        return a;
      },
      child: InputContainer(
        child: BlocBuilder<DatePickerBloc, DatePickerState>(
          builder: (context, state) {
            if (isTodaty) {
              txt.text = inputDate == null
                  ? dateFormat.format(DateTime.now())
                  : _inputDate;
            } else {
              txt.text =
                  state.dateString == null ? _inputDate : state.dateString;
              _inputDate = state.dateString;
            }

            return FlatButton(
              padding: EdgeInsets.all(0),
              color: color,
              onPressed: !isEditable
                  ? null
                  : () async {
                      DateTime _date = _inputDate == null
                          ? DateTime.now()
                          : dateFormat.parse(_inputDate);
                      // DateTime _date = DateTime.now();
                      DateTime value = await showDatePicker(
                          context: context,
                          locale: const Locale("ro", "RO"),
                          fieldLabelText: label,
                          initialDate: _date == null ? DateTime.now() : _date,
                          firstDate: DateTime(2016),
                          lastDate: DateTime(2222));

                      BlocProvider.of<DatePickerBloc>(context)
                          .setDate(dateFormat.format(value));
                      getDate(value);
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
                                fillColor: Colors.grey[50], labelText: label),
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
            );
          },
        ),
      ),
    );
  }
}
