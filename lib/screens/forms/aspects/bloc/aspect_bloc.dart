import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';
import 'package:ehsfocus/services/http/http_audit.dart';
import 'package:meta/meta.dart';
part 'aspect_event.dart';
part 'aspect_state.dart';

class AspectBloc extends Bloc<AspectEvent, AspectState> {
  AspectBloc() : super(AspectInitial.initial());
  final httpAuditService = HttpAuditService();
  List<Aspect> _audits = [];
  int _index = 0;
  @override
  Stream<AspectState> mapEventToState(
    AspectEvent event,
  ) async* {
    switch (event.runtimeType) {
      case RejectAspect:
        yield LoadingState();
        try {
          await this.httpAuditService.rejectAspect(event.aspect);
          Timer(Duration(seconds: 1), () {
            add(GetAspectsToApprove());
          });
        } catch (e) {
          AspectError(error: e);
          Timer(Duration(seconds: 1), () {
            add(GetAspectsToApprove());
          });
        }

        break;
      case ResolveAspect:
        yield LoadingState();
        try {
          this.httpAuditService.resolveAspect(event.aspect);
          Timer(Duration(seconds: 1), () {
            add(GetAspectsToApprove());
          });

          // yield AspectToHandleState(audits);
        } catch (e) {
          AspectError(error: e);
          Timer(Duration(seconds: 1), () {
            add(GetAspectsToApprove());
          });
        }

        break;
      case AcceptAspect:
        yield LoadingState();
        try {
          await this.httpAuditService.acceptAspect(event.aspect);
          Timer(Duration(seconds: 1), () {
            add(GetAspectsToApprove());
          });
        } catch (e) {
          AspectError(error: e);
          Timer(Duration(seconds: 1), () {
            add(GetAspectsToApprove());
            getNextIndex();
          });
        }

        break;
      case GetAspectsToApprove:
        try {
          _audits = await httpAuditService.getAuditsToApprove();
          getNextIndex();
          yield AspectToHandleState(_audits);
          break;
        } catch (e) {
          yield AspectError(error: e);
          yield AspectToHandleState([]);
          break;
        }
        break;
      case GetAspectsForMe:
        try {
          _audits = await httpAuditService.getAuditsToFix();
          yield AspectToHandleState(_audits);
          break;
        } catch (e) {
          yield AspectError(error: e);
          break;
        }
        break;

      case GetMyRejectedAspectsEvent:
        try {
          _audits = await httpAuditService.getMyRejectedAudits();
          yield AspectToHandleState(_audits);
          break;
        } catch (e) {
          yield AspectError(error: e);
          break;
        }
        break;

      case AspectIndexEvent:
        try {
          yield AspectIndexState(index: 0);
          break;
        } catch (e) {
          yield AspectError(error: e);
          break;
        }
        break;
      // yield UpdateAspectState(null);
    }
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

  void getMyRejectedAspects() {
    add(GetMyRejectedAspectsEvent());
  }

  void rejectAspect({Aspect aspect}) {
    findIndex(aspect);
    add(RejectAspect(aspect: aspect));
  }

  void acceptAspect({Aspect aspect}) {
    findIndex(aspect);
    add(AcceptAspect(aspect: aspect));
  }

  void resolveAspect({Aspect aspect}) {
    findIndex(aspect);
    add(ResolveAspect(aspect: aspect));
  }

  void findIndex(aspect) {
    _index = _audits.indexWhere((element) => element.id == aspect.id);
  }

  void getNextIndex() {
    int size = _audits.length;
    if (size == 0) {
      _index = -1;
      return;
    }
    if (size <= _index) {
      _index = size - 1;
      return;
    }
  }

  int getIndex() {
    return _index;
  }
}
