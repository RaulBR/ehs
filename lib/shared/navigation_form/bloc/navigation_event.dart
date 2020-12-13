part of 'navigation_bloc.dart';

abstract class NavigationEvent {
  final int currnetPage;

  NavigationEvent(this.currnetPage);
}

class NavigateLeftEvent extends NavigationEvent {
  NavigateLeftEvent(int currnetPage) : super(currnetPage);
}

class NavigateRightEvent extends NavigationEvent {
  NavigateRightEvent(int currnetPage) : super(currnetPage);
}

class CurrentPageEvent extends NavigationEvent {
  CurrentPageEvent(int currnetPage) : super(currnetPage);
}

class SubmitRightEvent extends NavigationEvent {
  SubmitRightEvent(int currnetPage) : super(currnetPage);
}
