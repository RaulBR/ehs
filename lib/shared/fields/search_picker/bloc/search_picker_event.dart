part of 'search_picker_bloc.dart';

@immutable
abstract class SearchPickerEvent {
  final String search;
  final List<DropDown> data;
  SearchPickerEvent({
    this.search,
    this.data,
  });
}

class SearchFor extends SearchPickerEvent {
  final String search;
  SearchFor({
    this.search,
  });
}

class SetAll extends SearchPickerEvent {
  final List<DropDown> data;
  SetAll({
    this.data,
  });
}

class SelectedValueEvent extends SearchPickerEvent {
  final String search;
  SelectedValueEvent({
    this.search,
  });
}
