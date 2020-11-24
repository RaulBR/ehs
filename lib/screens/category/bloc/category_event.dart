part of 'category_bloc.dart';

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

class GetCategorysEvent extends CategoryEvent {}

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

class PropagateCategoryTypeEvent extends CategoryEvent {}

class PropagateCategoryEvent extends CategoryEvent {}
