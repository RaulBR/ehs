part of 'ehs_generic_list_bloc.dart';

abstract class EhsGenericListState extends Equatable {
  final bool isAddVisible;
  const EhsGenericListState({this.isAddVisible = true});

  @override
  List<Object> get props => [isAddVisible];
}

class EhsGenericListInitial extends EhsGenericListState {}

class IsAddVisible extends EhsGenericListState {
  final bool isAddVisible;
  IsAddVisible({this.isAddVisible});
}
