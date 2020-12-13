import 'dart:async';
import 'package:bloc/bloc.dart';
part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final int pages;
  NavigationBloc(this.pages) : super(NavigationInitial.initial());

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    int currentPage;
    int index;
    switch (event.runtimeType) {
      case NavigateRightEvent:
        currentPage = event.currnetPage;
        index = currentPage + 1;
        if (index > pages - 1) {
          yield SubmitState();
          break;
        }
        yield NavigateState(index);
        break;
      case NavigateLeftEvent:
        currentPage = event.currnetPage;
        index = currentPage - 1;
        if (index < 0) {
          yield NavigateState(0);
          break;
        }
        yield NavigateState(index);
        break;
      case CurrentPageEvent:
        currentPage = event.currnetPage;
        index = currentPage - 1;

        yield NavigateState(event.currnetPage);

        break;
      default:
    }
  }

  void navigate(int direction, int curentPage) {
    if (direction == 1) {
      add(NavigateRightEvent(curentPage));
      return;
    }
    add(NavigateLeftEvent(curentPage));
  }

  void currentPage(int curentPage) {
    add(CurrentPageEvent(curentPage));
  }
}
