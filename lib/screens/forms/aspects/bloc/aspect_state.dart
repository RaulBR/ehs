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

class DataState extends AspectState {}

class LoadingState extends AspectState {}

class AspectTypes extends AspectState {
  final List<String> aspectTypes;
  AspectTypes({
    this.aspectTypes,
  });
}

class CategoryTypes extends AspectState {
  final List<String> aspectTypes;
  CategoryTypes({
    this.aspectTypes,
  });
}

class PhotoLoadingState extends AspectState {}

class ErrorState extends AspectState {}

class UpdateAspectState extends AspectState {
  final Aspect aspect;
  UpdateAspectState({this.aspect});
}
// maybe same as add

class UpdatePhotoState extends AspectState {
  final List<AspectPhoto> photos;

  UpdatePhotoState(this.photos);
}
