part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {
  final String typeId;
  CategoryEvent({
    this.typeId,
  });
}

class GetCategoryEvent extends CategoryEvent {}

class GetCategoryTypeEvent extends CategoryEvent {}

class GetCategorysEvent extends CategoryEvent {}

class SetCategoryEvent extends CategoryEvent {}

class SetCategoryTypeEvent extends CategoryEvent {}
