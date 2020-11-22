part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {
  // factory CategoryInitial.initial() => CategoryInitial();
}

class CategorysTypesState extends CategoryState {
  final List<CategoryType> categoryes;
  CategorysTypesState({
    this.categoryes,
  });
}

class OneCategoryTypesState extends CategoryState {
  final CategoryType categorie;
  OneCategoryTypesState({
    this.categorie,
  });
}

class CategorysState extends CategoryState {
  final List<Category> categoryes;
  CategorysState({
    this.categoryes,
  });
}

class SetCategoryTypesState extends CategoryState {}

class SetCategoryState extends CategoryState {}

class SetCategorysState extends CategoryState {}

class DeleteCategorysState extends CategoryState {}

class DeleteCategoryState extends CategoryState {}
