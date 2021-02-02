import 'package:ehsfocus/models/category/category_model.dart';
import 'package:ehsfocus/models/category/category_type_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {
  final CategoryType categorie;

  CategoryInitial({this.categorie});
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

class OneCategoryState extends CategoryState {
  final AuditCategory categorie;
  OneCategoryState({
    this.categorie,
  });
}

class CategorysState extends CategoryState {
  final List<AuditCategory> categoryes;
  CategorysState({
    this.categoryes,
  });
}

class DeleteCategoryState extends CategoryState {}
