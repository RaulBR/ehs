import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/aspects_model.dart';
import 'package:ehsfocus/services/http/http_audit.dart';
import 'package:meta/meta.dart';
part 'aspect_event.dart';
part 'aspect_state.dart';

class AspectBloc extends Bloc<AspectEvent, AspectState> {
  AspectBloc() : super(AspectInitial.initial());
  final httpAuditService = HttpAuditService();

  List<String> types = [];
  bool _isAction;
  @override
  Stream<AspectState> mapEventToState(
    AspectEvent event,
  ) async* {
    switch (event.runtimeType) {
      case SetAspect:
        break;

      case DeleteAspectPhoto:
        if (event.aspectPhoto == null) {
          return;
        }
        dynamic data =
            await this.httpAuditService.deleteAspectPhoto(event.aspectPhoto);
        if (data != null) {
          // yield AuditPhotos(data);
        }

        break;
      case GetAspectPhotos:
        if (event.aspect == null) {
          return;
        }
        dynamic data =
            await this.httpAuditService.getPhotosByAspectId(event.aspect);
        if (data != null) {
          yield AuditPhotos(data);
        }
        break;
      case RejectAspect:
        yield LoadingState();
        try {
          await this.httpAuditService.rejectAspect(event.aspect);
          Timer(Duration(seconds: 1), () => add(GetAspectsToApprove()));
        } catch (e) {
          AspectError(error: e);
        }

        break;
      case ResolveAspect:
        yield LoadingState();
        try {
          this.httpAuditService.resolveAspect(event.aspect);
          Timer(Duration(seconds: 1), () => add(GetAspectsForMe()));

          // yield AspectToHandleState(audits);
        } catch (e) {
          AspectError(error: e);
        }

        break;
      case AcceptAspect:
        yield LoadingState();
        try {
          await this.httpAuditService.acceptAspect(event.aspect);
          Timer(Duration(seconds: 1), () => add(GetAspectsToApprove()));
        } catch (e) {
          AspectError(error: e);
        }

        break;
      case GetAspectsToApprove:
        try {
          List<Aspect> audits = await httpAuditService.getAuditsToApprove();
          yield AspectToHandleState(audits);
          break;
        } catch (e) {
          yield AspectError(error: e);
          break;
        }
        break;
      case GetAspectsForMe:
        try {
          List<Aspect> audits = await httpAuditService.getAuditsToFix();
          yield AspectToHandleState(audits);
          break;
        } catch (e) {
          yield AspectError(error: e);
          break;
        }
        break;
      // yield UpdateAspectState(null);
    }
  }

  void getAspectsPhotos(Aspect aspect) {
    if (aspect == null || aspect.id == null) {
      return;
    }
    add(GetAspectPhotos(aspect: aspect));
  }

  void deleteAspectPhoto(AspectPhoto aspectPhoto) {
    if (aspectPhoto == null || aspectPhoto.id == null) {
      return;
    }
  }

  void getAspectsToApprove() {
    add(GetAspectsToApprove());
  }

  void getAspectsForMe() {
    add(GetAspectsForMe());
  }

  void rejectAspect({Aspect aspect}) {
    add(RejectAspect(aspect: aspect));
  }

  void acceptAspect({Aspect aspect}) {
    add(AcceptAspect(aspect: aspect));
  }

  void resolveAspect({Aspect aspect}) {
    add(ResolveAspect(aspect: aspect));
  }

  bool navigate() {
    return !_isAction;
  }
}
