part of 'search_picker_bloc.dart';

@immutable
abstract class SearchPickerState {}

class SearchPickerInitial extends SearchPickerState {
  final List<String> values = null;
}

class ElementListItems extends SearchPickerState {
  final List<DropDown> values;
  ElementListItems({
    this.values,
  });
}

class SetValue extends SearchPickerState {
  final String selectValue;
  SetValue({
    this.selectValue,
  });
}

class ListLoadoing extends SearchPickerState {}
