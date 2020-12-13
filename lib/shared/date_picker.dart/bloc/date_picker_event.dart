part of 'date_picker_bloc.dart';

abstract class DatePickerEvent extends Equatable {
  const DatePickerEvent();

  @override
  List<Object> get props => [];
}

class ChangeDateEvent extends DatePickerEvent {
  final DateTime date;
  final String dateString;
  ChangeDateEvent({this.date, this.dateString});
}
