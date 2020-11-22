import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/generic_list_model.dart';
import 'package:meta/meta.dart';
part 'search_picker_event.dart';
part 'search_picker_state.dart';

class SearchPickerBloc extends Bloc<SearchPickerEvent, SearchPickerState> {
  SearchPickerBloc() : super(SearchPickerInitial());
  List<String> localList = [];
  @override
  Stream<SearchPickerState> mapEventToState(
    SearchPickerEvent event,
  ) async* {
    yield ElementListItems(values: []);
    yield ListLoadoing();
    switch (event.runtimeType) {
      case SetAll:
        print(event.data);
        yield ElementListItems(values: event.data ?? []);
        break;
      case SearchFor:
        print(localList);
        List<String> searchList = [];
        if (event.search == '') {
          searchList = localList;
        } else {
          searchList = [];
        }

        searchList = localList
            .where((e) => e.toUpperCase().contains(event.search.toUpperCase()))
            .toList();

        yield ElementListItems(values: mapFromString(searchList) ?? []);
        break;
      case SelectedValueEvent:
        yield SetValue(selectValue: event.search);
        break;
      default:
        yield ElementListItems(values: event.data ?? []);
    }
  }

  loadElements(List<String> data) {
    localList = data;

    add(SetAll(data: mapFromString(data)));
  }

  search(String data) {
    add(SearchFor(search: data));
  }

  setValue(String data) {
    add(SelectedValueEvent(search: data));
  }

  void loadFormObjectList(List<dynamic> list, {String id, String type}) {
    List<GenericListObject> listElements = mapFrom(list, id: id, type: type);
    add(SetAll(data: listElements));
  }

  void loadList(
    List<GenericListObject> list,
  ) {
    add(SetAll(data: list ?? []));
  }

  List<GenericListObject> mapFrom(List<dynamic> list,
      {String id, String type}) {
    if (list == null) {
      return [];
    }
    id = id ?? 'id';
    type = type ?? 'type';
    return list
        .map((e) => GenericListObject(id: e[id], title: e[type]))
        .toList();
  }

  List<GenericListObject> mapFromString(List<dynamic> list) {
    int i = 0;
    return list.map((e) => GenericListObject(id: '${i++}', title: e)).toList();
  }
}
