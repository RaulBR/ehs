import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/category_model.dart';

import 'package:ehsfocus/services/http/http_category.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    getCategoryesTypes();
  }
  HttpCategoryService httpCategoryService = HttpCategoryService();
  List<CategoryType> _categoryesType = [];
  CategoryType _selectedCategoryType = CategoryType();
  Category _selectedCategory = Category();
  CategoryType _initialStateCategoryType = CategoryType();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    switch (event.runtimeType) {
      case GetCategoryTypeEvent:
        if (_categoryesType.length == 0) {
          dynamic data = await httpCategoryService.getCategoryTypes();
          _categoryesType = data;
        }
        yield CategorysTypesState(categoryes: _categoryesType);

        break;
      case GetCategorysEvent:
        if (_selectedCategoryType == null) {
          yield CategorysState(categoryes: []);
          break;
        }
        yield CategorysState(
            categoryes: _selectedCategoryType.categories ?? []);

        break;
      case PropagateCategoryTypeEvent:
        yield OneCategoryTypesState(categorie: _selectedCategoryType);
        break;
      case PropagateCategoryEvent:
        yield OneCategoryState(categorie: _selectedCategory);
        break;
      case ClearCategoryEvent:
        yield CategorysState(categoryes: []);
        break;
      case DeleteCategoryEvent:
        CategoryType categoryType =
            event is DeleteCategoryEvent ? event.categoryType : null;
        dynamic data = await httpCategoryService.deleteCategoryTypes(
            categoryType: categoryType);
        _categoryesType = data;
        yield CategorysTypesState(categoryes: _categoryesType);
        break;
      case SetCategoryTypeEvent:
        CategoryType toBeSated =
            event is SetCategoryTypeEvent ? event.categoryType : null;
        dynamic data =
            await httpCategoryService.setCategoryType(categoryType: toBeSated);
        _categoryesType.add(data);
        yield CategorysTypesState(categoryes: _categoryesType);
        break;
      default:
        yield OneCategoryTypesState(categorie: _selectedCategoryType);
    }
  }

  getCategoryesTypes() {
    add(GetCategoryTypeEvent());
  }

  getCategoryes() {
    add(GetCategorysEvent());
  }

  saveCategoryType(CategoryType categoryType) {
    print(categoryType == _initialStateCategoryType);
    add(SetCategoryTypeEvent(categoryType));
  }

  /*
  add category localoy
  wiull walidate if the category already exists
 */
  addCategory(String category) {
    if (category == null || category == '') {
      return;
    }
    _selectedCategoryType.categories = _selectedCategoryType.categories ?? [];
    if (_categoryExists(category)) {
      add(CategoryError(errorMessage: 'Categoria exista'));
      return;
    }
    _selectedCategoryType.categories.add(Category(category: category));
    add(PropagateCategoryTypeEvent());
  }

  getForCategoryType(String categoryType) {
    _selectedCategoryType = _categoryesType.firstWhere(
        (element) => element.type == categoryType,
        orElse: () => CategoryType());
  }

  addCategoryType(CategoryType categoryType) {
    _selectedCategoryType = categoryType;
  }

  selectedType(id) {
    if (id == null) {
      _selectedCategoryType = CategoryType();
      add(PropagateCategoryTypeEvent());
      _initialStateCategoryType =
          CategoryType.fromJson(_selectedCategoryType.toJson());
      return;
    }
    _selectedCategoryType = _categoryesType
        .firstWhere((element) => element.id == id, orElse: () => null);
    _initialStateCategoryType =
        CategoryType.fromJson(_selectedCategoryType.toJson());
    add(ClearCategoryEvent());
    add(PropagateCategoryTypeEvent());
  }

  setCategoryType(String data) {
    _selectedCategoryType.type = data;
  }

  editCategory(int index, String newValue) {
    if (newValue == null) {
      return;
    }
    if (_categoryExists(newValue)) {
      add(CategoryError(errorMessage: 'Categoria exista'));
      return;
    }
    _selectedCategoryType.categories[index].category = newValue;
    add(PropagateCategoryTypeEvent());
  }

  deleteCategoryType(String id) {
    add(DeleteCategoryEvent(categoryType: CategoryType(id: id)));
  }

  deleteCategory(Category category) {}

  // bool _categoryTypeExists(categoryType) {
  //   if (_selectedCategoryType.categories == null) {
  //     return false;
  //   }
  //   return _categoryesType.singleWhere((it) => it.type == categoryType,
  //           orElse: () => null) !=
  //       null;
  // }

  bool _categoryExists(category) {
    if (_selectedCategoryType.categories == null) {
      return false;
    }
    return _selectedCategoryType.categories
            .singleWhere((it) => it.category == category, orElse: () => null) !=
        null;
  }

  void selectCategory(id) {
    if (id == null || _selectedCategoryType == null) {
      return;
    }
    _selectedCategory = _selectedCategoryType.categories
        .firstWhere((element) => element.id == id, orElse: () => null);

    add(ClearCategoryEvent());
    add(PropagateCategoryEvent());
  }

  void selectedTypeName(String categoryType) {}
}
