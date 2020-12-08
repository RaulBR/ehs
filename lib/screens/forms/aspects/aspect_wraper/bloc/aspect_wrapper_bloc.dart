import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/action_model.dart';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:equatable/equatable.dart';

part 'aspect_wrapper_event.dart';
part 'aspect_wrapper_state.dart';

class AspectWrapperBloc extends Bloc<AspectWrapperEvent, AspectWrapperState> {
  AspectWrapperBloc() : super(AspectWrapperInitial());
  bool _isPhoto = true;
  bool _isEditable = false;
  @override
  Stream<AspectWrapperState> mapEventToState(
    AspectWrapperEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ResetFormEvent:
        break;

      case ChangeFormEvent:
        _isPhoto = !_isPhoto;
        yield FormPageSate(_isPhoto);
        yield EditableSate(_isEditable);
        break;
      case CheckIfValidEvent:
        Aspect _aspect = event.aspect;
        AuditAction action = _aspect.action;
        if (_aspect.type == 'N') {
          if (_aspect.action == null) {
            _isEditable = false;
            yield EditableSate(false);
            break;
          }
          if (action.limitDate == null) {
            _isEditable = false;
            yield EditableSate(false);
            break;
          }
        }
        if (_aspect.category == null || _aspect.categoryType == null) {
          _isEditable = false;
          yield EditableSate(false);
          break;
        }
        _isEditable = true;
        yield EditableSate(true);
        break;
      // yield UpdateAspectState(null);
    }
  }
}
