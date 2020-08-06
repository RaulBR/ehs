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

  bool navigate() {
    return !_isAction;
  }
}
