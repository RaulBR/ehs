part of 'aspect_bloc.dart';

@immutable
abstract class AspectState {}

class AspectInitial extends AspectState {
  final Aspect aspect;
  AspectInitial({this.aspect});
  factory AspectInitial.initial() => AspectInitial(aspect: null);
}

class AuditPhotos extends AspectState {
  final List<dynamic> photos;
  AuditPhotos(this.photos);
}

class AspectToHandleState extends AspectState {
  final List<Aspect> aspects;
  AspectToHandleState(this.aspects);
}

class LoadingState extends AspectState {}

class PhotoLoadingState extends AspectState {}

class AspectIndexState extends AspectState {
  final int index;
  AspectIndexState({this.index = 0});
}

class AspectError extends AspectState {
  final dynamic error;
  AspectError({
    this.error,
  });
}
