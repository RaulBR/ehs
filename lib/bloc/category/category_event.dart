import 'package:ehsfocus/models/category/category_type_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CategoryEvent {
  final String errorMessage;
  final String typeId;
  CategoryEvent({this.typeId, this.errorMessage});
}

class GetCategoryEvent extends CategoryEvent {}

class GetCategoryTypeEvent extends CategoryEvent {}

class CategoryError extends CategoryEvent {
  final String errorMessage;
  CategoryError({this.errorMessage});
}

class CategoryTypeError extends CategoryEvent {
  final String errorMessage;
  CategoryTypeError({this.errorMessage});
}

class GetCategorysEvent extends CategoryEvent {
  final CategoryType categoryType;
  GetCategorysEvent(this.categoryType);
}

class SetCategoryEvent extends CategoryEvent {}

class DeleteCategoryEvent extends CategoryEvent {
  final CategoryType categoryType;

  DeleteCategoryEvent({this.categoryType});
}

class SetCategoryTypeEvent extends CategoryEvent {
  final CategoryType categoryType;

  SetCategoryTypeEvent(this.categoryType);
}

class ClearCategoryEvent extends CategoryEvent {}

class CheckCategoryType extends CategoryEvent {}

class PropagateCategoryTypeEvent extends CategoryEvent {}

class PropagateCategoryEvent extends CategoryEvent {}
