part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  final dynamic photoSorce;
  const PhotoEvent(this.photoSorce);

  @override
  List<Object> get props => [photoSorce];
}

class GetPhotoEvent extends PhotoEvent {
  GetPhotoEvent(photoSorce) : super(photoSorce);
}

class DeletePhotoEvent extends PhotoEvent {
  DeletePhotoEvent(photoSorce) : super(photoSorce);
}

class OpenCameraEvent extends PhotoEvent {
  OpenCameraEvent(photoSorce) : super(photoSorce);
}

class RefreshPhotoEvent extends PhotoEvent {
  RefreshPhotoEvent(photoSorce) : super(photoSorce);
}
