part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  final AspectPhoto photo;
  const PhotoState({this.photo});

  @override
  List<Object> get props => [photo];
}

class PhotoInitial extends PhotoState {
  PhotoInitial(AspectPhoto photo);
}

class ShowPhotoState extends PhotoState {
  final AspectPhoto photo;

  ShowPhotoState({this.photo});
}

class DeletedPicture extends PhotoState {
  final AspectPhoto photo;

  DeletedPicture({this.photo});
}
