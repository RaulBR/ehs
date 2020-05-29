part of 'navigation_bloc.dart';

abstract class NavigationState {}

class NavigationInitial extends NavigationState {
    int page;
  NavigationInitial({this.page});
  factory NavigationInitial.initial() => NavigationInitial(page: 0);
}

class NavigateState extends NavigationState {
  int toPage;
  NavigateState(this.toPage);
}
class FirstPageState extends NavigationState {}
class SubmitState extends NavigationState {}
