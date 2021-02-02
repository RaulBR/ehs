part of 'category_management_bloc.dart';

abstract class CategoryManagementState extends Equatable {
  final CategoryTypeResponsible categoryTypeResponsible;
  final List<CategoryTypeResponsible> categoryTypeResponsibleList;
  const CategoryManagementState(
      {this.categoryTypeResponsibleList, this.categoryTypeResponsible});

  @override
  List<Object> get props =>
      [categoryTypeResponsible, categoryTypeResponsibleList];
}

class CategoryManagementInitial extends CategoryManagementState {}

class AddedCategoryManagemt extends CategoryManagementState {
  final CategoryTypeResponsible categoryTypeResponsible;
  AddedCategoryManagemt({this.categoryTypeResponsible});
}

class CategoryManagementListState extends CategoryManagementState {
  final List<CategoryTypeResponsible> categoryTypeResponsibleList;
  CategoryManagementListState({this.categoryTypeResponsibleList});
}

class CategoryManagementFormState extends CategoryManagementState {
  final CategoryTypeResponsible categoryTypeResponsible;
  CategoryManagementFormState({this.categoryTypeResponsible});
}
