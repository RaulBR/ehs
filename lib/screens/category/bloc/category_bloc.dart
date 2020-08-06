import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/category_model.dart';

import 'package:ehsfocus/services/http/http_category.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());
  HttpCategoryService httpCategoryService = HttpCategoryService();
  List<CategoryType> _categoryesType = [];
  CategoryType _selectedCategoryType;
  List<Category> categoryes = [
    Category(id: '1', category: 'Categoria 1'),
    Category(id: '2', category: 'Categoria 2333'),
    Category(id: '3', category: 'Categoria 3')
  ];

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    switch (event.runtimeType) {
      case GetCategoryTypeEvent:
        dynamic data = await httpCategoryService.getCategoryTypes();
        _categoryesType = data;
        // if (areaHead.area != null) {

        yield CategorysTypesState(categoryes: data);
        // }
        break;
      case GetCategorysEvent:
        categoryes = _selectedCategoryType?.categories ?? [];
        yield CategorysState(categoryes: categoryes ?? []);
        // String area = event.area;
        // yield StepListState(stepList: areas[area]);
        break;
      default:
      //   yield CategoryTypesState();
    }
  }

  getCategoryes() {
    add(GetCategoryTypeEvent());
  }

  selectedType(id) {
    _selectedCategoryType = _categoryesType
        .firstWhere((element) => element.id == id, orElse: () => null);
  }
}
