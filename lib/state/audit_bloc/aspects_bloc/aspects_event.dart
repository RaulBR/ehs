
abstract class AspectsEvent {
 
}

class GetAspects extends AspectsEvent {
  String auditId;
  GetAspects({this.auditId});
}

class GetAspect extends AspectsEvent {
  String  aspectId;
  GetAspect({this.aspectId});
}

class SigninLoading extends AspectsEvent {}

class CheckSinginEvent extends AspectsEvent {}

class SignOutEvent extends AspectsEvent {}
