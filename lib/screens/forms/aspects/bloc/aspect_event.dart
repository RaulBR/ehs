part of 'aspect_bloc.dart';

@immutable
abstract class AspectEvent {
  final AspectPhoto aspectPhoto;
  final Aspect aspect;
  AspectEvent({
    this.aspectPhoto,
    this.aspect,
  });
}

class AddAspectEvent extends AspectEvent {}

class DeleteAspectEvent extends AspectEvent {}

class UpdateAspectEvent extends AspectEvent {}

class SetAspect extends AspectEvent {
  final Aspect aspects;
  SetAspect({this.aspects});
}

class GetAspectPhotos extends AspectEvent {
  final Aspect aspect;
  GetAspectPhotos({this.aspect});
}

class DeleteAspectPhoto extends AspectEvent {
  final AspectPhoto aspectPhoto;

  DeleteAspectPhoto({this.aspectPhoto});
}
