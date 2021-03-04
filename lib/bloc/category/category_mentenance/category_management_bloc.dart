import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/category/category_type_responsible.dart';
import 'package:ehsfocus/services/http/http_category_management.dart';
import 'package:equatable/equatable.dart';
part 'category_management_event.dart';
part 'category_management_state.dart';

class CategoryManagementBloc
    extends Bloc<CategoryManagementEvent, CategoryManagementState> {
  CategoryManagementBloc() : super(CategoryManagementInitial()) {
    add(GetCategoryManagementEvent());
  }
  HttpCategoryManagmentService _httpCategoryManagmentService =
      HttpCategoryManagmentService();
  List<CategoryTypeResponsible> _data = [];
  @override
  Stream<CategoryManagementState> mapEventToState(
    CategoryManagementEvent event,
  ) async* {
    switch (event.runtimeType) {
      case GetCategoryManagementEvent:

        // check empty list
        _data =
            await _httpCategoryManagmentService.getCategoryTypeResponsible();

        yield CategoryManagementListState(categoryTypeResponsibleList: _data);

        break;
      case SetCategoryManagementEvent:
        try {
          CategoryTypeResponsible e =
              await _httpCategoryManagmentService.setCategoryTypeResponsible(
                  categoryType: event.categoryTypeResponsible);
          yield AddedCategoryManagemt(categoryTypeResponsible: e);
          _data.add(e);
          //add(GetCategoryManagementEvent());
          break;
        } catch (e) {}
        break;
      case DeleteCategoryManagementEvent:
        CategoryTypeResponsible category = _data.firstWhere(
            (element) => element.id == event.categoryTypeResponsible.id);
        await _httpCategoryManagmentService.deleteCategoryTypeResponsible(
            categoryType: category);
        add(GetCategoryManagementEvent());
        break;
      case UpdateListEvent:
        yield CategoryManagementListState(categoryTypeResponsibleList: _data);
        break;
      default:
    }
  }

  CategoryTypeResponsible setCategoryByid(String id) {
    return _data.firstWhere((element) => element.id == id);
  }
}
