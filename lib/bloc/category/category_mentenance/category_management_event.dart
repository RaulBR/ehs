part of 'category_management_bloc.dart';

abstract class CategoryManagementEvent extends Equatable {
  final CategoryTypeResponsible categoryTypeResponsible;
  const CategoryManagementEvent({this.categoryTypeResponsible});

  @override
  List<Object> get props => [];
}

class SetCategoryManagementEvent extends CategoryManagementEvent {
  final CategoryTypeResponsible categoryTypeResponsible;

  SetCategoryManagementEvent(this.categoryTypeResponsible);
}

class DeleteCategoryManagementEvent extends CategoryManagementEvent {
  final CategoryTypeResponsible categoryTypeResponsible;

  DeleteCategoryManagementEvent(this.categoryTypeResponsible);
}

class UpdateListEvent extends CategoryManagementEvent {}

class GetCategoryManagementEvent extends CategoryManagementEvent {}
