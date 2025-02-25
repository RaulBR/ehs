import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ehsfocus/models/aspect/aspect_photo.dart';
import 'package:ehsfocus/models/aspect/aspects_model.dart';

import 'package:ehsfocus/services/repository/photo_repo.dart';
import 'package:ehsfocus/shared/photoComponents/camera_service.dart';
import 'package:equatable/equatable.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoInitial(null));
  final cameraService = CameraService();
  final _photoRepo = PhotoRepo();
  final List<AspectPhoto> photoList = [];
  @override
  Stream<PhotoState> mapEventToState(
    PhotoEvent event,
  ) async* {
    switch (event.runtimeType) {
      case GetPhotoEvent:
        if (event.photoSorce is Aspect) {
          Aspect aspect = event.photoSorce;
          if (aspect.photos == null) {
            yield ShowPhotoState(photo: AspectPhoto());
            break;
          }
          AspectPhoto photo;
          String photoName = aspect.photos[0].name;
          photo = await _photoRepo.getFromFile(photoName);

          if (photo != null) {
            aspect.photos[0].photo = photo.photo;
            yield ShowPhotoState(photo: aspect.photos[0]);
            break;
          }
          dynamic data =
              await this._photoRepo.getPhotosByAspectId(event.photoSorce);
          if (data.length > 0) {
            data.forEach((element) {
              photoList.add(element);
            });
            yield ShowPhotoState(photo: photoList[0]);
          }
        }
        break;
      case ChangePhotoEvent:
        yield ShowPhotoState(photo: event.photoSorce);
        break;
      case DeletePhotoEvent:
        if (event.photoSorce is AspectPhoto) {
          try {
            await this._photoRepo.deleteAspectPhoto(event.photoSorce);

            yield ShowPhotoState(photo: AspectPhoto());
            yield DeletedPicture(photo: event.photoSorce);
            break;
          } catch (e) {
            print(e);
          }
        }
        break;
      case RefreshPhotoEvent:
        if (event is GetPhotoEvent && event.photoSorce is Aspect) {
          dynamic data =
              await this._photoRepo.getPhotosByAspectId(event.photoSorce);
          if (data != null) {
            yield ShowPhotoState(photo: data);
          }
        }
        break;
      default:
    }
  }
}
