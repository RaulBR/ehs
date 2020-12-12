part of 'aspect_wrapper_bloc.dart';

abstract class AspectWrapperState extends Equatable {
  final bool isEditable;
  final bool isPhoto;
  const AspectWrapperState({this.isEditable, this.isPhoto});

  @override
  List<Object> get props => [isEditable, isPhoto];
}

class AspectWrapperInitial extends AspectWrapperState {
  final bool isPhoto = true;
}

class FormPageSate extends AspectWrapperState {
  final bool isPhoto;
  FormPageSate(this.isPhoto);
}

class EditableSate extends AspectWrapperState {
  final bool isEditable;
  EditableSate(this.isEditable);
}
