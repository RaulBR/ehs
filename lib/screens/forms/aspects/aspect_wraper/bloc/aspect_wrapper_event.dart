part of 'aspect_wrapper_bloc.dart';

abstract class AspectWrapperEvent extends Equatable {
  final Aspect aspect;
  const AspectWrapperEvent({this.aspect});

  @override
  List<Object> get props => [aspect];
}

class ResetFormEvent extends AspectWrapperEvent {}

class ChangeFormEvent extends AspectWrapperEvent {}

class CheckIfValidEvent extends AspectWrapperEvent {
  final Aspect aspect;

  CheckIfValidEvent(this.aspect);
}
