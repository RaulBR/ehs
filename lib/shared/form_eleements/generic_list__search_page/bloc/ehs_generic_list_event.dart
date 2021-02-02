part of 'ehs_generic_list_bloc.dart';

abstract class EhsGenericListEvent extends Equatable {
  final bool isAddVisible;
  const EhsGenericListEvent({this.isAddVisible});

  @override
  List<Object> get props => [isAddVisible];
}

class AddVisibilittyEvent extends EhsGenericListEvent {
  final bool isAddVisible;
  AddVisibilittyEvent({this.isAddVisible});
}
