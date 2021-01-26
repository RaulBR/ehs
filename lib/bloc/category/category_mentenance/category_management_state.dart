part of 'category_management_bloc.dart';

abstract class CategoryManagementState extends Equatable {
  final CategoryTypeResponsible categoryTypeResponsible;
  // final List<CategoryTypeResponsible> categoryTypeResponsibleList;

  const CategoryManagementState({this.categoryTypeResponsible});

  @override
  List<Object> get props => [categoryTypeResponsible];
}

class CategoryManagementInitial extends CategoryManagementState {}

class CategoryManagementListState extends CategoryManagementState {
  final List<CategoryTypeResponsible> categoryTypeResponsibleList;
  CategoryManagementListState({this.categoryTypeResponsibleList});
}

class CategoryManagementFormState extends CategoryManagementState {
  final CategoryTypeResponsible categoryTypeResponsible;
  CategoryManagementFormState({this.categoryTypeResponsible});
}
