part of 'date_picker_bloc.dart';

abstract class DatePickerState extends Equatable {
  final String dateString;
  final DateTime date;
  const DatePickerState({this.dateString, this.date});

  @override
  List<Object> get props => [dateString, date];
}

class DatePickerInitial extends DatePickerState {
  DatePickerInitial() : super();
}

class DateValueChangeState extends DatePickerState {
  final String dateString;
  final DateTime date;
  DateValueChangeState({this.dateString, this.date});
}
