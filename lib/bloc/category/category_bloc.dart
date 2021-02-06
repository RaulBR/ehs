import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ehsfocus/bloc/category/category_state.dart';
import 'package:ehsfocus/bloc/category/category_event.dart';
import 'package:ehsfocus/models/category/category_model.dart';
import 'package:ehsfocus/models/category/category_type_model.dart';
import 'package:ehsfocus/services/repository/category_repo.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    getCategoryesTypes();
  }
  CategoryRepo _categoryRepo = CategoryRepo();
  List<CategoryType> _categoryesType = [];
  CategoryType _selectedCategoryType = CategoryType();
  AuditCategory _selectedCategory = AuditCategory();
  CategoryType _initialStateCategoryType = CategoryType();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    switch (event.runtimeType) {
      case GetCategoryTypeEvent:
        if (_categoryesType.length == 0) {
          dynamic data = await _categoryRepo.getCategoryTypes();
          _categoryesType = data;
        }
        yield CategorysTypesState(categoryes: _categoryesType);

        break;
      case GetCategorysEvent:
        if (event is GetCategorysEvent)
          _selectedCategoryType = await _categoryRepo
              .getCategoryTypeByType(event.categoryType.type);
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
        dynamic data =
            await _categoryRepo.deleteCategoryTypes(categoryType: categoryType);
        _categoryesType = data;
        yield CategorysTypesState(categoryes: _categoryesType);
        break;
      case SetCategoryTypeEvent:
        CategoryType toBeSated =
            event is SetCategoryTypeEvent ? event.categoryType : null;
        dynamic data =
            await _categoryRepo.setCategoryType(categoryType: toBeSated);
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

  getCategoryes(String categoryTypeIn) {
    CategoryType categoryType = CategoryType(type: categoryTypeIn);
    add(GetCategorysEvent(categoryType));
  }

  saveCategoryType(CategoryType categoryType) {
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
    _selectedCategoryType.categories.add(AuditCategory(category: category));
    add(PropagateCategoryTypeEvent());
  }

  getForCategoryType(String categoryType) {
    if (_categoryesType.length == 0) {
      add(GetCategoryTypeEvent());
      return;
    }

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

  deleteCategory(AuditCategory category) {}

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

  void addGetCategoryTypeEvent() {
    add(GetCategoryTypeEvent());
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
  getCategoryformId(id) {
    _selectedCategoryType = _categoryesType
        .firstWhere((element) => element.id == id, orElse: () => null);
    add(PropagateCategoryTypeEvent());
    return _selectedCategoryType;
  }
}
