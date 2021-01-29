import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ehs_generic_list_event.dart';
part 'ehs_generic_list_state.dart';

class EhsGenericListBloc
    extends Bloc<EhsGenericListEvent, EhsGenericListState> {
  EhsGenericListBloc() : super(EhsGenericListInitial());
  bool _isVisible = true;
  @override
  Stream<EhsGenericListState> mapEventToState(
    EhsGenericListEvent event,
  ) async* {
    if (event is AddVisibilittyEvent) {
      _isVisible = event.isAddVisible == null ? _isVisible : event.isAddVisible;
      yield (IsAddVisible(isAddVisible: event.isAddVisible));
    }
  }
}
