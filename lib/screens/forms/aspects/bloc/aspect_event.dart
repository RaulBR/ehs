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

class GetAspectsToApprove extends AspectEvent {
  final List<Aspect> aspects;
  GetAspectsToApprove({this.aspects});
}

class AspectIndexEvent extends AspectEvent {
  final int index;
  AspectIndexEvent({this.index = 0});
}

class GetAspectsForMe extends AspectEvent {
  final List<Aspect> aspects;
  GetAspectsForMe({this.aspects});
}

class RejectAspect extends AspectEvent {
  final Aspect aspect;
  RejectAspect({this.aspect});
}

class ResolveAspect extends AspectEvent {
  final Aspect aspect;
  ResolveAspect({this.aspect});
}

class AcceptAspect extends AspectEvent {
  final Aspect aspect;
  AcceptAspect({this.aspect});
}

class DeleteAspectPhoto extends AspectEvent {
  final AspectPhoto aspectPhoto;

  DeleteAspectPhoto({this.aspectPhoto});
}
