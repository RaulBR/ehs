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

  @override
  Stream<CategoryManagementState> mapEventToState(
    CategoryManagementEvent event,
  ) async* {
    switch (event.runtimeType) {
      case GetCategoryManagementEvent:

        // check empty list
        List<CategoryTypeResponsible> data =
            await _httpCategoryManagmentService.getCategoryTypeResponsible();
        print(data.toString());
        yield CategoryManagementListState(categoryTypeResponsibleList: data);

        break;
      case SetCategoryManagementEvent:
        try {
          await _httpCategoryManagmentService.setCategoryTypeResponsible(
              categoryType: event.categoryTypeResponsible);
          add(GetCategoryManagementEvent());
          break;
        } catch (e) {}
        break;
      case DeleteCategoryManagementEvent:
        await _httpCategoryManagmentService.deleteCategoryTypeResponsible(
            categoryType: event.categoryTypeResponsible);
        add(GetCategoryManagementEvent());
        break;

      default:
    }
  }
}
