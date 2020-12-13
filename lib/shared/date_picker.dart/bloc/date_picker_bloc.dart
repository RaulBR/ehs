import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_picker_event.dart';
part 'date_picker_state.dart';

class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc() : super(DatePickerInitial());

  @override
  Stream<DatePickerState> mapEventToState(
    DatePickerEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ChangeDateEvent:
        if (event is ChangeDateEvent) {
          String date = event.dateString;
          yield DateValueChangeState(dateString: date);
        }
        break;
      default:
    }
  }

  setDate(String date) {
    if (date == null) {
      return;
    }
    add(ChangeDateEvent(dateString: date));
  }
}
